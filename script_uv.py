import os, re
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.signal import savgol_filter
from scipy.interpolate import interp1d
from scipy.integrate import trapezoid

def load_spectrum(path):
    df = pd.read_csv(path)
    if 'wavelength' in df.columns and 'absorbance' in df.columns:
        wl = df['wavelength'].values
        A = df['absorbance'].values
    else:
        wl = df.iloc[:,0].values
        A = df.iloc[:,1].values
    return wl, A

def smooth(A, window=11, poly=2):
    if window % 2 == 0:
        window += 1
    if len(A) < window:
        return A
    return savgol_filter(A, window_length=window, polyorder=poly)

def find_peak_metrics(wl, A, search_min=400, search_max=800):
    mask = (wl >= search_min) & (wl <= search_max)
    wl_s = wl[mask]; A_s = A[mask]
    # smoothing
    A_sm = smooth(A_s, window=11, poly=2)
    # peak index
    i_max = np.argmax(A_sm)
    lambda_max = wl_s[i_max]
    A_max = A_sm[i_max]
    # FWHM: find left/right crossings at A_max/2 by interpolation
    half = A_max / 2.0
    # left
    left_idx = np.where(A_sm[:i_max] < half)[0]
    if len(left_idx)>0:
        i_left = left_idx[-1]
        f_left = interp1d(A_sm[i_left:i_left+2], wl_s[i_left:i_left+2])
        wl_left = float(f_left(half))
    else:
        wl_left = wl_s[0]
    # right
    right_idx = np.where(A_sm[i_max:] < half)[0]
    if len(right_idx)>0:
        i_r = i_max + right_idx[0]
        f_right = interp1d(A_sm[i_r-1:i_r+1], wl_s[i_r-1:i_r+1])
        wl_right = float(f_right(half))
    else:
        wl_right = wl_s[-1]
    fwhm = wl_right - wl_left
    # area ±50 nm around peak (bounded by available wl)
    low = lambda_max - 50
    high = lambda_max + 50
    mask_area = (wl_s >= low) & (wl_s <= high)
    area = trapezoid(A_sm[mask_area], wl_s[mask_area]) if np.any(mask_area) else np.nan
    return lambda_max, A_max, fwhm, area

# main: read files in folder
folder = "spectra_folder"  
files = sorted([f for f in os.listdir(folder) if f.endswith('.csv')])
results = []

for fname in files:
    # expectation: filename contains batch and time info, e.g. B1_t0.csv
    m = re.match(r'(.*)_t(\d+)\.csv', fname)
    tag = fname
    tday = None
    if m:
        tag = m.group(1)
        tday = int(m.group(2))
    wl, A = load_spectrum(os.path.join(folder, fname))
    # if blank file exists named 'blank.csv' in folder, subtract it
    blank_path = os.path.join(folder, 'blank.csv')
    if os.path.exists(blank_path):
        wl_b, Ab = load_spectrum(blank_path)
        # interpolate blank to sample wavelengths
        f = interp1d(wl_b, Ab, bounds_error=False, fill_value="extrapolate")
        A_corr = A - f(wl)
    else:
        A_corr = A
    lam_max, Amax, fwhm, area = find_peak_metrics(wl, A_corr, search_min=400, search_max=800)
    results.append({'file': fname, 'tag': tag, 't_day': tday, 'lambda_max': lam_max,
                    'A_max': Amax, 'FWHM': fwhm, 'area': area})

df_res = pd.DataFrame(results).sort_values(['tag','t_day'])
# compute deltas relative to t0 per tag
final_rows = []
for tag, g in df_res.groupby('tag'):
    g = g.reset_index(drop=True)
    base = g.iloc[0]
    for _, row in g.iterrows():
        dlam = row['lambda_max'] - base['lambda_max']
        pctA = 100*(row['A_max'] - base['A_max'])/base['A_max'] if base['A_max']!=0 else np.nan
        pctF = 100*(row['FWHM'] - base['FWHM'])/base['FWHM'] if base['FWHM']!=0 else np.nan
        final_rows.append({**row.to_dict(), 'd_lambda': dlam, '%dA': pctA, '%dFWHM': pctF})
df_final = pd.DataFrame(final_rows)
print(df_final)
df_final.to_csv('uvvis_metrics_summary.csv', index=False)

# plot example: lambda_max vs time for each tag
for tag, g in df_final.groupby('tag'):
    plt.plot(g['t_day'], g['lambda_max'], marker='o', label=tag)
plt.xlabel('Time (days)')
plt.ylabel('λ_max (nm)')
plt.legend()
plt.tight_layout()
plt.show()

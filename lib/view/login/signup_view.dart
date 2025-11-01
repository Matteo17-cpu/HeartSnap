import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';
import 'package:heartsnap/common/round_button.dart';
import 'package:heartsnap/common/round_textfield.dart';
import 'package:heartsnap/view/login/login_view.dart';
import 'package:heartsnap/view/home/dashboard.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool isCheck = false;
  bool isPasswordObsecured = true;
  bool isRegistering = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    // Validasi input
    if (usernameController.text.trim().isEmpty) {
      _showSnackBar("Username tidak boleh kosong");
      return;
    }

    if (emailController.text.trim().isEmpty) {
      _showSnackBar("Email tidak boleh kosong");
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      _showSnackBar("Password tidak boleh kosong");
      return;
    }

    if (passwordController.text.length < 6) {
      _showSnackBar("Password minimal 6 karakter");
      return;
    }

    setState(() => isRegistering = true);

    try {
      // ✅ Gunakan Firebase Auth SDK untuk register
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ✅ Update display name user
      await userCredential.user?.updateDisplayName(usernameController.text.trim());
      
      // ✅ Reload user untuk refresh data
      await userCredential.user?.reload();

      if (!mounted) return;

      _showSnackBar("Register berhasil! Selamat datang ${usernameController.text}");

      // ✅ Navigate langsung ke Dashboard setelah register berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
      
    } on FirebaseAuthException catch (e) {
      String message;
      
      switch (e.code) {
        case 'weak-password':
          message = 'Password terlalu lemah. Gunakan kombinasi huruf, angka, dan simbol.';
          break;
        case 'email-already-in-use':
          message = 'Email sudah terdaftar. Silakan login atau gunakan email lain.';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid.';
          break;
        case 'operation-not-allowed':
          message = 'Operasi tidak diizinkan. Hubungi administrator.';
          break;
        case 'network-request-failed':
          message = 'Koneksi internet bermasalah. Cek koneksi Anda.';
          break;
        default:
          message = 'Register gagal: ${e.message ?? "Error tidak diketahui"}';
      }

      if (!mounted) return;
      _showSnackBar(message);
      
    } catch (e) {
      if (!mounted) return;
      _showSnackBar("Terjadi kesalahan: $e");
    } finally {
      if (mounted) {
        setState(() => isRegistering = false);
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: media.width * 0.1),
                
                Text(
                  "Hey there,",
                  style: TextStyle(color: TColor.gray, fontSize: 16),
                ),
                Text(
                  "Create an Account",
                  style: TextStyle(
                    color: TColor.secondaryColor2,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: media.width * 0.05),

                // Username Field
                RoundTextField(
                  controller: usernameController,
                  hitText: "Username",
                  icon: "assets/img/user_text.png",
                ),
                SizedBox(height: media.width * 0.04),

                // Email Field
                RoundTextField(
                  controller: emailController,
                  hitText: "Email",
                  icon: "assets/img/email.png",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: media.width * 0.04),

                // Password Field
                RoundTextField(
                  controller: passwordController,
                  hitText: "Password",
                  icon: "assets/img/lock.png",
                  obsecureText: isPasswordObsecured,
                  rightIcon: IconButton(
                    icon: Image.asset(
                      isPasswordObsecured
                          ? "assets/img/Hide.png"
                          : "assets/img/Unhide_Password.png",
                      width: 20,
                      height: 20,
                      color: TColor.gray,
                    ),
                    onPressed: () {
                      setState(() => isPasswordObsecured = !isPasswordObsecured);
                    },
                  ),
                ),

                SizedBox(height: media.width * 0.04),

                // Privacy Policy + Terms
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() => isCheck = !isCheck);
                      },
                      icon: Icon(
                        isCheck
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                        color: TColor.gray,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: TColor.gray, fontSize: 10),
                            children: [
                              const TextSpan(text: 'By continuing you accept our '),
                              TextSpan(
                                text: 'Privacy Policy ',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const TextSpan(text: 'and '),
                              TextSpan(
                                text: 'Terms of Use',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: media.width * 0.1),

                // Register Button
                RoundButton(
                  title: isRegistering ? "Registering..." : "Register",
                  type: isCheck
                      ? RoundButtonType.bgGradient
                      : RoundButtonType.textGradient,
                  onPressed: isCheck && !isRegistering ? register : null,
                ),

                SizedBox(height: media.width * 0.04),

                // Already have account
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: TColor.black, fontSize: 14),
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: TColor.secondaryColor2,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: media.width * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
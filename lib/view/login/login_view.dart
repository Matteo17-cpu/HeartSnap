import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';
import 'package:heartsnap/common/round_button.dart';
import 'package:heartsnap/common/round_textfield.dart';
import 'package:heartsnap/view/login/signup_view.dart';
import 'package:heartsnap/view/home/dashboard.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isCheck = false;
  bool isPasswordObsecured = true;
  bool isLoggingIn = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan password tidak boleh kosong.")),
      );
      return;
    }

    setState(() => isLoggingIn = true);

    try {
      // ✅ Gunakan Firebase Auth SDK untuk login
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ✅ Force reload user untuk memastikan state ter-update
      await userCredential.user?.reload();
      
      print("✅ Login successful for: ${userCredential.user?.email}");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login berhasil!"),
          duration: Duration(seconds: 1),
        ),
      );

      // ✅ ULTIMATE FIX: Navigate langsung ke Dashboard
      // AuthWrapper akan handle session persistence
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );

    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'Email tidak terdaftar. Silakan register terlebih dahulu.';
          break;
        case 'wrong-password':
          message = 'Password salah. Coba lagi atau reset password.';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid.';
          break;
        case 'user-disabled':
          message = 'Akun Anda telah dinonaktifkan.';
          break;
        case 'too-many-requests':
          message = 'Terlalu banyak percobaan login. Coba lagi nanti.';
          break;
        case 'network-request-failed':
          message = 'Koneksi internet bermasalah. Cek koneksi Anda.';
          break;
        case 'invalid-credential':
          message = 'Email atau password salah.';
          break;
        default:
          message = 'Login gagal: ${e.message ?? "Error tidak diketahui"}';
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    } finally {
      if (mounted) {
        setState(() => isLoggingIn = false);
      }
    }
  }

  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Masukkan email terlebih dahulu")),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email reset password telah dikirim. Cek inbox Anda.")),
      );
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'Email tidak terdaftar.';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid.';
          break;
        default:
          message = 'Gagal mengirim email: ${e.message}';
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
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
                  "Welcome Back",
                  style: TextStyle(
                    color: TColor.secondaryColor2,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: media.width * 0.05),

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
                      setState(() {
                        isPasswordObsecured = !isPasswordObsecured;
                      });
                    },
                  ),
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: TextSpan(
                        text: "Forgot your password?",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = resetPassword,
                      ),
                    ),
                  ),
                ),

                // Remember Me
                Row(
                  children: [
                    Checkbox(
                      value: isCheck,
                      onChanged: (val) {
                        setState(() {
                          isCheck = val ?? false;
                        });
                      },
                    ),
                    Text("Remember me", style: TextStyle(color: TColor.gray)),
                  ],
                ),

                SizedBox(height: media.width * 0.1),

                // Login Button
                RoundButton(
                  title: isLoggingIn ? "Logging in..." : "Login",
                  type: isCheck
                      ? RoundButtonType.bgGradient
                      : RoundButtonType.textGradient,
                  onPressed: isCheck && !isLoggingIn ? login : null,
                ),

                SizedBox(height: media.width * 0.04),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: TColor.gray.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      "  Or  ",
                      style: TextStyle(color: TColor.black, fontSize: 12),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: TColor.gray.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: media.width * 0.04),

                // Social Media Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton("assets/img/Google.png"),
                    SizedBox(width: media.width * 0.04),
                    _socialButton("assets/img/Facebook.png"),
                    SizedBox(width: media.width * 0.04),
                    _socialButton("assets/img/WhatsApp.png"),
                  ],
                ),

                SizedBox(height: media.width * 0.04),

                // Register Text
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: TColor.black, fontSize: 14),
                    children: [
                      const TextSpan(text: "Don't have an account yet? "),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          color: TColor.secondaryColor2,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpView(),
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

  Widget _socialButton(String assetPath) {
    return GestureDetector(
      onTap: () {
        // TODO: nanti integrasi sosial media
      },
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: TColor.white,
          border: Border.all(width: 1, color: TColor.gray.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(assetPath, width: 20, height: 20),
      ),
    );
  }
}
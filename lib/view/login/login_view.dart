import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';
import 'package:heartsnap/common/round_button.dart';
import 'package:heartsnap/common/round_textfield.dart';
import 'package:heartsnap/view/home/dashboard.dart';
import 'package:heartsnap/view/login/signup_view.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isCheck = false;
  bool isPasswordObsecured = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final response = await http.post(
      Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBXb9u_lV2inJjmM60_1TWc7EX65Lz7ulA",
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login berhasil!")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login gagal: ${response.body}")));
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
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: aksi reset password (nanti backend)
                              },
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

                SizedBox(height: media.width * 0.2),

                // Login Button
                RoundButton(
                  title: "Login",
                  type:
                      isCheck
                          ? RoundButtonType.bgGradient
                          : RoundButtonType.textGradient,
                  onPressed:
                      isCheck
                          ? () {
                            login();
                          }
                          : null,
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
                      const TextSpan(text: "Don’t have an account yet? "),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          color: TColor.secondaryColor2,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer:
                            TapGestureRecognizer()
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

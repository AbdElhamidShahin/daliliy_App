import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snackly/snackly.dart';
import '../Home Veiw.dart';
import 'RegisterScreen.dart';
import '../HomePage.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5AC8FA), Color(0xFF50E3C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Hero(
                  tag: "appLogo",
                  child: Image.asset(
                    'assets/Image/logoFront.png',
                    height: 180,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "تسجيل الدخول",
                  style: GoogleFonts.cairo(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // ====== Email ======
                _buildTextField(
                  hint: "البريد الإلكتروني",
                  icon: Icons.email_outlined,
                  onChanged: (v) => email = v,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "من فضلك أدخل البريد الإلكتروني";
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(v)) {
                      return "صيغة البريد الإلكتروني غير صحيحة";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ====== Password ======
                _buildTextField(
                  hint: "كلمة المرور",
                  icon: Icons.lock_outline,
                  onChanged: (v) => password = v,
                  obscure: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "من فضلك أدخل كلمة المرور";
                    }
                    if (v.length < 8) {
                      return "من فضلك اجعل كلمة المرور تتكون من 8 حروف على الأقل";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // ====== Button ======
                _buildButton(
                  text: "تسجيل الدخول",
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );

                        Snackly.success(
                          context: context,
                          title: "✅ تم التسجيل بنجاح، جاري تحويلك الآن...",
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomeView()),
                        );
                      } on FirebaseAuthException catch (e) {
                        String message = "فشل التسجيل";

                        if (e.code == 'user-not-found') {
                          Snackly.error(context: context,
                            title: "ليس لديك حساب؟ سجل الآن",
                          );
                        } else if (e.code == 'wrong-password') {
                          Snackly.error(
                            context: context,
                            title: "كلمة المرور غير صحيحة",
                          );
                        } else if (e.code == 'invalid-email') {
                          Snackly.error(
                            context: context,
                            title: "من فضلك ادخل بريد صالح",
                          );
                        }

                        Snackly.error(
                          context: context,
                          title: "ليس لديك حساب سجل الان",
                        );
                      }

                    }

                  },
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Registerscreen()),
                    );
                  },
                  child: Text(
                    "ليس لديك حساب؟ أنشئ الآن",
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required ValueChanged<String> onChanged,
    String? Function(String?)? validator,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }
}

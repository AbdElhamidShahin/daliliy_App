import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snackly/snackly.dart';
import 'LoginScreen.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, phone, password, confirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF50E3C2), Color(0xFF5AC8FA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Hero(
                  tag: "appLogo",
                  child: Image.asset(
                    'assets/Image/logoFront.png',
                    height: 150,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "إنشاء حساب جديد",
                  style: GoogleFonts.cairo(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),

                // ====== Name ======
                _buildTextField(
                  hint: "اسم المستخدم",
                  icon: Icons.person_outline,
                  onChanged: (v) => name = v,
                ),
                const SizedBox(height: 16),

                // ====== Email ======
                _buildTextField(
                  hint: "البريد الإلكتروني",
                  icon: Icons.email_outlined,
                  onChanged: (v) => email = v,
                ),
                const SizedBox(height: 16),

                // ====== Phone ======
                _buildTextField(
                  hint: "رقم الهاتف",
                  icon: Icons.phone,
                  onChanged: (v) => phone = v,
                ),
                const SizedBox(height: 16),

                // ====== Password ======
                _buildTextField(
                  hint: "كلمة المرور",
                  icon: Icons.lock_outline,
                  obscure: true,
                  onChanged: (v) => password = v,
                ),
                const SizedBox(height: 16),

                // ====== Confirm Password ======
                _buildTextField(
                  hint: "تأكيد كلمة المرور",
                  icon: Icons.lock,
                  obscure: true,
                  onChanged: (v) => confirm = v,
                ),
                const SizedBox(height: 30),

                // ====== Button ======
                _buildButton(
                  text: "إنشاء الحساب",
                  onTap: () async {
                    if (email == null ||
                        password == null ||
                        confirm == null ||
                        name == null ||
                        email!.isEmpty ||
                        password!.isEmpty ||
                        confirm!.isEmpty ||
                        name!.isEmpty) {
                      Snackly.error(
                        context: context,
                        title: "⚠️ من فضلك املأ كل الحقول",
                      );

                      return;
                    }

                    if (password != confirm) {
                      Snackly.error(
                        context: context,
                        title: "❌ كلمة المرور غير متطابقة",
                      );
                      return;
                    }

                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email!,
                        password: password!,
                      );
                      Snackly.success(
                        context: context,
                        title: " تم التسجيل بنجاح، جاري تحويلك الآن✅",
                      );

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const Loginscreen()),
                        );
                      });
                    } on FirebaseAuthException catch (e) {
                      String message = "فشل التسجيل";

                      if (e.code == 'email-already-in-use') {
                        Snackly.error(
                          context: context,
                          title: "⚠️ الحساب ده مسجل من قبل",
                        );
                      } else if (e.code == 'invalid-email') {
                        Snackly.error(
                          context: context,
                          title: "صيغة البريد الإلكتروني غير صحيحة",
                        );
                      } else if (e.code == 'weak-password') {
                        Snackly.error(
                          context: context,
                          title: "من فضلك ادخل كلمه مرور قويه",
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Loginscreen()),
                    );
                  },
                  child: Text(
                    "لديك حساب؟ سجل دخول",
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

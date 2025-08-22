import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5AC8FA), Color(0xFF50E3C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "appLogo",
              child: Image.asset(
                'assets/Image/logoFront.png',
                height: 180,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "مرحباً بك في دليلي",
              style: GoogleFonts.cairo(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 100),
            _buildButton(
              context,
              text: "تسجيل الدخول",
              color: Colors.white,
              textColor: Colors.teal,
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => Loginscreen(),
                  transitionsBuilder: (_, anim, __, child) =>
                      FadeTransition(opacity: anim, child: child),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildButton(
              context,
              text: "إنشاء حساب جديد",
              color: Colors.teal,
              textColor: Colors.white,
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => Registerscreen(),
                  transitionsBuilder: (_, anim, __, child) =>
                      SlideTransition(
                        position: Tween(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String text,
        required Color color,
        required Color textColor,
        required VoidCallback onTap}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

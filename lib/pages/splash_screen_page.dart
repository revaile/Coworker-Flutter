import 'package:cowok/config/enum.dart';
import 'package:cowok/config/session.dart'; // Tambahkan ini jika Anda menggunakan AppSession untuk cek user
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    // Tunda selama 3 detik
    await Future.delayed(const Duration(seconds: 3));

    // Cek status login pengguna
    final user = await AppSession
        .getUser(); // Misalnya AppSession.getUser mengembalikan data pengguna

    if (user != null) {
      // Jika pengguna sudah login, navigasi ke dashboard
      Navigator.pushReplacementNamed(context, AppRoute.dashboard.name);
    } else {
      // Jika belum login, navigasi ke halaman Get Started
      Navigator.pushReplacementNamed(context, AppRoute.getStarted.name);
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Logo dan loading di tengah layar
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 20,
                      offset: const Offset(0, 5), // Posisi bayangan
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/applogo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              // const CircularProgressIndicator(),
            ],
          ),
        ),
        // Nama pembuat di bawah layar
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'by Rivaldd',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4E40F6),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}

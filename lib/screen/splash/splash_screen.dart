import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/story-app.png',
              color: const Color(0xFFB3005E),
              width: 256,
              height: 256,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Story App',
              style: TextStyle(
                  color: Color(0xFFB3005E),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

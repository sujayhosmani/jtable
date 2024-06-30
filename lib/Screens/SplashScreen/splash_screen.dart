import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    LoadAllRequired();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void LoadAllRequired() {

  }
}

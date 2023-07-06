import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

  class Utils {
    static const Color scaffold = Color(0xFFF0F2F5);
    static const double padding = 20;
    static const double avatarRadius = 45;
    static const Color facebookBlue = Color(0xFF1777F2);
    static Color peach = fromHex("#F67B5A");
    static String ntImg = 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80';
    static const LinearGradient createRoomGradient = LinearGradient(
      colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
    );

    static const LinearGradient storyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.black87],
    );
    

    static  LinearGradient btnGradient = LinearGradient(
      begin: Alignment(-1.0, -4.0),
      end: Alignment(1.0, 4.0),
      colors: [fromHex("#FFA81D"), fromHex("#F45C43")],
    );

    static Color fromHex(String hexString) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }
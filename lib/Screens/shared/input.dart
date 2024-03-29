import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String? title;
  final bool? isPassword;
  final IconData? icon;
  final TextEditingController mCtrl;

  const InputText({Key? key, this.title, this.isPassword = false, this.icon, required this.mCtrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade200,
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: TextField(
        obscureText: isPassword!,
         controller: mCtrl,
        decoration: InputDecoration(
            hintText: title,
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            border: InputBorder.none
        ),
      ),
    );
  }
}

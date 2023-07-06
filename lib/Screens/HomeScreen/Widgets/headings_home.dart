import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  final String? label;
  final Function? onTap;
  final Color? color;

  const HeadingTitle({Key? key, this.label, this.onTap, this.color = Colors.black87}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color),),
        TextButton(onPressed: (){onTap!();}, child: Text("See All"))
      ],
    );
  }
}

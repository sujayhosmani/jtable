import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'error_screen.dart';

class LoadingScreen extends StatelessWidget {
  final Function onPressed;
  final bool isBusy;
  final String error;

  const LoadingScreen({Key? key, required this.onPressed, required this.isBusy, required this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isBusy ? GestureDetector(
      onTap: () => onPressed,
      child: Stack(
        children: [
          new Container(
            alignment: Alignment.center,
            color: Colors.black38,
          ),
          new Align(alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 120,
                width: 120,
                color: Colors.white,
              ),
            ),
          ),
          new Align(alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xffff5f6d),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                    child: Text("Loading",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),),
                  )
                ],
              )
          )
        ],
      ),
    ): error != null && error != "" ? ErrorScreen(error: error,) : SizedBox.shrink();
  }
}

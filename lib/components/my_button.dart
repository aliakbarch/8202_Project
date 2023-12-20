import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String text;

  MyButton({
    super.key,
    required this.onTap,
    required this.text
  });

  bool pressedButton = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 450,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      onPressed: onTap,
      color: Colors.green,
      elevation: 5.0,
      height: 40,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
    // return SizedBox(
    //   width: 500.0,
    //   height: 50.0,
    //   child: GestureDetector(
    //     onTap: onTap,
    //     child: Container(
    //       padding: const EdgeInsets.all(10),
    //       margin: const EdgeInsets.symmetric(horizontal: 25),
    //       decoration: BoxDecoration(
    //           color: pressedButton ? Colors.greenAccent : Colors.green,
    //           borderRadius: BorderRadius.circular(5),
    //       ),
    //       child: Center(child: Text(text,
    //       style: const TextStyle(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 16),
    //       )
    //       ),
    //     ),
    //   ),
    // );
  }
}

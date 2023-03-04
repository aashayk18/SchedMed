import 'package:flutter/material.dart';

class CompleteButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const CompleteButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            )));
  }
}

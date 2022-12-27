import 'package:flutter/cupertino.dart';
import 'package:flutter_to_do_app/ui/theme.dart';

import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const ThemeButton({Key? key, required this.label, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child:Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green
            ),
            child: Align (
              alignment: Alignment.center,
              child:Text(
                label,
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            )
        )
    );
  }
}

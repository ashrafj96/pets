import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final double borderRadius;
  final double height;
  CustomRaisedButton(
      {this.child,
      this.color,
      this.onPressed,
      this.borderRadius: 16.0,
      this.height: 50.0})
      : assert(borderRadius != null);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        // disabledColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        color: color,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

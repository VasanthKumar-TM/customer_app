import 'package:flutter/material.dart';
import 'package:customer_app/values/values.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.label,
    this.labelColor = Colors.white,
    this.backgroundColor = Colors.pink,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final Color labelColor;
  final Color backgroundColor;
  final double width;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.SIZE_30),
          ),
          primary: labelColor,
        ),
        child: Text('$label'),
      ),
    );
  }
}

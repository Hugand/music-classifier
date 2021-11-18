
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EvaluationButton extends StatelessWidget {
  final String icon;
  final void Function() onTap;
  final Color color;
  const EvaluationButton({Key? key, required this.icon, required this.onTap, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Handle your callback
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: color, width: 2)
        ),
        child: SvgPicture.asset(
          icon,
          color: color,
        )
      )
    );
  }

}
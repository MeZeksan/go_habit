// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_habit/core/extension/theme_extension.dart';

class CircleButton extends StatelessWidget {
  final Widget icon;
  final Color? backgroundColor;
  final double dimension;
  final VoidCallback onTap;
  final double topIconPadding;
  const CircleButton(
      {required this.icon,
      required this.onTap,
      super.key,
      this.backgroundColor,
      this.dimension = 35,
      this.topIconPadding = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(dimension / 2),
          child: Ink(
            decoration: BoxDecoration(
              color: backgroundColor ?? context.theme.commonColors.white,
              borderRadius: BorderRadius.circular(dimension / 2),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: topIconPadding),
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}

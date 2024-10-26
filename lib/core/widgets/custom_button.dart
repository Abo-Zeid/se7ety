import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    this.width,
    this.height,
    this.textColor,
    required this.text,
    required this.onPressed,
    this.isOutline = false,
    this.fontsize,
  });

  final Color? color;
  final double? fontsize;
  final double? width;
  final double? height;
  final Color? textColor;
  final String text;
  final Function()? onPressed;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    final Color buttonColor =
        isOutline ? AppColors.whiteColor : (color ?? AppColors.primaryColor);

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          side: isOutline
              ? const BorderSide(color: AppColors.textColor)
              : BorderSide.none,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyle.getbodyTextStyle(
            color: textColor ?? AppColors.primaryColor,
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }
}

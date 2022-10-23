import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: loading
          ? const CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.whiteColor,
            )
          : Container(
              height: 40,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
    );
  }
}

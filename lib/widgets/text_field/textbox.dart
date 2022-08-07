import 'package:flutter/material.dart';

import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/utils/helper/text_field_wrapper.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final double? height;
  final VoidCallback? onTap;
  final TextFieldWrapper wrapper;
  final TextInputType? textInputType;
  final int? maxLine;
  final int? maxLength;
  final validator;
  final TextCapitalization? textCapitalization;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.wrapper,
    this.height = 80,
    this.textInputType,
    this.maxLine = 1,
    this.maxLength,
    this.validator,
    this.textCapitalization,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: TextFormField(
            controller: wrapper.controller,
            keyboardType: textInputType,
            validator: validator,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            cursorColor: AppColors.white,
            decoration: InputDecoration(
              isDense: true,
              counterText: "",
              hintText: label,
              hintStyle: Styles.tsWhiteLight14
                  .copyWith(color: const Color(0xFF828fc7)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF828fc7))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF828fc7))),
            ),
            maxLines: maxLine,
            style: Styles.tsWhiteLight14,
            maxLength: maxLength,
          ),
        ),
      ),
    );
  }
}

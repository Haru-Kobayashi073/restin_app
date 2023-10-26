import 'package:flutter/material.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.obscureText = false,
    this.maxLines,
    this.autofocus = false,
    this.suffixIcon,
  });
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final String labelText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(labelText),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          autofocus: autofocus,
          validator: validator,
          obscureText: obscureText,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: '入力してください',
            hintStyle: AppTextStyle.createMarkerTextFieldLabel,
            contentPadding: const EdgeInsets.all(12),
            suffixIcon: suffixIcon,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorName.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorName.mediumGrey,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorName.red,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorName.mediumGrey,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorName.mediumGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

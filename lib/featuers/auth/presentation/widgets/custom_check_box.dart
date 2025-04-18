import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/auth_cubit/cubit/auth_cubit.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: AppColors.grey),
      onChanged: (newValue) {
        setState(() {
          value = newValue;
          BlocProvider.of<AuthCubit>(context).updateTermsAndConditionCheckBox(newValue: newValue);
        });
      },
    );
  }
}

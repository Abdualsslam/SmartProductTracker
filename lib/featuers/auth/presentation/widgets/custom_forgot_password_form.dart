import 'package:flutter/material.dart';
import 'package:flutter_notie/flutter_notie.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/core/utils/constants/colors.dart';
import 'package:smart_product_tracker/core/utils/constants/texts.dart';
import 'package:smart_product_tracker/core/utils/widgets/custom_btn.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/auth_cubit/cubit/auth_cubit.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/auth_cubit/cubit/auth_state.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/widgets/custom_text_field.dart';

class CustomForgotPasswrodForm extends StatelessWidget {
  const CustomForgotPasswrodForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          FlutterNotie.info(context, message: AppStrings.checkYourEmailToReset);
          customReplacementNavigate(context, "/signIn");
        } else if (state is ResetPasswordFailureState) {
          FlutterNotie.error(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: authCubit.forgotPasswordFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: AppStrings.emailAddress,
                  onChanged: (email) {
                    authCubit.emailAddress = email;
                  },
                ),
                const SizedBox(height: 129),
                state is ResetPasswordLoadingState
                    ? CircularProgressIndicator(color: AppColors.primary)
                    : CustomBtn(
                      onPressed: () async {
                        if (authCubit.forgotPasswordFormKey.currentState!.validate()) {
                          await authCubit.resetPasswordWithLink();
                        }
                      },
                      text: AppStrings.resetPassword,
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}

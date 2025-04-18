import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notie/flutter_notie.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';
import 'package:smart_product_tracker/core/utils/constants/colors.dart';
import 'package:smart_product_tracker/core/utils/constants/texts.dart';
import 'package:smart_product_tracker/core/utils/widgets/custom_btn.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/auth_cubit/cubit/auth_cubit.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/auth_cubit/cubit/auth_state.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/widgets/custom_text_field.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/widgets/forgot_password_text_widget.dart';

class CustomSignInForm extends StatelessWidget {
  const CustomSignInForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SigninSuccessState) {
          FirebaseAuth.instance.currentUser!.emailVerified
              ? customReplacementNavigate(context, "/home")
              : FlutterNotie.warning(context, message: AppStrings.plzVerifyYourAccount);
        } else if (state is SigninFailureState) {
          FlutterNotie.error(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.signinFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: AppStrings.emailAddress,
                onChanged: (email) {
                  authCubit.emailAddress = email;
                },
              ),
              CustomTextFormField(
                labelText: AppStrings.password,
                suffixIcon: IconButton(
                  icon: Icon(authCubit.obscurePasswordTextValue == true ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  onPressed: () {
                    authCubit.obscurePasswordText();
                  },
                ),
                obscureText: authCubit.obscurePasswordTextValue,
                onChanged: (password) {
                  authCubit.password = password;
                },
              ),
              const SizedBox(height: 16),
              const ForgotPasswordTextWidget(),
              const SizedBox(height: 102),
              state is SigninLoadingState
                  ? CircularProgressIndicator(color: AppColors.primary)
                  : CustomBtn(
                    onPressed: () async {
                      if (authCubit.signinFormKey.currentState!.validate()) {
                        await authCubit.sigInWithEmailAndPassword();
                      }
                    },
                    text: AppStrings.signIn,
                  ),
            ],
          ),
        );
      },
    );
  }
}

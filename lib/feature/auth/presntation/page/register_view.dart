import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/enum/user_type.dart';
import 'package:se7ety/core/functions/dialogs.dart';
import 'package:se7ety/core/functions/email_validate.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/feature/auth/presntation/bloc/auth_bloc.dart';
import 'package:se7ety/feature/auth/presntation/bloc/auth_event.dart';
import 'package:se7ety/feature/auth/presntation/bloc/auth_state.dart';
import 'package:se7ety/feature/auth/presntation/page/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.userType});
  final UserType userType;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isobsecure = true;
  final TextEditingController _displayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String handelUserType() {
    return widget.userType == UserType.doctor ? "دكتور" : "مريض";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "لدي حساب ",
            style: AppTextStyle.getbodyTextStyle(color: AppColors.textColor),
          ),
          TextButton(
              onPressed: () {
                pushReplacement(context, LoginView(userType: widget.userType));
              },
              child: Text(
                "سجل دخول",
                style: AppTextStyle.getbodyTextStyle(
                    color: AppColors.primaryColor),
              ))
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            log("$state");
            showLoadingDialog(context);
          } else if (state is RegisterSuccesState) {
            Navigator.pop(context);
            pushAndRemoveUntil(
                context,
                LoginView(
                  userType: widget.userType,
                ));
          } else if (state is AuthErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, state.error);
          }
        },
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  Image(
                    image: const AssetImage("assets/images/logo.png"),
                    width: MediaQuery.sizeOf(context).width,
                    height: 200,
                  ),
                  const Gap(30),
                  Text(
                    "سجل حساب جديد كـ  ${handelUserType()}",
                    style: AppTextStyle.getTtileTextStyle(
                        color: AppColors.primaryColor),
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: _displayController,
                    validator: (value) {
                      if (value!.isEmpty) return 'من فضلك ادخل الاسم';
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "الاسم",
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        )),
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الايميل';
                      } else if (!emailValidate(value)) {
                        return "من فضلك ادخل الايميل صحيحا";
                      }
                      return null;
                    },
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                        hintTextDirection: TextDirection.ltr,
                        hintText: "example@example.com",
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.primaryColor,
                        )),
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل كلمه المرور";
                      } else if (value.length < 8) {
                        return "من فضلك اجعل كلمة السر ٨";
                      }
                      return null;
                    },
                    obscureText: isobsecure,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                        hintStyle: AppTextStyle.getTtileTextStyle(
                            color: AppColors.greyColor),
                        hintTextDirection: TextDirection.ltr,
                        hintText: "* * * * * * *",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.primaryColor,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isobsecure = !isobsecure;
                              });
                            },
                            icon: isobsecure
                                ? const Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.primaryColor,
                                  )
                                : const Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: AppColors.primaryColor,
                                  ))),
                  ),
                  const Gap(30),
                  CustomButton(
                      text: "تسجيل حساب",
                      textColor: AppColors.whiteColor,
                      color: AppColors.primaryColor.withOpacity(0.8),
                      height: 50,
                      fontsize: 18,
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          context.read<AuthBloc>().add(RegisterEvent(
                              userType: widget.userType,
                              name: _displayController.text,
                              email: _emailController.text,
                              passWord: _passwordController.text));
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

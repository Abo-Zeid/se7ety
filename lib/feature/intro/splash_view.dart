// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:se7ety/core/enum/user_type.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/services/local_storage.dart';
import 'package:se7ety/feature/doctor/nav_bar_widget.dart';
import 'package:se7ety/feature/intro/onbording/onbording_view.dart';
import 'package:se7ety/feature/intro/welcome_view.dart';
import 'package:se7ety/feature/patient/nav_bar.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    String? isLoggedIn =
        AppLocalStorage.getData(key: AppLocalStorage.userToken);
    UserType? userType = AppLocalStorage.getUserType();
    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn != null && userType == UserType.doctor) {
        pushAndRemoveUntil(context, DoctorNavBar());
      } else if (isLoggedIn != null && userType == UserType.patient) {
        pushAndRemoveUntil(context, PatientNavBar());
      } else {
        if (AppLocalStorage.getData(key: AppLocalStorage.isOnboardingShown) ??
            false) {
          pushReplacement(context, const WelcomeView());
        } else {
          pushReplacement(context, const OnboardingView());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}

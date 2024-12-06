import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class DoctorHomeView extends StatefulWidget {
  const DoctorHomeView({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<DoctorHomeView> {
  User? user;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.notifications_active,
                  color: AppColors.whiteColor),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          'صــــــحّـتــي',
          style: getTitleTextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: "مرحبا  د.",
                      style: getTitleTextStyle(
                          fontSize: 22, color: AppColors.textColor),
                    ),
                    TextSpan(
                      text: user?.displayName,
                      style: getTitleTextStyle(),
                    ),
                  ],
                )),
                Gap(100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("الآن وكن جزءًا من رحلة رعاية مرضاك",
                          style: getTitleTextStyle(
                              color: AppColors.textColor, fontSize: 22)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

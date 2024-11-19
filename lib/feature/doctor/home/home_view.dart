import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                  color: AppColors.textColor),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text(
          'صــــــحّـتــي',
          style: getTtileTextStyle(color: AppColors.textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: "مرحبا  د.",
                      style: getbodyTextStyle(
                          fontSize: 18, color: AppColors.textColor),
                    ),
                    TextSpan(
                      text: user?.displayName,
                      style: getTtileTextStyle(),
                    ),
                  ],
                )),
                Spacer(),
                Text("الآن وكن جزءًا من رحلتك الصحية.",
                    style: getTtileTextStyle(
                        color: AppColors.textColor, fontSize: 25)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

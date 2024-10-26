import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/feature/patient/presntation/widget/specialist_widget.dart';
import 'package:se7ety/feature/patient/presntation/widget/top_rated_widget.dart';

class PatientHomeView extends StatefulWidget {
  const PatientHomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomeView> {
  final TextEditingController _doctorName = TextEditingController();
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'صــــــحّـتــي',
          style: AppTextStyle.getTtileTextStyle(color: AppColors.textColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: 'مرحبا، ',
                    style: AppTextStyle.getbodyTextStyle(fontSize: 18),
                  ),
                  TextSpan(
                    text: user?.displayName?.toUpperCase() ?? "",
                    style: AppTextStyle.getTtileTextStyle(),
                  ),
                ],
              )),
              const Gap(10),
              Text("احجز الآن وكن جزءًا من رحلتك الصحية.",
                  style: AppTextStyle.getTtileTextStyle(
                      color: AppColors.textColor, fontSize: 25)),
              const Gap(15),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    )
                  ],
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: _doctorName,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintStyle: AppTextStyle.getbodyTextStyle(),
                    filled: true,
                    hintText: 'ابحث عن دكتور',
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: IconButton(
                        iconSize: 20,
                        splashRadius: 20,
                        color: Colors.white,
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(
                            () {
                              if (_doctorName.text.isNotEmpty) {
                                // push(
                                //     context,
                                //     SearchHomeView(
                                //         searchKey: _doctorName.text));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  style: AppTextStyle.getbodyTextStyle(),
                  onFieldSubmitted: (String value) {
                    setState(
                      () {
                        if (_doctorName.text.isNotEmpty) {
                          // push(context,
                          //     SearchHomeView(searchKey: _doctorName.text));
                        }
                      },
                    );
                  },
                ),
              ),
              const Gap(16),
              const SpecialistsBanner(),
              const Gap(10),
              Text(
                "الأعلي تقييماً",
                textAlign: TextAlign.center,
                style: AppTextStyle.getTtileTextStyle(fontSize: 16),
              ),
              const Gap(10),
              const TopRatedList(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/feature/patient/presentation/page/home/presentation/page/home_search_view.dart';
import 'package:se7ety/feature/patient/presentation/widget/specialist_widget.dart';
import 'package:se7ety/feature/patient/presentation/widget/top_rated_widget.dart';

class PatientHomeView extends StatefulWidget {
  const PatientHomeView({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<PatientHomeView> {
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
                  color: AppColors.whiteColor),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
        title: Text(
          'صــــــحّـتــي',
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
                    style: getTtileTextStyle(
                        fontSize: 18, color: AppColors.textColor),
                  ),
                  TextSpan(
                    text: user?.displayName,
                    style: getTtileTextStyle(),
                  ),
                ],
              )),
              const Gap(10),
              Text("احجز الآن وكن جزءًا من رحلتك الصحية.",
                  style: getTtileTextStyle(
                      color: AppColors.textColor, fontSize: 25)),
              const SizedBox(height: 15),

              // --------------- Search Bar --------------------------
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
                    hintStyle: getbodyTextStyle(),
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
                                push(
                                    context,
                                    SearchHomeView(
                                        searchKey: _doctorName.text));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  style: getbodyTextStyle(),
                  onFieldSubmitted: (String value) {
                    setState(
                      () {
                        if (_doctorName.text.isNotEmpty) {
                          push(context,
                              SearchHomeView(searchKey: _doctorName.text));
                        }
                      },
                    );
                  },
                ),
              ),
              Gap(16),
              // ----------------  SpecialistsWidget --------------------,

              const SpecialistsBanner(),
              Gap(10),

              // ----------------  Top Rated --------------------,
              Text(
                "الأعلي تقييماً",
                textAlign: TextAlign.center,
                style: getTtileTextStyle(fontSize: 16),
              ),
              Gap(10),
              const TopRatedList(),
            ],
          ),
        ),
      ),
    );
  }
}

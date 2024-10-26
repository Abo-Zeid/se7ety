import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/services/local_storage.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/feature/intro/onbording/onbording_model.dart';
import 'package:se7ety/feature/intro/welcome_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnbordingViewState();
}

class _OnbordingViewState extends State<OnboardingView> {
  var pageController = PageController();
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                AppLocalStorage.cacheData(
                    key: AppLocalStorage.isOnboardingShown, value: true);
                pushReplacement(context, const WelcomeView());
              },
              child: Text(
                "تخطي",
                style: AppTextStyle.getTtileTextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  onPageChanged: (value) {
                    setState(() {
                      currentindex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SvgPicture.asset(
                          pages[index].image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 400,
                        ),
                        const Gap(20),
                        Text(
                          pages[index].title,
                          style: AppTextStyle.getTtileTextStyle(),
                        ),
                        const Gap(10),
                        Text(
                          textAlign: TextAlign.center,
                          pages[index].body,
                          style: AppTextStyle.getbodyTextStyle(
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 16,
                        activeDotColor: AppColors.primaryColor,
                        dotColor: AppColors.greyColor,
                        spacing: 8,
                      ),
                    ),
                    const Spacer(),
                    if (currentindex == 2)
                      CustomButton(
                        text: "هيا بينا ",
                        textColor: AppColors.whiteColor,
                        height: 45,
                        fontsize: 18,
                        width: 120,
                        onPressed: () {
                          AppLocalStorage.cacheData(
                              key: AppLocalStorage.isOnboardingShown,
                              value: true);
                          pushReplacement(context, const WelcomeView());
                        },
                        color: AppColors.primaryColor,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

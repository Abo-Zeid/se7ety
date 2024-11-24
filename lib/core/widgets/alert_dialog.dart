import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

showAlertDialog(BuildContext context,
    {String? ok, String? no, required String title, void Function()? onTap}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.accentColor,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  title,
                  style: getTitleTextStyle(color: AppColors.textColor),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (ok != null)
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primaryColor),
                          child: Text(
                            ok,
                            style:
                                getbodyTextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    if (no != null)
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.secondaryColor),
                          child: Text(
                            no,
                            style: getbodyTextStyle(color: AppColors.textColor),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      );
    },
  );
}



  // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return CupertinoAlertDialog(
            //       title: const Text('تم تسجيل الحجز !'),
            //       actions: [
            //         TextButton(
            //           onPressed: () {
            //             pushAndRemoveUntil(
            //                 context, const PatientNavBarWidget());
            //           },
            //           child: const Text('اضغط للانتقال'),
            //         ),
            //         TextButton(
            //           onPressed: () {
            //             Navigator.pop(context);
            //           },
            //           child: const Text('الغاء'),
            //         ),
            //       ],
            //     );
            //   },
            // );
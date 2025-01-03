import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/feature/patient/search/widgets/search_list.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ابحث عن دكتور',
         
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  )
                ],
              ),
              child: TextField(
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  hintText: "البحث",
                  hintStyle: getbodyTextStyle(color: AppColors.primaryColor),
                  suffixIcon: const SizedBox(
                      width: 50,
                      child: Icon(Icons.search, color: AppColors.primaryColor)),
                ),
                onChanged: (searchKey) {
                  setState(
                    () {
                      search = searchKey;
                    },
                  );
                },
              ),
            ),
            const Gap(15),
            Expanded(
              child: SearchList(
                searchKey: search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/feature/patient/data/card.dart';
import 'package:se7ety/feature/patient/presentation/page/home/presentation/page/specializatioin_search_view.dart';
import 'package:se7ety/feature/patient/presentation/widget/item_card_widget.dart';

class SpecialistsBanner extends StatelessWidget {
  const SpecialistsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(" التخصصات", style: getTtileTextStyle(fontSize: 16)),
        SizedBox(
          height: 210,
          width: double.infinity,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  push(
                      context,
                      SpecializationSearchView(
                        specialization: cards[index].specialization,
                      ));
                },
                child: ItemCardWidget(
                    title: cards[index].specialization,
                    color: cards[index].cardBackground,
                    lightColor: cards[index].cardLightColor),
              );
            },
          ),
        ),
      ],
    );
  }
}
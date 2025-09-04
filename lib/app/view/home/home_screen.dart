import 'package:crypto_app/app/data/data_file.dart';
import 'package:crypto_app/app/models/model_item.dart';
import 'package:crypto_app/app/view/home/tab/tab_market.dart';
import 'package:crypto_app/app/view/home/tab/tab_transaction.dart';
import 'package:crypto_app/app/view/home/tab/tab_home.dart';
import 'package:crypto_app/app/view/home/tab/tab_profile.dart';
import 'package:crypto_app/base/color_data.dart';
import 'package:crypto_app/base/constant.dart';
import 'package:crypto_app/base/resizer/fetch_pixels.dart';
import 'package:flutter/material.dart';

import '../../../base/widget_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int position = 0;

  void close() {
    Constant.closeApp();
  }

  List<Widget> tabList = [
     const TabHome(),
     const TabTransaction(),
     const TabMarket(),
     const TabProfile(),
  ];
  List<ModelItem> itemLists = DataFile.itemList;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: tabList[position],
          bottomNavigationBar: bottomNavigationBar(),
        ),
        onWillPop: () async {
          close();
          return false;
        });
  }

  Container bottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
      height: FetchPixels.getPixelHeight(66),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(itemLists.length, (index) {
          ModelItem modelItem = itemLists[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                position = index;
              });
            },
            child: Row(
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(46),
                  width: FetchPixels.getPixelHeight(46),
                  decoration: position == index
                      ? BoxDecoration(
                          color: position == index
                              ? blueColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          boxShadow: [
                              BoxShadow(
                                  color: shadowColor,
                                  blurRadius: 18,
                                  offset: const Offset(0, 9))
                            ])
                      : null,
                  child: Padding(
                    padding: EdgeInsets.all(FetchPixels.getPixelHeight(11)),
                    child: getSvgImage(modelItem.image ?? "",
                        color: position == index ? Colors.white : null),
                  ),
                ),
                position == index
                    ? Row(
                        children: [
                          getHorSpace(FetchPixels.getPixelHeight(8)),
                          getCustomFont(
                              modelItem.name ?? '', 13, Colors.black, 1,
                              fontWeight: FontWeight.w500)
                        ],
                      )
                    : Container()
              ],
            ),
          );
        }),
      ), // child:
    );
  }
}

import 'package:crypto_app/app/data/data_file.dart';
import 'package:crypto_app/app/models/model_trend.dart';
import 'package:crypto_app/app/routes/app_routes.dart';
import 'package:crypto_app/base/color_data.dart';
import 'package:crypto_app/base/constant.dart';
import 'package:crypto_app/base/pref_data.dart';
import 'package:crypto_app/base/resizer/fetch_pixels.dart';
import 'package:crypto_app/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TabMarket extends StatefulWidget {
  const TabMarket({Key? key}) : super(key: key);

  @override
  State<TabMarket> createState() => _TabMarketState();
}

class _TabMarketState extends State<TabMarket> {
  var horspace = FetchPixels.getPixelHeight(20);
  TextEditingController searchController = TextEditingController();
  List<String> categoryLists = DataFile.categoryList;
  int select = 0;
  List<ModelTrend> newTrendList = DataFile.trendList;

  // onItemChanged(String value) {
  //   setState(() {
  //     newTrendList = DataFile.trendList
  //         .where((string) =>
  //             string.name!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  int length = 0;

  @override
  void initState() {
    super.initState();
    length = newTrendList.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getVerSpace(14),
            appBar(context),
            getVerSpace(23),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCustomFont("Market is ", 15, Colors.black, 1,
                    fontWeight: FontWeight.w400),
                getCustomFont("up 0.63%", 15, blueColor, 1,
                    fontWeight: FontWeight.w600),
                getCustomFont(" in last 24h", 15, Colors.black, 1,
                    fontWeight: FontWeight.w400),
              ],
            ),
            getVerSpace(20),
            searchWidget(context),
            getVerSpace(24),
            categoryList(),
            getVerSpace(24),
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  physics:  BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ModelTrend modelTrend = newTrendList[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration:  Duration(milliseconds: 200),
                      child: SlideAnimation(
                        verticalOffset: 44.0,
                        child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                PrefData.setTrendName(modelTrend.name ?? "");
                                PrefData.setTrendImage(modelTrend.image ?? "");
                                PrefData.setTrendCurrency(modelTrend.currency ?? "");
                                PrefData.setTrendPrice(modelTrend.price ?? 0.00);
                                PrefData.setTrendProfit(modelTrend.profit ?? "");
                                Constant.sendToNext(context, Routes.detailRoute);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: index == 0 ? FetchPixels.getPixelHeight(5) : 0,
                                    left: horspace,
                                    right: horspace,
                                    bottom: FetchPixels.getPixelHeight(20)),
                                padding: EdgeInsets.only(
                                    left: FetchPixels.getPixelHeight(16),
                                    right: FetchPixels.getPixelHeight(16),
                                    top: FetchPixels.getPixelHeight(16),
                                    bottom: FetchPixels.getPixelHeight(18)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: shadowColor,
                                          blurRadius: 23,
                                          offset: const Offset(0, 10))
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        FetchPixels.getPixelHeight(14))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        getSvgImage(modelTrend.image ?? "",
                                            height: FetchPixels.getPixelHeight(50),
                                            width: FetchPixels.getPixelHeight(50)),
                                        getHorSpace(FetchPixels.getPixelHeight(12)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            getCustomFont(
                                                modelTrend.name ?? "", 15, Colors.black, 1,
                                                fontWeight: FontWeight.w600),
                                            getVerSpace(FetchPixels.getPixelHeight(3)),
                                            getCustomFont(modelTrend.currency ?? "", 15,
                                                subtextColor, 1,
                                                fontWeight: FontWeight.w400)
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        getCustomFont(
                                            "\$${modelTrend.price}", 15, Colors.black, 1,
                                            fontWeight: FontWeight.w600),
                                        getVerSpace(FetchPixels.getPixelHeight(5)),
                                        Wrap(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: modelTrend.profit![0] == "-"
                                                      ? errorbg
                                                      : successBg,
                                                  borderRadius: BorderRadius.circular(
                                                      FetchPixels.getPixelHeight(21))),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: FetchPixels.getPixelHeight(6),
                                                  vertical: FetchPixels.getPixelHeight(1)),
                                              child: Row(
                                                children: [
                                                  getSvgImage(modelTrend.profit![0] == "-"
                                                      ? "error_icon.svg"
                                                      : 'success_icon.svg'),
                                                  getHorSpace(FetchPixels.getPixelHeight(4)),
                                                  getCustomFont(
                                                      modelTrend.profit ?? '',
                                                      13,
                                                      modelTrend.profit![0] == "-"
                                                          ? errorColor
                                                          : successColor,
                                                      1,
                                                      fontWeight: FontWeight.w400)
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Expanded markettrendList() {
  //   return Expanded(
  //
  //
  //       child: AnimationLimiter(
  //     child: ListView.builder(
  //       physics: const BouncingScrollPhysics(),
  //       padding: EdgeInsets.zero,
  //       itemCount: length,
  //       primary: false,
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         ModelTrend modelTrend = newTrendList[index];
  //         return AnimationConfiguration.staggeredList(
  //           position: index,
  //           duration: const Duration(milliseconds: 200),
  //           child: SlideAnimation(
  //             verticalOffset: 44.0,
  //             child: FadeInAnimation(
  //                 child: GestureDetector(
  //               onTap: () {
  //                 PrefData.setTrendName(modelTrend.name ?? "");
  //                 PrefData.setTrendImage(modelTrend.image ?? "");
  //                 PrefData.setTrendCurrency(modelTrend.currency ?? "");
  //                 PrefData.setTrendPrice(modelTrend.price ?? 0.00);
  //                 PrefData.setTrendProfit(modelTrend.profit ?? "");
  //                 Constant.sendToNext(context, Routes.detailRoute);
  //               },
  //               child: Container(
  //                 margin: EdgeInsets.only(
  //                     top: index == 0 ? FetchPixels.getPixelHeight(5) : 0,
  //                     left: horspace,
  //                     right: horspace,
  //                     bottom: FetchPixels.getPixelHeight(20)),
  //                 padding: EdgeInsets.only(
  //                     left: FetchPixels.getPixelHeight(16),
  //                     right: FetchPixels.getPixelHeight(16),
  //                     top: FetchPixels.getPixelHeight(16),
  //                     bottom: FetchPixels.getPixelHeight(18)),
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     boxShadow: [
  //                       BoxShadow(
  //                           color: shadowColor,
  //                           blurRadius: 23,
  //                           offset: const Offset(0, 10))
  //                     ],
  //                     borderRadius: BorderRadius.circular(
  //                         FetchPixels.getPixelHeight(14))),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         getSvgImage(modelTrend.image ?? "",
  //                             height: FetchPixels.getPixelHeight(50),
  //                             width: FetchPixels.getPixelHeight(50)),
  //                         getHorSpace(FetchPixels.getPixelHeight(12)),
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             getCustomFont(
  //                                 modelTrend.name ?? "", 15, Colors.black, 1,
  //                                 fontWeight: FontWeight.w600),
  //                             getVerSpace(FetchPixels.getPixelHeight(3)),
  //                             getCustomFont(modelTrend.currency ?? "", 15,
  //                                 subtextColor, 1,
  //                                 fontWeight: FontWeight.w400)
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         getCustomFont(
  //                             "\$${modelTrend.price}", 15, Colors.black, 1,
  //                             fontWeight: FontWeight.w600),
  //                         getVerSpace(FetchPixels.getPixelHeight(5)),
  //                         Wrap(
  //                           children: [
  //                             Container(
  //                               decoration: BoxDecoration(
  //                                   color: modelTrend.profit![0] == "-"
  //                                       ? errorbg
  //                                       : successBg,
  //                                   borderRadius: BorderRadius.circular(
  //                                       FetchPixels.getPixelHeight(21))),
  //                               padding: EdgeInsets.symmetric(
  //                                   horizontal: FetchPixels.getPixelHeight(6),
  //                                   vertical: FetchPixels.getPixelHeight(1)),
  //                               child: Row(
  //                                 children: [
  //                                   getSvgImage(modelTrend.profit![0] == "-"
  //                                       ? "error_icon.svg"
  //                                       : 'success_icon.svg'),
  //                                   getHorSpace(FetchPixels.getPixelHeight(4)),
  //                                   getCustomFont(
  //                                       modelTrend.profit ?? '',
  //                                       13,
  //                                       modelTrend.profit![0] == "-"
  //                                           ? errorColor
  //                                           : successColor,
  //                                       1,
  //                                       fontWeight: FontWeight.w400)
  //                                 ],
  //                               ),
  //                             )
  //                           ],
  //                         )
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )),
  //           ),
  //         );
  //       },
  //     ),
  //   ));
  // }

  SizedBox categoryList() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(44),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categoryLists.length,
        itemBuilder: (context, index) {
          return Wrap(
            children: [
              GestureDetector(
                child: Container(
                  decoration: select == index
                      ? BoxDecoration(
                          color: blueColor,
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 23,
                                offset: const Offset(0, 7))
                          ],
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(14)))
                      : null,
                  padding: EdgeInsets.symmetric(
                      vertical: FetchPixels.getPixelHeight(11),
                      horizontal:
                          select == index ? FetchPixels.getPixelHeight(20) : 0),
                  margin: EdgeInsets.only(
                      right: FetchPixels.getPixelHeight(37),
                      left: index == 0 ? horspace : 0),
                  child: getCustomFont(categoryLists[index], 15,
                      select == index ? Colors.white : textColor, 1,
                      fontWeight:
                          select == index ? FontWeight.w600 : FontWeight.w400),
                ),
                onTap: () {
                  setState(() {
                    select = index;
                    if (index == 0) {
                      length = newTrendList.length;
                    } else if (index == 1) {
                      length = 2;
                    } else if (index == 2) {
                      length = 4;
                    } else if (index == 3) {
                      length = 5;
                    }
                  });
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
      getSearchWidget(context, searchController, () {}, (value) {},
          withPrefix: true),
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(context, "back.svg", () {},
          istext: true,
          title: "Market Trend",
          fontsize: 24,
          weight: FontWeight.w700,
          textColor: Colors.black,
          isleftimage: false,
          isrightimage: true,
          rightimage: "more.svg"),
    );
  }
}

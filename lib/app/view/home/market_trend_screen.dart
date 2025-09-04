import 'package:crypto_app/app/models/model_trend.dart';
import 'package:crypto_app/app/routes/app_routes.dart';
import 'package:crypto_app/base/color_data.dart';
import 'package:crypto_app/base/constant.dart';
import 'package:crypto_app/base/pref_data.dart';
import 'package:crypto_app/base/resizer/fetch_pixels.dart';
import 'package:crypto_app/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../data/data_file.dart';

class MarketTrendScreen extends StatefulWidget {
  const MarketTrendScreen({Key? key}) : super(key: key);

  @override
  State<MarketTrendScreen> createState() => _MarketTrendScreenState();
}

class _MarketTrendScreenState extends State<MarketTrendScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horspace = FetchPixels.getPixelHeight(20);
  TextEditingController searchController = TextEditingController();

  List<ModelTrend> newTrendList = List.from(DataFile.trendList);

  onItemChanged(String value) {
    setState(() {
      newTrendList = DataFile.trendList
          .where((string) =>
              string.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                appBar(context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getPaddingWidget(
                  EdgeInsets.symmetric(horizontal: horspace),
                  Container(
                    alignment: Alignment.center,
                    height: FetchPixels.getPixelHeight(49),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(16))),
                    child: getRichText(
                        "Market is ",
                        Colors.black,
                        FontWeight.w400,
                        16,
                        "up 0.63% ",
                        blueColor,
                        FontWeight.w600,
                        16,
                        "in last 24h"),
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Expanded(
                    child: marketTrendList())
              ],
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }

  AnimationLimiter marketTrendList() {
    return AnimationLimiter(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: newTrendList.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ModelTrend modelTrend = newTrendList[index];
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 200),
                        child: SlideAnimation(
                            verticalOffset: 44.0,
                            child: FadeInAnimation(
                                child: GestureDetector(
                              onTap: () {
                                PrefData.setTrendName(modelTrend.name ?? "");
                                PrefData.setTrendImage(
                                    modelTrend.image ?? "");
                                PrefData.setTrendCurrency(
                                    modelTrend.currency ?? "");
                                PrefData.setTrendPrice(
                                    modelTrend.price ?? 0.00);
                                PrefData.setTrendProfit(
                                    modelTrend.profit ?? "");
                                Constant.sendToNext(
                                    context, Routes.detailRoute);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        getSvgImage(modelTrend.image ?? "",
                                            height:
                                                FetchPixels.getPixelHeight(
                                                    50),
                                            width: FetchPixels.getPixelHeight(
                                                50)),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(12)),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            getCustomFont(
                                                modelTrend.name ?? "",
                                                15,
                                                Colors.black,
                                                1,
                                                fontWeight: FontWeight.w600),
                                            getVerSpace(
                                                FetchPixels.getPixelHeight(
                                                    3)),
                                            getCustomFont(
                                                modelTrend.currency ?? "",
                                                15,
                                                subtextColor,
                                                1,
                                                fontWeight: FontWeight.w400)
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        getCustomFont("\$${modelTrend.price}",
                                            15, Colors.black, 1,
                                            fontWeight: FontWeight.w600),
                                        getVerSpace(
                                            FetchPixels.getPixelHeight(5)),
                                        Wrap(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      modelTrend.profit![0] ==
                                                              "-"
                                                          ? errorbg
                                                          : successBg,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          FetchPixels
                                                              .getPixelHeight(
                                                                  21))),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: FetchPixels
                                                      .getPixelHeight(6),
                                                  vertical: FetchPixels
                                                      .getPixelHeight(1)),
                                              child: Row(
                                                children: [
                                                  getSvgImage(modelTrend
                                                              .profit![0] ==
                                                          "-"
                                                      ? "error_icon.svg"
                                                      : 'success_icon.svg'),
                                                  getHorSpace(FetchPixels
                                                      .getPixelHeight(4)),
                                                  getCustomFont(
                                                      modelTrend.profit ?? '',
                                                      13,
                                                      modelTrend.profit![0] ==
                                                              "-"
                                                          ? errorColor
                                                          : successColor,
                                                      1,
                                                      fontWeight:
                                                          FontWeight.w400)
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
                            ))));
                  },
                ),
              );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horspace),
                gettoolbarMenu(context, "back.svg", () {
                  backToPrev();
                },
                    istext: true,
                    title: "Market Trend",
                    fontsize: 24,
                    weight: FontWeight.w700,
                    textColor: Colors.black,
                    isrightimage: true,
                    rightFunction: (){
                  Constant.sendToNext(context, Routes.tabMarketRoute);
                    },
                    rightimage: "search.svg"),
              );
  }
}

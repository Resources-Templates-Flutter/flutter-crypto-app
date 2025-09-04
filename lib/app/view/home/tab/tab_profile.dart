import 'package:crypto_app/app/routes/app_routes.dart';
import 'package:crypto_app/base/color_data.dart';
import 'package:crypto_app/base/constant.dart';
import 'package:crypto_app/base/pref_data.dart';
import 'package:crypto_app/base/resizer/fetch_pixels.dart';
import 'package:crypto_app/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TabProfile extends StatefulWidget {
  const TabProfile({Key? key}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {
  var horspace = FetchPixels.getPixelHeight(20);

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Column(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(14)),
          appBar(context),
          getVerSpace(FetchPixels.getPixelHeight(39)),
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                // ignore: prefer_const_constructors
                physics: BouncingScrollPhysics(),
                child: AnimationLimiter(
                  child: getPaddingWidget(
                    EdgeInsets.symmetric(horizontal: horspace),
                    Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 200),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 44.0,
                          child: FadeInAnimation(child: widget),
                        ),
                        children: [
                          profileImageWidget(),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          getCustomFont("Leslie Alexander", 18, Colors.black, 1,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center),
                          getVerSpace(FetchPixels.getPixelHeight(6)),
                          getCustomFont(
                              "lesliealexander@gmail.com", 15, textColor, 1,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center),
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          myProfileButton(context),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          bankDetailButton(context),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          historyButton(context),
                          getVerSpace(FetchPixels.getPixelHeight(40)),
                          logoutButton(context)
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return getButton(context, Colors.white, "Logout", blueColor,
                          () {
      PrefData.setLogIn(true);
                            Constant.sendToNext(context, Routes.loginRoute);
                          }, 16,
                          weight: FontWeight.w600,
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(15)),
                          buttonHeight: FetchPixels.getPixelHeight(60),
                          isBorder: true,
                          borderColor: blueColor,
                          borderWidth: FetchPixels.getPixelHeight(2));
  }

  GestureDetector historyButton(BuildContext context) {
    return GestureDetector(
                        onTap: () {
                          Constant.sendToNext(context, Routes.historyRoute);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: FetchPixels.getPixelHeight(16),
                              right: FetchPixels.getPixelHeight(16),
                              top: FetchPixels.getPixelHeight(16),
                              bottom: FetchPixels.getPixelHeight(16)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColor,
                                    blurRadius: 23,
                                    offset: const Offset(0, 7))
                              ],
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getSvgImage("history.svg"),
                                  getHorSpace(FetchPixels.getPixelHeight(16)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          "History", 15, Colors.black, 1,
                                          fontWeight: FontWeight.w500),
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(5)),
                                      SizedBox(
                                        width:
                                            FetchPixels.getPixelHeight(220),
                                        child: getMultilineCustomFont(
                                            "All your transactions on coinswitch kuber",
                                            15,
                                            textColor,
                                            fontWeight: FontWeight.w400,
                                            txtHeight:
                                                FetchPixels.getPixelHeight(
                                                    1.3)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              getSvgImage("arrow_right.svg")
                            ],
                          ),
                        ),
                      );
  }

  GestureDetector bankDetailButton(BuildContext context) {
    return GestureDetector(
                        onTap: () {
                          Constant.sendToNext(
                              context, Routes.bankDetailRoute);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: FetchPixels.getPixelHeight(16),
                              right: FetchPixels.getPixelHeight(16),
                              top: FetchPixels.getPixelHeight(16),
                              bottom: FetchPixels.getPixelHeight(16)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColor,
                                    blurRadius: 23,
                                    offset: const Offset(0, 7))
                              ],
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getSvgImage("card.svg"),
                                  getHorSpace(FetchPixels.getPixelHeight(16)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          "Bank Details", 15, Colors.black, 1,
                                          fontWeight: FontWeight.w500),
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(5)),
                                      SizedBox(
                                        width:
                                            FetchPixels.getPixelHeight(220),
                                        child: getMultilineCustomFont(
                                            "This account is used to faciliate all your deposits",
                                            15,
                                            textColor,
                                            fontWeight: FontWeight.w400,
                                            txtHeight:
                                                FetchPixels.getPixelHeight(
                                                    1.3)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              getSvgImage("arrow_right.svg")
                            ],
                          ),
                        ),
                      );
  }

  GestureDetector myProfileButton(BuildContext context) {
    return GestureDetector(
                        onTap: () {
                          Constant.sendToNext(context, Routes.myProfileRoute);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: FetchPixels.getPixelHeight(16),
                              right: FetchPixels.getPixelHeight(16),
                              top: FetchPixels.getPixelHeight(16),
                              bottom: FetchPixels.getPixelHeight(16)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColor,
                                    blurRadius: 23,
                                    offset: const Offset(0, 7))
                              ],
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getSvgImage("profile.svg"),
                                  getHorSpace(FetchPixels.getPixelHeight(16)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          "My Profile", 15, Colors.black, 1,
                                          fontWeight: FontWeight.w500),
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(5)),
                                      SizedBox(
                                        width:
                                            FetchPixels.getPixelHeight(220),
                                        child: getMultilineCustomFont(
                                            "Complete your profile to buy, sell and withdraw",
                                            15,
                                            textColor,
                                            fontWeight: FontWeight.w400,
                                            txtHeight:
                                                FetchPixels.getPixelHeight(
                                                    1.3)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              getSvgImage("arrow_right.svg")
                            ],
                          ),
                        ),
                      );
  }

  Widget profileImageWidget() {
    return getAssetImage("profile_photo.png",
                          height: FetchPixels.getPixelHeight(105),
                          width: FetchPixels.getPixelHeight(105));
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.symmetric(horizontal: horspace),
        gettoolbarMenu(context, "back.svg", () {},
            istext: true,
            title: "Profile",
            fontsize: 24,
            weight: FontWeight.w700,
            textColor: Colors.black,
            isleftimage: false,
            isrightimage: true,
            rightimage: "setting.svg", rightFunction: () {
          Constant.sendToNext(context, Routes.settingRoute);
        }),
      );
  }
}

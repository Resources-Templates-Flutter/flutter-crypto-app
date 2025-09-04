import 'package:crypto_app/app/routes/app_routes.dart';
import 'package:crypto_app/base/color_data.dart';
import 'package:crypto_app/base/constant.dart';
import 'package:crypto_app/base/pref_data.dart';
import 'package:crypto_app/base/resizer/fetch_pixels.dart';
import 'package:crypto_app/base/widget_utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void finishView() {
    Constant.closeApp();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var ispass = false;

  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(20)),
                primary: true,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(98)),
                  getCustomFont("Login", 24, Colors.black, 1,
                      fontWeight: FontWeight.w700, textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getMultilineCustomFont(
                      "Hello, welcome back to Crypto.", 15, Colors.black,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      txtHeight: FetchPixels.getPixelHeight(1.3)),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                      context, "Email", emailController,
                      isEnable: false, height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDefaultTextFiledWithLabel(
                      context, "Password", passwordController,
                      height: FetchPixels.getPixelHeight(60),
                      withSufix: true,
                      suffiximage: "eye.svg",
                      isEnable: false,
                      isPass: ispass, imagefunction: () {
                    setState(() {
                      !ispass ? ispass = true : ispass = false;
                    });
                  }),
                  getVerSpace(FetchPixels.getPixelHeight(19)),
                  GestureDetector(
                    onTap: () {
                      Constant.sendToNext(context, Routes.forgotRoute);
                    },
                    child: getCustomFont("Forgot Password?", 15, blueColor, 1,
                        fontWeight: FontWeight.w600, textAlign: TextAlign.end),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getButton(context, blueColor, "Login", Colors.white, () {
                    PrefData.setLogIn(false);
                    Constant.sendToNext(context, Routes.homeScreenRoute);
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(50)),
                  getCustomFont("Or sign in with", 15, Colors.black, 1,
                      fontWeight: FontWeight.w400, textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Row(
                    children: [
                      Expanded(
                        child: getButton(context, Colors.white, "Google",
                            Colors.black, () {}, 14,
                            weight: FontWeight.w600,
                            isIcon: true,
                            image: "google.svg",
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(12)),
                            boxShadow: [
                              BoxShadow(
                                  color: containerShadow,
                                  blurRadius: 18,
                                  offset: const Offset(0, 4))
                            ],
                            buttonHeight: FetchPixels.getPixelHeight(60)),
                      ),
                      getHorSpace(FetchPixels.getPixelHeight(20)),
                      Expanded(
                        child: getButton(context, Colors.white, "Facebook",
                            Colors.black, () {}, 14,
                            weight: FontWeight.w600,
                            isIcon: true,
                            image: "facebook.svg",
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(12)),
                            boxShadow: [
                              BoxShadow(
                                  color: containerShadow,
                                  blurRadius: 18,
                                  offset: const Offset(0, 4))
                            ],
                            buttonHeight: FetchPixels.getPixelHeight(60)),
                      ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(147)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont(
                          "Don’t have an account? ", 15, Colors.black, 1,
                          fontWeight: FontWeight.w400),
                      GestureDetector(
                        onTap: () {
                          Constant.sendToNext(context, Routes.signUpRoutes);
                        },
                        child: getCustomFont("Sign Up", 15, blueColor, 1,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}

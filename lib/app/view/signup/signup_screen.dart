import 'package:crypto_app/app/routes/app_routes.dart';
import 'package:crypto_app/base/constant.dart';
import 'package:crypto_app/base/pref_data.dart';
import 'package:crypto_app/base/resizer/fetch_pixels.dart';
import 'package:crypto_app/base/widget_utils.dart';
import 'package:flutter/material.dart';

import '../../../base/color_data.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var ispass = false;
  bool agree = false;
  String? image;
  String? code;

  Future<void> doSomeAsyncStuff() async {
    image = await PrefData.getImage();

    code = await PrefData.getCode();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelHeight(20)),
              children: [
                getVerSpace(FetchPixels.getPixelHeight(98)),
                getCustomFont("Sign Up", 24, Colors.black, 1,
                    fontWeight: FontWeight.w700, textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getMultilineCustomFont(
                    "Enter your detail for sign up!", 15, Colors.black,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    txtHeight: FetchPixels.getPixelHeight(1.3)),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getDefaultTextFiledWithLabel(context, "Name", nameController,
                    height: FetchPixels.getPixelHeight(60), isEnable: false),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getDefaultTextFiledWithLabel(context, "Email", emailController,
                    height: FetchPixels.getPixelHeight(60), isEnable: false),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.selectCountryRoute)
                          .then((value) {
                        setState(() {
                          doSomeAsyncStuff();
                        });
                      });
                    },
                    child: getCountryTextField(context, "Phone Number",
                        phoneNumberController, code ?? "+1",
                        function: () {},
                        height: FetchPixels.getPixelHeight(60),
                        isEnable: false,
                        minLines: true,
                        image: image ?? "image_albania.jpg")),
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
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          agree = !agree;
                        });
                      },
                      child: Container(
                        height: FetchPixels.getPixelHeight(24),
                        width: FetchPixels.getPixelHeight(24),
                        decoration: BoxDecoration(
                            color: (agree) ? blueColor : Colors.white,
                            border: (agree)
                                ? null
                                : Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(6))),
                        padding: EdgeInsets.symmetric(
                            vertical: FetchPixels.getPixelHeight(6),
                            horizontal: FetchPixels.getPixelWidth(4)),
                        child: (agree) ? getSvgImage("done.svg") : null,
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    getCustomFont(
                        "I agree with Terms & Privacy", 16, Colors.black, 1,
                        fontWeight: FontWeight.w400)
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getButton(context, blueColor, "Sign up", Colors.white, () {
                  agree
                      ? Constant.sendToNext(context, Routes.verifyRoute)
                      : null;
                }, 16,
                    weight: FontWeight.w600,
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                    buttonHeight: FetchPixels.getPixelHeight(60)),
                getVerSpace(FetchPixels.getPixelHeight(136)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getCustomFont(
                        "Already have an account? ", 15, Colors.black, 1,
                        fontWeight: FontWeight.w400),
                    GestureDetector(
                      onTap: () {
                        Constant.sendToNext(context, Routes.loginRoute);
                      },
                      child: getCustomFont("Login", 15, blueColor, 1,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}

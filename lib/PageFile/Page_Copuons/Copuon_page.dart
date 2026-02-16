
import 'package:coppon_3pp/PageFile/MyHomePage/Model-MyHomePage/Coupons_Model.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/MyHomePageController.dart';
import 'package:flutter/material.dart' ;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import '../../DartMode/theme_service.dart';

class PageCoupon extends GetView {

  final CouponsModel couponsModel;
   PageCoupon({Key? key, required this.couponsModel,}) : super(key: key);
  final controller = Get.find<MyHomePageControlle>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SimpleGestureDetector(
        onHorizontalSwipe: (SwipeDirection direction) {
      if (direction == SwipeDirection.right) {
        Get.back();
      }
          },
          child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                  image: DecorationImage(
          
          image: ThemeService().isSavedDarkMode()
              ? const AssetImage('assets/images/BK_BG.png')
              : const AssetImage('assets/images/bank.png'),          fit: BoxFit.fill,
                  ),
                ),
                  child: SingleChildScrollView(
                    child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *0.50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height *0.11,
                      // color: ThemeService().isSavedDarkMode() ? Colors.black:Color.fromRGBO(176, 228, 221, 1.0),
                      color: Color(couponsModel.ColorBG!),
                              
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top:20,left: 10,right: 10),
                              
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Container(
                              
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                    color:ThemeService().isSavedDarkMode() ?  Colors.white: Colors.white,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(couponsModel.name!,
                                  style:TextStyle(fontSize: 25,
                              
                                      color:ThemeService().isSavedDarkMode() ?  Colors.white: Colors.white,
                                      fontStyle:FontStyle.normal) ,),),
                              Container(
                              
                                child:  IconButton(
                              
                                  icon:Icon( Icons.share,
                                    color:ThemeService().isSavedDarkMode() ?  Colors.white: Colors.white,
                                  ),
                                  onPressed: () {
                              
                                  },
                                ),
                              
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                              
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: Color(couponsModel.ColorBG!),
                              
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.only(
                              
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)
                        ),
                      ),
                      height: MediaQuery.of(context).size.height *0.32,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // image
                            height: MediaQuery.of(context).size.height *0.22,
                            width: MediaQuery.of(context).size.width*0.66,
                            child: Image.network(couponsModel.image!),
                          ),

                        ],
                      ),
                    ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height *0.5,
                                   // color: Colors.lightGreenAccent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                    Container(
                      alignment:Alignment.center,
                              
                      width: MediaQuery.of(context).size.width*0.85,
                      height: MediaQuery.of(context).size.height *0.285,
                              
                      child:Directionality(
                        textDirection: TextDirection.rtl,
                        child: ReadMoreText(
                          couponsModel.discount_description!,
                          trimLines: 5,
                          colorClickableText: Colors.orange,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'عرض المزيد',
                          trimExpandedText: 'اخفاء',
                          moreStyle: TextStyle(
                              
                              fontSize: 16,
                              fontFamily: 'CairoLight',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                              
                    ),
                    Container(
                      width: Get.width * 0.90,
                              
                      child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              
                             GestureDetector(
                              onTap:(){
                                controller.mnagfavourites(couponsModel.IdNumber!);
                              },
                              child: Container(
                                width: Get.width * 0.35,
                                height:Get.height * 0.05 ,
                                child: controller.isfavourites(couponsModel.IdNumber!)?
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: Get.size.width *0.1,
                                ) : Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                  size: Get.size.width *0.1,
                                ),
                              
                              ),
                            ),
                              
                             Text("اعجاب",
                               style: TextStyle(
                                 color:ThemeService().isSavedDarkMode() ?  Colors.white: Colors.white,
                              
                                 fontFamily: 'Cairo',
                               fontWeight: FontWeight.bold,
                               fontSize: 12,
                             ),
                             ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                              
                            children: [
                              Container(
                                width: Get.width * 0.30,
                                height: Get.height * 0.075,
                                decoration: ShapeDecoration(
                                  color: Colors.orange[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ),
                              Column(
                              
                                children: [
                                  Container(
                                    child: Icon(Icons.stars_rounded, size: 17,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                              
                                      SizedBox(
                                        width: Get.width * 0.22,
                                        child: Row(
                                          children: [
                              
                                            Text(
                                              '%',
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              couponsModel.discount_rate!,
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              ' :الخصم',
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                              
                                          ],
                                        ),
                                      ),
                              
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                              
                        ],
                      ),),
                    ),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.13,
                                    color: Colors.pinkAccent[20],
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        // تحديد المحاذاة بناءً على وجود الكوبون
                                        mainAxisAlignment: couponsModel.coupon != null &&
                                           couponsModel.coupon!.isNotEmpty
                                            ? MainAxisAlignment.spaceBetween
                                            : MainAxisAlignment.center, // إذا لم يكن هناك كوبون، ضع الزر في المنتصف

                                        children: [
                                          // زر "اذهب للتطبيق"
                                          Container(
                                            height: MediaQuery.of(context).size.height * 0.066,
                                            width: MediaQuery.of(context).size.width * 0.41,
                                            decoration: ShapeDecoration(
                                              color: Color(couponsModel.ColorBG!),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                controller.openlink(couponsModel.website!);
                                              },
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.shopping_cart_outlined, color: Colors.white),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'اذهب للتطبيق',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Cairo',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 19,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                          // التحقق من الكوبون
                                          if (couponsModel.coupon != "null" &&
                                              couponsModel.coupon!.isNotEmpty)
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: MediaQuery.of(context).size.height * 0.033,
                                                  width: MediaQuery.of(context).size.width * 0.22,
                                                  child: Text(
                                                    'انسخ الكوبون',
                                                    style: TextStyle(
                                                      color: ThemeService().isSavedDarkMode()
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontFamily: 'CairoLight',
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),

                                                // زر نسخ الكوبون
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(7),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Color(couponsModel.ColorBG!),
                                                      width: 1,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                  height: MediaQuery.of(context).size.height * 0.066,
                                                  width: MediaQuery.of(context).size.width * 0.4,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.copy,
                                                        color: Color(couponsModel.ColorBG!),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Clipboard.setData(ClipboardData(
                                                              text: couponsModel.coupon!));
                                                        },
                                                        child: Text(
                                                          couponsModel.coupon!,
                                                          style: TextStyle(
                                                            color: ThemeService().isSavedDarkMode()
                                                                ? Colors.black87
                                                                : Color(couponsModel.ColorBG!),
                                                            fontFamily: 'Cairo',
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  ],
                                  ),
                                ),
                              ],
                    ),
                  ),
          
                ),
          ));
  }


}
import 'package:coppon_3pp/DartMode/theme_service.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/MyHomePageController.dart';
import 'package:coppon_3pp/PageFile/My_Like_Page/like_page.dart';
import 'package:coppon_3pp/PageFile/Search_Page/Search_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';


class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  ///final  controller = MyHomePageControlle();
  bool showCoupon = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyHomePageControlle>(
        builder:(controller) =>Scaffold(

          body:SafeArea(
            child: SimpleGestureDetector(
              onHorizontalSwipe: (SwipeDirection direction) {
                if (direction == SwipeDirection.right) {
                  Get.to(()=>Like_page());
                }else if (direction == SwipeDirection.left) {
                  Get.to(() => Search_Page());
                }
              },
              child:Container(

                width: MediaQuery.of(context).size.width ,
                decoration:  BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      //فلتر على صورة الخلفية
                      ThemeService().isSavedDarkMode() ?Color(0xFF000000).withOpacity(0.4)
                          :Color(0xFFFFFF0).withOpacity(0.4),
                      BlendMode.srcOver,),
                    image: ThemeService().isSavedDarkMode()
                        ? const AssetImage('assets/images/BK_BG.png')
                        : const AssetImage('assets/images/bank.png'),          fit: BoxFit.fill,
                  ),
                ),
                //  color: Colors.blueAccent,
                //color: ThemeService().isSavedDarkMode() ? Colors.black26 : Colors.white,
                child: Stack(

                  alignment:Alignment.center,
                  children: [
                    Container(
                      height:MediaQuery.of(context).size.height  ,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                                     //// فيه البنر العلوي و البوكس الاحمر و الاخضر/
                                   /// color: Colors.cyan,

                              width: MediaQuery.of(context).size.width ,
                              height:MediaQuery.of(context).size.height *0.354,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),// مسافة بين الـ Widgets
                                  Container(

                                    //البنر و البوكسات
                                      width: MediaQuery.of(context).size.width * 0.96,
                                      height:MediaQuery.of(context).size.height *0.171,
                                    child: PageView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.bannerFirstModel.length,
                                      itemBuilder: (context, index) {
                                        return  GestureDetector(
                                          onTap: () async {
                                            await controller.openUrl(controller.bannerFirstModel[index].website!);
                                          },
                                          child: Container(

                                            // البنر العلوي

                                            height: double.infinity, // Takes all available space
                                            width: double.infinity,
                                            decoration: BoxDecoration(

                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),  // تنعيم الحواف
                                                topRight: Radius.circular(15),
                                                bottomRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              image:  DecorationImage(
                                                image: NetworkImage(controller.bannerFirstModel[index].image!),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),// مسافة بين الـ Widgets
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      // البوكس الأحمر
                                      // داخل البوكس الأحمر
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        height: MediaQuery.of(context).size.height * 0.151,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8, bottom: 2),
                                              child: Text(
                                                'عروض مختارة',
                                                style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: Get.size.width * 0.04,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            // حل overflow هنا
                                            Expanded( // ✅ هذا سيجعل باقي المحتوى يملأ المساحة بدون تجاوز
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: GetBuilder<MyHomePageControlle>(
                                                  builder: (controller) => Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: List.generate(controller.boxRedAdModel.length, (index) {
                                                      return Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () => controller.openUrl(controller.boxRedAdModel[index].website!),
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 2),
                                                              child: Container(
                                                                width: Get.width * 0.23,
                                                                height: MediaQuery.of(context).size.height * 0.08,
                                                                decoration: ShapeDecoration(
                                                                  image: DecorationImage(
                                                                    image: NetworkImage(controller.boxRedAdModel[index].image!),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                "ر.س ",
                                                                style: TextStyle(
                                                                  color: Colors.red,
                                                                  fontSize: Get.size.width * 0.032,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w800,
                                                                ),
                                                              ),
                                                              Text(
                                                                controller.boxRedAdModel[index].price_after!,
                                                                style: TextStyle(
                                                                  color: Colors.red,
                                                                  fontSize: Get.size.width * 0.032,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w800,
                                                                ),
                                                              ),
                                                              SizedBox(width: 4),
                                                              Text(
                                                                controller.boxRedAdModel[index].Price_before!,
                                                                style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: Get.size.width * 0.018,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w800,
                                                                  decoration: TextDecoration.lineThrough,
                                                                  decorationColor: Colors.redAccent,
                                                                  decorationThickness: 1.5,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),




                                      // البوكس الأخضر
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        height: MediaQuery.of(context).size.height * 0.151,
                                        width: MediaQuery.of(context).size.width * 0.46,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GetBuilder<MyHomePageControlle>(
                                                      builder: (controller) => Row(
                                                        children: List.generate(controller.boxGreenAdModel.length, (index) {
                                                          return Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () => controller.openUrl(controller.boxGreenAdModel[index].website!),
                                                                child: Container(
                                                                  width: Get.width * 0.18,
                                                                  height: MediaQuery.of(context).size.height * 0.088,
                                                                  decoration: ShapeDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(controller.boxGreenAdModel[index].image!),
                                                                      fit: BoxFit.fill,
                                                                    ),
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 4),
                                                              Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Text(
                                                                    "ر.س ",
                                                                    style: TextStyle(
                                                                      color: Colors.red,
                                                                      fontSize: Get.size.width * 0.033,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w800,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller.boxGreenAdModel[index].price_after!,
                                                                    style: TextStyle(
                                                                      color: Colors.red,
                                                                      fontSize: Get.size.width * 0.034,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w800,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 4),
                                                                  Text(
                                                                    controller.boxGreenAdModel[index].Price_before!,
                                                                    style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontSize: Get.size.width * 0.02,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w800,
                                                                      decoration: TextDecoration.lineThrough,
                                                                      decorationColor: Colors.redAccent,
                                                                      decorationThickness: 2.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    // البوكس الأصلي الخاص بـ "جديد" و "تحديث أسبوعي"
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "جديد",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: Get.size.width * 0.06,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w800,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4),
                                                        Container(
                                                          width: Get.width * 0.23,
                                                          height: Get.height * 0.026,
                                                          decoration: BoxDecoration(
                                                            color: Colors.greenAccent,
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "تحديث اسبوعي",
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 10,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w800,
                                                                ),
                                                              ),
                                                              SizedBox(width: 4),
                                                              Icon(
                                                                Icons.stars_rounded,
                                                                size: Get.size.width * 0.03,
                                                                color: Colors.green,
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
                                  )

                                  // النقاط الي تحت الصور
                                  ///  controller.circleSlider(controller.currentIndex),
                                ],
                              ),
                            ),
                            Container(
                    //color: Colors.red,
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.006),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                                    child: Text(
                                      "عروض مختارة⚡",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.02,
                                        color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black45,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                  // حاوية لتحديد ارتفاع الـ ListView
                                  // حاوية لتحديد ارتفاع الـ ListView
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.22,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal, // تمرير أفقي
                                      itemCount: controller.selectedOffersV1Model.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => controller.openUrl(controller.selectedOffersV1Model[index].website!),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015),
                                            width: MediaQuery.of(context).size.width * 0.32,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              image: DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                  ThemeService().isSavedDarkMode()
                                                      ? Color(0xFF000000).withOpacity(0.09)
                                                      : Color(0xFFFFFF0).withOpacity(0.09),
                                                  BlendMode.srcOver,
                                                ),
                                                image: NetworkImage(
                                                  controller.selectedOffersV1Model[index].image!,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            GetBuilder<MyHomePageControlle>(

                              // التصنيفات

                              builder: (controller) => Row(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                  Container(
                                    width: MediaQuery.of(context).size.width *0.98,
                                    height: MediaQuery.of(context).size.height * 0.07, // زيادة ارتفاع التصنيفات
                                    child: ListView.separated(
                                      itemCount: controller.catageriesModel.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) => SizedBox(
                                        width: MediaQuery.of(context).size.width *0.01, // المسافة بين العناصر
                                      ),
                                      itemBuilder: (context, index) {
                                        final bool isSelected = index == controller.selectedIndex; // حفظ حالة التحديد
                                  
                                        return AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                         // margin: EdgeInsets.only(left: 5, right: 2), // زيادة الهامش
                                          padding: const EdgeInsets.symmetric(horizontal: 10), // إضافة مساحة داخلية
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: isSelected
                                                ? Colors.orange[200] // لون التصنيف المحدد
                                                : ThemeService().isSavedDarkMode()
                                                ? Colors.white12
                                                : Colors.white54,
                                            border: Border.all(
                                              width: 0.1,
                                              color: ThemeService().isSavedDarkMode()
                                                  ? Colors.white10
                                                  : Colors.orange,
                                            ),
                                          ),
                                          height: Get.height * 0.06,
                                          child: InkWell(
                                            onTap: () {
                                              String? categoryId = controller.catageriesModel[index].id?.trim();
                                              if (categoryId != null) {
                                                if (categoryId == 'all') {
                                                  controller.addSearchWithCatageryALL();
                                                } else {
                                                  controller.addSearchWithCatagerylist(categoryId);
                                                }
                                              }
                                  
                                              controller.selectedIndex = index;
                                  
                                              // تحديث زاوية الدوران للأيقونة عند الضغط
                                              controller.rotationAngles[index] += 360;
                                  
                                              controller.update(); // تحديث GetBuilder لتغيير الواجهة
                                            },
                                            child: IntrinsicWidth(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  AnimatedRotation(
                                                    duration: Duration(milliseconds: 500), // مدة الدوران
                                                    turns: controller.rotationAngles[index] / 360, // تحويل الزاوية إلى دوران
                                                    child: Icon(
                                                      iconMapList[index]['icon'],
                                                      size: Get.size.width * 0.08, // أيقونة أكبر
                                                      color: isSelected ? Colors.white : _categories[index]['color'],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 4), // ضبط المسافة هنا
                                                    child: Text(
                                                      controller.catageriesModel[index].name!,
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
                                                        fontSize: 15, // خط أكبر
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            // الجسم السفلي الكوبنات

                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                                Text(
                                  "الكوبونات",
                                  textDirection: TextDirection.rtl, // النص من اليمين لليسار
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.021 ,
                                    color:ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                            Column(
                              children: [


                                Row(
                                  children: [
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                    SingleChildScrollView(
                                        child:  GetBuilder<MyHomePageControlle>(
                                            builder: (controller) =>  Container(
                                                decoration: BoxDecoration(
                                                  // color: ThemeService().isSavedDarkMode() ?  Colors.black87: Colors.white,
                                                // color: Colors.yellowAccent,
                                                ),
                                                width: MediaQuery.of(context).size.width *0.97,
                                                height:MediaQuery.of(context).size.height *0.26,

                                                child: ListView.separated(
                                                    itemCount: controller.catagerylist.length,
                                                    separatorBuilder: (context, index) =>SizedBox(
                                                      width: MediaQuery.of(context).size.width *0.005, // المسافة بين العناصر
                                                    ),
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, index) {
                                                      return   GestureDetector(
                                                        onTap:(){

                                                          ////// Get.to(()=>PageCoupon(couponsModel:controller.catagerylist[index],));
                                                        },
                                                        child: Row(

                                                          children: [
                                                            SizedBox(
                                                                width: MediaQuery.of(context).size.width * 0.01
                                                            ),

                                                            Container(
                                                              // الكوبون المربع الشكل
                                                              decoration: BoxDecoration(
                                                                border: Border.all( width: 0.3,  color: ThemeService().isSavedDarkMode() ? Colors.orange: Colors.orange ),

                                                                //color:Colors.black12,
                                                                color: ThemeService().isSavedDarkMode() ? Colors.black45:  Colors.white54,
                                                                // لون الخلفية
                                                                borderRadius: BorderRadius.circular(12), // تحديد نصف قطر الزوايا
                                                              ),
                                                              height: MediaQuery.of(context).size.height * 0.25,
                                                              width: MediaQuery.of(context).size.width * 0.40,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                                children: [
                                                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),// مسافة بين الـ Widgets

                                                                  Center(
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Container(
                                                                          height: Get.height * 0.1000,
                                                                          width: Get.width * 0.080,
                                                                         ///color: Colors.cyan,

                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [


                                                                              GestureDetector(
                                                                                onTap:(){
                                                                                  controller.mnagfavourites(controller.catagerylist[index].IdNumber!);
                                                                                },
                                                                                child:Obx(() => Container(
                                                                                  child: controller.isfavourites(controller.catagerylist[index].IdNumber!)?
                                                                                  Icon(
                                                                                    Icons.favorite,
                                                                                    color: Colors.red,
                                                                                    size: Get.size.width *0.080,
                                                                                  ) :Icon(
                                                                                    Icons.favorite_border,
                                                                                    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.orange,
                                                                                    size: Get.size.width *0.080,
                                                                                  ),

                                                                                ),),
                                                                              ),

                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: Get.width * 0.226,
                                                                          height: Get.height * 0.1032,
                                                                          // color: Colors.cyan,

                                                                          child: Container(
                                                                            child: Stack(

                                                                              children: [
                                                                                Positioned(
                                                                                  left: 0,
                                                                                  top: 0,
                                                                                  child: Container(
                                                                                    width: 86, // حافظ على العرض للاتساق
                                                                                    height: 80, // اضبط الارتفاع ليكون مساويًا للعرض للحصول على مربع
                                                                                    decoration: ShapeDecoration(
                                                                                      shape: RoundedRectangleBorder( // استخدم RoundedRectangleBorder للمربع ذو الزوايا المستديرة (اختياري)
                                                                                        borderRadius: BorderRadius.circular(37.0), // اضبط تقريب الزاوية إلى 0 للحصول على مربع مثالي
                                                                                        side: BorderSide(
                                                                                          width: 0.5,
                                                                                          strokeAlign: BorderSide.strokeAlignCenter,
                                                                                          color: Color(controller.catagerylist[index].ColorBG!),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),

                                                                                Positioned(
                                                                                  left: 8,
                                                                                  top: 9.2,
                                                                                  child: Container(
                                                                                    width: Get.width * 0.18,
                                                                                    height: MediaQuery
                                                                                        .of(context)
                                                                                        .size
                                                                                        .height * 0.08,
                                                                                    decoration: ShapeDecoration(
                                                                                      image: DecorationImage(
                                                                                        image: NetworkImage(
                                                                                            controller.catagerylist[index].image!),
                                                                                        fit: BoxFit.fill,
                                                                                      ),
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(29),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: Get.width * 0.08,
                                                                          height: Get.height * 0.1000,
                                                                          ///   color: Colors.cyan,
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap:(){

                                                                                  // تأكد من أن البيانات غير فارغة أو null
                                                                                  if (controller.catagerylist.isNotEmpty && controller.catagerylist[index] != null) {
                                                                                    String name = controller.catagerylist[index].name ?? "غير محدد";
                                                                                    String description = controller.catagerylist[index].describe ?? "لا يوجد وصف";
                                                                                    String coupon = controller.catagerylist[index].coupon ?? "لا يوجد كوبون";
                                                                                    String website = controller.catagerylist[index].website ?? ""; // رابط العرض

                                                                                    // بناء النص الذي سيتم نسخه مع رابط التطبيق ورابط العرض
                                                                                    String textToCopy = "لايفوتك هذا العرض الرهيب الحصري من تطبيق اكواد خصم😮😎\n"
                                                                                        " العرض من  $name\n"
                                                                                        "وصف العرض 👌🌟: $description\n";

                                                                                    // إضافة الكوبون إذا كان موجودًا وغير فارغ
                                                                                    if (coupon.isNotEmpty && coupon != "لا يوجد كوبون") {
                                                                                      textToCopy += "\n كوبون الخصم👏: $coupon\n";
                                                                                    }

                                                                                    textToCopy += " رابط للحصول على العرض🎯:\n $website\n"
                                                                                        "رابط تحميل التطبيق🔶:\n  https://bit.ly/41OHYH1 ";

                                                                                    // نسخ النص إلى الحافظة
                                                                                    Clipboard.setData(ClipboardData(text: textToCopy));

                                                                                    // عرض رسالة تأكيد
                                                                                    Get.snackbar(
                                                                                      "نجاح✅",
                                                                                      "شارك هذا العرض مع من تحب💕",
                                                                                      snackPosition: SnackPosition.TOP,
                                                                                      backgroundColor: Colors.orange.withOpacity(0.4), // لون برتقالي شفاف
                                                                                      colorText: Colors.white, // لون النص أبيض
                                                                                      snackStyle: SnackStyle.FLOATING, // تصميم شبيه بالزجاج
                                                                                      titleText: Text(
                                                                                        "نجاح",
                                                                                        textDirection: TextDirection.rtl, // النص من اليمين لليسار
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                      ),
                                                                                      messageText: Text(
                                                                                        "شارك هذا العرض مع من تحب💕",
                                                                                        textDirection: TextDirection.rtl, // النص من اليمين لليسار
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  } else {
                                                                                    // إذا كانت البيانات غير موجودة أو فارغة
                                                                                    Get.snackbar("خطأ", "بيانات العنصر غير موجودة.", snackPosition: SnackPosition.BOTTOM);
                                                                                  }
                                                                                },
                                                                                child:
                                                                                Container(

                                                                                  width: Get.width * 0.08,
                                                                                  height:Get.height * 0.015 ,
                                                                                  child: Icon(
                                                                                    Icons.share,
                                                                                    size: Get.size.width * 0.063,
                                                                                    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.orange,
                                                                                  ),

                                                                                ),
                                                                              ),

                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  Center(
                                                                    child: Container(
                                                                      //color: Colors.white,
                                                                      width: Get.width * 0.37,
                                                                      height: Get.height * 0.075,
                                                                      child: Center(
                                                                        child: Column(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                          children: [
                                                                            Flexible( // ✅ يجعل النص يتكيف داخل العمود بدون overflow
                                                                              child: Text(
                                                                                controller.catagerylist[index].describe!,
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ThemeService().isSavedDarkMode()
                                                                                      ? Colors.white
                                                                                      : Color(4282400832),
                                                                                  fontSize: 12,
                                                                                  fontFamily: 'Inter',
                                                                                ),
                                                                                maxLines: 2, // ✅ تحديد أقصى عدد الأسطر لتجنب overflow
                                                                                overflow: TextOverflow.ellipsis, // ✅ يضيف ... إذا تجاوز النص الحد
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )

                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Center(
                                                                    child: Stack(
                                                                      children: [
                                                                        Container(
                                                                          width: Get.width * 0.38,
                                                                          height: Get.height * 0.057,
                                                                          decoration:  BoxDecoration(
                                                                            borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight:Radius.circular(10) ,
                                                                              bottomRight: Radius.circular(10),
                                                                              bottomLeft:  Radius.circular(10),
                                                                            ),
                                                                            // color: Color.fromRGBO(176, 228, 221, 1.0),
                                                                            color: Color(controller.catagerylist[index].ColorBG!),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:(){
                                                                            /// controller.mnagfavourites(controller.couponsModel[index].IdNumber!);
                                                                            showModalBottomSheet(

                                                                                context: context,
                                                                                builder: (context){
                                                                                  return SafeArea(
                                                                                    minimum: EdgeInsets.only(bottom:Get.height * 0.057),
                                                                                    child: Container(

                                                                                      child: Stack(
                                                                                        alignment: Alignment.topCenter,
                                                                                        children: [

                                                                                          Container(
                                                                                            height: MediaQuery.of(context).size.height * 0.45,
                                                                                            width: MediaQuery.of(context).size.width ,
                                                                                            decoration:  BoxDecoration(
                                                                                              borderRadius: BorderRadius.only(
                                                                                                  topLeft: Radius.circular(30),
                                                                                                  topRight: Radius.circular(30),

                                                                                              ),
                                                                                              image: DecorationImage(

                                                                                                image: ThemeService().isSavedDarkMode()
                                                                                                    ? const AssetImage('assets/images/BK_BG.png')
                                                                                                    : const AssetImage('assets/images/bank.png'),          fit: BoxFit.fill,
                                                                                              ),
                                                                                            ),
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Container(
                                                                                                  height: MediaQuery.of(context).size.height *0.175,
                                                                                                  width: MediaQuery.of(context).size.width,
                                                                                                  // ignore: prefer_const_constructors
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Color(controller.catagerylist[index].ColorBG!),

                                                                                                    // ignore: prefer_const_constructors
                                                                                                    borderRadius: BorderRadius.only(
                                                                                                        topLeft: Radius.circular(28),
                                                                                                        topRight: Radius.circular(28),
                                                                                                        bottomRight: Radius.circular(28),
                                                                                                        bottomLeft: Radius.circular(28)
                                                                                                    ),
                                                                                                  ),

                                                                                                  child: Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        // image
                                                                                                        height: MediaQuery.of(context).size.height *0.1,
                                                                                                        width: MediaQuery.of(context).size.width*0.30,
                                                                                                        child: Image.network(controller.catagerylist[index].image!),
                                                                                                      ),
                                                                                                      /// الاسم ااسفل الايقونة
                                                                                                      Container(

                                                                                                        alignment: Alignment.center,
                                                                                                        height: MediaQuery.of(context).size.height*0.05,
                                                                                                        width:MediaQuery.of(context).size.width,

                                                                                                        child: Text(
                                                                                                          controller.catagerylist[index].name!,style:

                                                                                                        TextStyle(

                                                                                                          color: Colors.white,
                                                                                                          fontFamily: 'Cairo',
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontSize: 20,
                                                                                                        ),),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                ),

                                                                                                Center(
                                                                                                  child: Container(
                                                                                                    ///color: Colors.white,
                                                                                                    width: Get.width * 0.8,
                                                                                                    height: Get.height * 0.09,
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          controller.catagerylist[index].describe!,
                                                                                                          // "خصم حصري حتا 30% + اضافة باقة 400 ريال",
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: TextStyle(
                                                                                                            color: ThemeService().isSavedDarkMode() ?  Colors.white:Color(4282400832),
                                                                                                            //color: Color(4282400832),

                                                                                                            fontSize: 15,
                                                                                                            fontFamily: 'Inter',
                                                                                                            //fontWeight: FontWeight.w400,
                                                                                                          ),
                                                                                                        ),

                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  width: MediaQuery.of(context).size.width * 0.8,
                                                                                                  height: Get.height * 0.03,
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    children: [
                                                                                                      Stack(
                                                                                                        alignment: Alignment.center,
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            width: Get.width * 0.3,
                                                                                                            height: Get.height * 0.03,
                                                                                                            decoration: ShapeDecoration(
                                                                                                              color: Color(controller.catagerylist[index].ColorBG!),
                                                                                                              shape: RoundedRectangleBorder(
                                                                                                                borderRadius: BorderRadius.circular(15),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              Container(
                                                                                                                width: Get.width * 0.24,
                                                                                                                child: Animate(
                                                                                                                  effects: [
                                                                                                                    FadeEffect(duration: Duration(milliseconds: 300)),
                                                                                                                    ScaleEffect(duration: Duration(milliseconds: 300)),
                                                                                                                  ],
                                                                                                                  child: Row(
                                                                                                                    children: [


                                                                                                                      Text(
                                                                                                                         'الخصم ⚡' ,
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.white,
                                                                                                                          fontSize: 12,
                                                                                                                          fontFamily: 'Inter',
                                                                                                                          fontWeight: FontWeight.w400,
                                                                                                                        ),
                                                                                                                      ),

                                                                                                                      Text(
                                                                                                                        controller.catagerylist[index].discount_rate!,
                                                                                                                        style: TextStyle(
                                                                                                                          ///  color: Color(controller.catagerylist[index].ColorBG!),
                                                                                                                          color: Colors.white,
                                                                                                                          fontSize: 16,
                                                                                                                          fontFamily: 'Inter',
                                                                                                                          fontWeight: FontWeight.w400,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      Text(
                                                                                                                        '%',
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.white,
                                                                                                                          fontSize: 13,
                                                                                                                          fontFamily: 'Inter',
                                                                                                                          fontWeight: FontWeight.w400,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),


                                                                                                 Container(
                                                                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                                                                    //color: Colors.pinkAccent,
                                                                                                    width: MediaQuery.of(context).size.width,
                                                                                                    child: Column(
                                                                                                      // تحديد المحاذاة بناءً على وجود الكوبون
                                                                                                      mainAxisAlignment: controller.catagerylist[index].coupon != null &&
                                                                                                          controller.catagerylist[index].coupon!.isNotEmpty
                                                                                                          ? MainAxisAlignment.center
                                                                                                          : MainAxisAlignment.center, // إذا لم يكن هناك كوبون، ضع الزر في المنتصف

                                                                                                      children: [
                                                                                                        // زر الذهاب للتطبيق
                                                                                                        Container(
                                                                                                          height: MediaQuery.of(context).size.height * 0.07,
                                                                                                          width: MediaQuery.of(context).size.width * 0.9,
                                                                                                          decoration: ShapeDecoration(
                                                                                                            color: Color(controller.catagerylist[index].ColorBG!),
                                                                                                            shape: RoundedRectangleBorder(
                                                                                                              borderRadius: BorderRadius.circular(17),
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: TextButton(
                                                                                                            onPressed: () {
                                                                                                              // فتح الرابط
                                                                                                              controller.openlink(controller.catagerylist[index].website!);

                                                                                                              // إذا كان هناك كوبون، قم بنسخه
                                                                                                              if (controller.catagerylist[index].coupon != null &&
                                                                                                                  controller.catagerylist[index].coupon!.isNotEmpty) {
                                                                                                                Clipboard.setData(
                                                                                                                  ClipboardData(text: controller.catagerylist[index].coupon!),
                                                                                                                );

                                                                                                                // إظهار رسالة تأكيد النسخ
                                                                                                                Get.snackbar("نجاح", "تم نسخ الكوبون ✅",
                                                                                                                  colorText: Colors.grey,
                                                                                                                  snackPosition: SnackPosition.TOP,
                                                                                                                  /// backgroundColor:Colors.green,
                                                                                                                );
                                                                                                              }
                                                                                                            },

                                                                                                            child: Animate(
                                                                                                              effects: [
                                                                                                                FadeEffect(duration: Duration(milliseconds: 200)),
                                                                                                                ScaleEffect(duration: Duration(milliseconds: 200)),
                                                                                                              ],
                                                                                                              child: Container(
                                                                                                                child: Row(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                  children: [
                                                                                                                    Text(
                                                                                                                      controller.catagerylist[index].coupon != null &&
                                                                                                                          controller.catagerylist[index].coupon!.isNotEmpty
                                                                                                                          ?'انسخ و اذهب للتطبيق':'احصل على العرض',
                                                                                                                      style: TextStyle(
                                                                                                                        color: Colors.white,
                                                                                                                        fontFamily: 'Cairo',
                                                                                                                        fontWeight: FontWeight.bold,
                                                                                                                        fontSize: 20,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Icon(
                                                                                                                      Icons.shopping_cart_outlined,
                                                                                                                      color: Colors.white,
                                                                                                                    ),

                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: MediaQuery.of(context).size.height * 0.002,
                                                                                                        ),
                                                                                                        // عرض الكوبون فقط إذا كان موجودًا
                                                                                                        if (controller.catagerylist[index].coupon != "null" &&
                                                                                                            controller.catagerylist[index].coupon!.isNotEmpty)
                                                                                                          CouponWidget(
                                                                                                            /// دالة نسخ الكوبون
                                                                                                            controller.catagerylist[index].coupon,  // تمرير قيمة الكوبون كـ String
                                                                                                            index,
                                                                                                            colorBG: controller.catagerylist[index].ColorBG!,
                                                                                                            couponsModel: controller.catagerylist[index],  // تمرير النموذج الكامل
                                                                                                          ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),

                                                                                              ],
                                                                                            ),

                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(top:8,left: 8,right: 8),

                                                                                            child: Container(
                                                                                              alignment:Alignment.topCenter,
                                                                                              height: MediaQuery.of(context).size.height*0.3,
                                                                                             //color:Colors.deepPurpleAccent,
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    children: [
                                                                                                      GestureDetector(
                                                                                                        onTap:(){
                                                                                                          controller.mnagfavourites(controller.catagerylist[index].IdNumber!);
                                                                                                        },
                                                                                                        child:Obx(() => Container(

                                                                                                          child: controller.isfavourites(controller.catagerylist[index].IdNumber!)?
                                                                                                          Icon(
                                                                                                            Icons.favorite,
                                                                                                            color: Colors.red,
                                                                                                            size: Get.size.width *0.09,
                                                                                                          ) :Icon(
                                                                                                            Icons.favorite_border,
                                                                                                            color: Colors.white,
                                                                                                            size: Get.size.width *0.09,
                                                                                                          ),

                                                                                                        ),),
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: MediaQuery.of(context).size.width * 0.04,
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                  Container(
                                                                                                 //color:Colors.deepPurpleAccent,
                                                                                                    height: MediaQuery.of(context).size.height*0.15,
                                                                                                    child: Column(
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [

                                                                                                        Container(

                                                                                                          child: IconButton(
                                                                                                            icon: Icon(
                                                                                                              Icons.arrow_forward,
                                                                                                              size: MediaQuery.of(context).size.height*0.04,
                                                                                                              color:Colors.white,
                                                                                                            ),
                                                                                                            onPressed: () {
                                                                                                              Get.back();
                                                                                                            },
                                                                                                          ),),

                                                                                                        Container(
                                                                                                          child: IconButton(
                                                                                                            icon: Icon(
                                                                                                              Icons.share,
                                                                                                              color: Colors.white,
                                                                                                              size:  MediaQuery.of(context).size.height*0.035,
                                                                                                            ),
                                                                                                            onPressed: () {

                                                                                                              // تأكد من أن البيانات غير فارغة أو null
                                                                                                              if (controller.catagerylist.isNotEmpty && controller.catagerylist[index] != null) {
                                                                                                                String name = controller.catagerylist[index].name ?? "غير محدد";
                                                                                                                String description = controller.catagerylist[index].describe ?? "لا يوجد وصف";
                                                                                                                String coupon = controller.catagerylist[index].coupon ?? "لا يوجد كوبون";
                                                                                                                String website = controller.catagerylist[index].website ?? ""; // رابط العرض

                                                                                                                // بناء النص الذي سيتم نسخه مع رابط التطبيق ورابط العرض
                                                                                                                String textToCopy = "لايفوتك هذا العرض الرهيب الحصري من تطبيق اكواد خصم😮😎\n"
                                                                                                                    " العرض من  $name\n"
                                                                                                                    "وصف العرض 👌🌟: $description\n";

                                                                                                                // إضافة الكوبون إذا كان موجودًا وغير فارغ
                                                                                                                if (coupon.isNotEmpty && coupon != "لا يوجد كوبون") {
                                                                                                                  textToCopy += "\n كوبون الخصم👏: $coupon\n";
                                                                                                                }

                                                                                                                textToCopy += " رابط للحصول على العرض🎯:\n $website\n"
                                                                                                                    "رابط تحميل التطبيق🔶:\n  https://bit.ly/41OHYH1 ";

                                                                                                                // نسخ النص إلى الحافظة
                                                                                                                Clipboard.setData(ClipboardData(text: textToCopy));

                                                                                                                // عرض رسالة تأكيد
                                                                                                                Get.snackbar(
                                                                                                                  "نجاح✅",
                                                                                                                  "شارك هذا العرض مع من تحب💕",
                                                                                                                  snackPosition: SnackPosition.TOP,
                                                                                                                  backgroundColor: Colors.orange.withOpacity(0.4), // لون برتقالي شفاف
                                                                                                                  colorText: Colors.white, // لون النص أبيض
                                                                                                                  snackStyle: SnackStyle.FLOATING, // تصميم شبيه بالزجاج
                                                                                                                  titleText: Text(
                                                                                                                    "نجاح",
                                                                                                                    textDirection: TextDirection.rtl, // النص من اليمين لليسار
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.white,
                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  messageText: Text(
                                                                                                                    "شارك هذا العرض مع من تحب💕",
                                                                                                                    textDirection: TextDirection.rtl, // النص من اليمين لليسار
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.white,
                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                );
                                                                                                              } else {
                                                                                                                // إذا كانت البيانات غير موجودة أو فارغة
                                                                                                                Get.snackbar("خطأ", "بيانات العنصر غير موجودة.", snackPosition: SnackPosition.BOTTOM);
                                                                                                              }
                                                                                                            },
                                                                                                          ),
                                                                                                        ),


                                                                                                      ],
                                                                                                    ),
                                                                                                  ),

                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                            );
                                                                          },

                                                                          child:  Animate(
                                                                              effects: [
                                                                                FadeEffect(duration: Duration(milliseconds: 200)),
                                                                                ScaleEffect(duration: Duration(milliseconds: 200)),
                                                                              ],
                                                                              child:controller.catagerylist[index].coupon != null &&
                                                                                  controller.catagerylist[index].coupon!.isNotEmpty
                                                                                  ? Container(
                                                                                child: Center(child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    SizedBox(width: MediaQuery.of(context).size.width * 0.016),
                                                                                    Text("عرض الكوبون"
                                                                                      ,style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 15,
                                                                                        fontFamily: 'Cairo',
                                                                                        fontWeight: FontWeight.bold,

                                                                                      ),
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.code,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                                width: Get.width * 0.375,
                                                                                height: Get.height * 0.057,
                                                                                decoration:  BoxDecoration(
                                                                                  gradient: LinearGradient(
                                                                                    begin: Alignment.centerRight, // يبدأ التدرج من اليمين
                                                                                    end: Alignment.centerLeft,   // ينتهي التدرج في اليسار
                                                                                    colors: [
                                                                                      Color(0xFFFFAB40),// لون OrangeAccent[200]
                                                                                      Color(0xFFFCA474),
                                                                                      Color(0xFFF98887),

                                                                                    ],
                                                                                  ),
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(10),
                                                                                    topRight:Radius.circular(10) ,
                                                                                    bottomRight: Radius.circular(10),
                                                                                    bottomLeft:  Radius.circular(30),
                                                                                  ),
                                                                                  // color: Color.fromRGBO(176, 228, 221, 1.0),
                                                                                //  color: Colors.orangeAccent[200],
                                                                                ),
                                                                              ):Container(
                                                                                child: Center(child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                   // SizedBox(width: MediaQuery.of(context).size.width * 0.013),
                                                                                    Text(
                                                                                      "أحصل على العرض"
                                                                                      ,style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 14,
                                                                                      fontFamily: 'Cairo',
                                                                                      fontWeight: FontWeight.bold,

                                                                                      // color: ThemeService().isSavedDarkMode() ? Colors.white: Colors.orange
                                                                                    ),
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.open_in_new,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                                width: Get.width * 0.375,
                                                                                height: Get.height * 0.057,
                                                                                decoration:  BoxDecoration(

                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(10),
                                                                                    topRight:Radius.circular(10) ,
                                                                                    bottomRight: Radius.circular(10),
                                                                                    bottomLeft:  Radius.circular(30),
                                                                                  ),
                                                                                  // color: Color.fromRGBO(176, 228, 221, 1.0),
                                                                                  gradient: LinearGradient(
                                                                                    begin: Alignment.centerRight, // يبدأ التدرج من اليمين
                                                                                    end: Alignment.centerLeft,   // ينتهي التدرج في اليسار
                                                                                    colors: [
                                                                                      Color(0xFFFFAB40),// لون OrangeAccent[200]
                                                                                      Color(0xFFFFAB40),// لون OrangeAccent[200]

                                                                                      Color(0xFFFCA474),
                                                                                      Color(0xFFF98887),

                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                )

                                            )
                                        )),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.016),// مسافة بين الـ Widget

                                Container(

                                  // البنر الثاني  بالترتيب

                                  width: MediaQuery.of(context).size.width * 0.97,
                                  height:MediaQuery.of(context).size.height *0.171,


                                  child: PageView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.bannerCenterModel.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          await controller.openUrl(controller.bannerCenterModel[index].website!);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(

                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),  // تنعيم الحواف
                                              topRight: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            image: DecorationImage(

                                              image: NetworkImage(controller.bannerCenterModel[index].image!),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),// مسافة بين الـ Widget




                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),// مسافة بين الـ Widget

                                // تحت الصيانة الجسم السفلي الكوبنات
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.33,
                                  width: MediaQuery.of(context).size.width* 0.97 ,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                        ThemeService().isSavedDarkMode()
                                            ? Color(0xFF000000).withOpacity(0.09)
                                            : Color(0xFFFFFF0).withOpacity(0.09),
                                        BlendMode.srcOver,
                                      ),
                                      image:  ThemeService().isSavedDarkMode() ? AssetImage('assets/images/gameBa.png'):AssetImage('assets/images/gameWa.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Column(

                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          /// color: Colors.blue,
                                        ),
                                        height: MediaQuery.of(context).size.height * 0.04,
                                        width: MediaQuery.of(context).size.width *0.97 ,
                                        child: Center(
                                          child: Text(
                                            "مواقع مختارة للالعاب",
                                            style: TextStyle(

                                              color:ThemeService().isSavedDarkMode() ?  Colors.white:Colors.red,
                                              fontSize:  Get.size.width * 0.055,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.27,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Container(
                                              decoration: BoxDecoration(
                                               color: Colors.red,
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.23,
                                             /// width: MediaQuery.of(context).size.width * 0.01,

                                            ),
                                            Container(
                                              // decoration: BoxDecoration(
                                                // يمكنك إضافة تصميم هنا إذا كنت ترغب
                                              //  ),
                                              height: MediaQuery.of(context).size.height * 0.27, // تحديد الارتفاع بنسبة من الشاشة
                                              width: MediaQuery.of(context).size.width * 0.80, // تحديد العرض بنسبة من الشاشة
                                              child: LayoutBuilder(
                                                builder: (context, constraints) {
                                                  return Column( // استخدام Column لعرض العناصر بشكل ثابت
                                                    children: [
                                                      // مثال على كيفية إضافة Expanded أو Flexible
                                                      Expanded(
                                                        child: DescendingGridView(), // سيتم توسيع DescendingGridView لملء المساحة المتاحة
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.012),// مسافة بين الـ Widgets

                                Container(

                                  // البنر الثالث

                                  width: MediaQuery.of(context).size.width * 0.97,
                                  height:MediaQuery.of(context).size.height *0.171,

                                  child: PageView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.bannerLastModel.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          await controller.openUrl(controller.bannerLastModel[index].website!);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image:
                                            DecorationImage(
                                              image: NetworkImage(controller.bannerLastModel[index].image!),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.05),// مسافة بين الـ Widgets


                // زر سياسة الخصوصية

                                ElevatedButton(
                                  onPressed: () => Get.bottomSheet(
                                    SafeArea(
                                      bottom: true, // يحمي المحتوى من الالتصاق بأسفل الشاشة
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                        ),
                                        height: Get.height * 0.65, // 65% من الشاشة
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Privacy Policy",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      "• التطبيق مجاني ويقدم الخدمات كما هي.\n",
                                                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                                                    ),
                                                    Text(
                                                      "• قد نجمع معلومات محدودة لتحسين تجربة المستخدم.\n",
                                                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                                                    ),
                                                    Text(
                                                      "• التطبيق يحتوي على روابط تابعة (Affiliate Links) لمتاجر مختلفة.\n",
                                                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                                                    ),
                                                    Text(
                                                      "• لا نشارك المعلومات الشخصية مع أطراف ثالثة إلا كما هو موضح.\n",
                                                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                                                    ),
                                                    Text(
                                                      "• لا يستهدف التطبيق الأطفال دون سن 13 عامًا.\n",
                                                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                                                    ),
                                                    Text(
                                                      "• نستخدم أساليب حماية بيانات مقبولة تجاريًا، لكن لا يمكن ضمان الأمان الكامل.\n",
                                                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                                                    ),
                                                    Text(
                                                      "• الروابط الخارجية قد توجهك لمواقع أخرى، ونحن غير مسؤولين عن محتواها أو سياساتها.\n",
                                                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                                                    ),
                                                    Text(
                                                      "• يمكن تحديث هذه السياسة من وقت لآخر.\n",
                                                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                                                    ),
                                                    SizedBox(height: 12),
                                                    Text(
                                                      "لمعرفة المزيد يمكنك التحقق من التطبيق على Google Play.",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  child: const Text("Privacy Policy"),
                                )



                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    /// الجزاء العلوي اليحث و الجزاء السفلي المفضلات و الاعدادات
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                           // color: ThemeService().isSavedDarkMode() ?  Colors.black12: Colors.white24,
                            width: MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height *0.06,
                            ///   color: ThemeService().isSavedDarkMode() ?  Colors.black87: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight:Radius.circular(0) ,
                                      bottomRight: Radius.circular(0),
                                      bottomLeft:  Radius.circular(14),
                                    ),
                                    // color: Color.fromRGBO(176, 228, 221, 1.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerRight, // يبدأ التدرج من اليمين
                                      end: Alignment.centerLeft,   // ينتهي التدرج في اليسار
                                      colors: [
                                        Color(0xFFFFAB40),// لون OrangeAccent[200]
                                        Color(0xFFFFAB40),// لون OrangeAccent[200]

                                        Color(0xFFFCA474),
                                        Color(0xFFF98887),

                                      ],
                                    ),
                                  ),

                                  height:MediaQuery.of(context).size.height *0.07,
                                  width: MediaQuery.of(context).size.width *0.18,

                                  child: IconButton(
                                    icon: Icon(Icons.search,
                                      /// color: Color.fromRGBO(176, 228, 221, 1.0),
                                      color: Colors.white,

                                      size: Get.size.width *0.085,
                                    ),
                                    //Image.asset(
                                    //  'assets/icons/icon-search.png',
                                    //  ),
                                    onPressed: () {
                                      Get.to(Search_Page());

                                      // showSearch(context: context, delegate: DataSearch());
                                    },
                                  ),
                                ),


                                // Container(
                                //   width: MediaQuery.of(context).size.width*0.4,

                                //      child: Image.network(
                                //           "https://lh3.googleusercontent.com/-tqaWaduuTGU/ZEkfU0jlatI/AAAAAAAABQM/T4a8ZLA22c42JV6kpQLtkdzw0gili7whgCEwYBhgLKqwFADGYw-wGQ4y52SJIT1GqygVXJLBl4reApXu4Xe--3GiTLBah5Md6uzonw0GgqcyMGKk7vsgoi28DGbfzSdm0RzXqBxcP18mmkdPG4SJenPMxYyXl4ik_0oX2Uab0USQbOaevt6P7J1jY4mxc5VYM0Kunx1WLyv2DhCxJeA4FDCad2qvoWL2cp2TQfEDrzWmmfQbBvLOxGSv8LB7Gwuwzpqzonh1jOcn14L-h_cIX5uUl9LY31aZTbCga8qAAti_12Wp85YC05In_CMzDo5ip7nk5faAsqa2jfOmRPh-pJn_l7ekC04Rp4NObwoOwgZ7X1yORXDgFQgJK9VZBwv-Prp3m2hGNxHtXsqeAcwL6mzpk67j7goxPqmtPpfHh9_i-cj53PC9MzWadFzzhsIQD8f7TPdKw6CLCA_2_Brl4XxJ6Wv4ymXtzF5ZOfQ7NGDr6lRXyQu4fzIx5WeApgbtoJQqNrIlJYDZzfPCzwD4zB7Hv4s-DJnP0hEHPOMDBFYfRNuj3tn25ahKIHxIdTh76gsQ0jhVxf09cXS0qxSesGGBny41zZ4NKJCoN1slwOCpPXK1cTv7vx1teLQghjnA9d9t4P-NMCJlHgwYmuR0VAv4A96WIHDaIKjsY2mxFtLoKMe7_ImzyhGo2Ryl2Fh3KDuWNstFHLuJ37kOfDU8_SwK1-C1sHyRIKBHXONRArK-89s0rzOoYE-Lo-HtWAvyYd6EWUfW1-nV6Ld30-LcjwnJEWAWX7LIgaUv5YdAgmduxIk4GyKN0rLDs7IExm-e9VH8ALsJbzPjWPn031azUgOKJM71qSIgU02Jb8zmsXTi_LFkfh8jMo9LvmEi8vhlAoJq-Jm3yXmWlM2-h9d8OY8PNdpxT2cd_OEMNHLtlem2SwRUm-CXDWnMNc8FtMOzDpKIG/w140-h63-p/%25D8%25B9%25D9%2586%25D8%25A8%2B%25D8%25B4%25D8%25B9%25D8%25A7%25D8%25B1.png"
                                // ,fit: BoxFit.fill,
                                ///                       ),
                                //        ),

                                Container(
                                  child: Icon(Icons.local_activity_outlined,
                                    /// color: Color.fromRGBO(176, 228, 221, 1.0),
                                    color: Color(0xFFF8974F),

                                    size: Get.size.width *0.08,
                                  ),
                                  decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),

                                    ),
                                    //  color: Colors.white,

                                  ),

                                  height:MediaQuery.of(context).size.height* 0.7,
                                  width: MediaQuery.of(context).size.width *0.14,


                                ),

                              ],
                            ),
                          ),
                          Container(
                             /// color:Colors.orange,
                            width: MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height *0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    showModalBottomSheet(

                                        context: context,
                                        builder: (context){
                                          return SafeArea(
                                            minimum: EdgeInsets.only(bottom: Get.height * 0.057),
                                            child: Container(

                                              height: Get.height* 0.07,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                        mainAxisAlignment:MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(ThemeService().isSavedDarkMode() ? 'الوضع الفاتح':"الوضع الداكن"),
                                                          IconButton(
                                                            color:Colors.green,
                                                            onPressed: () {
                                                              ThemeService().changeTheme();
                                                            },
                                                            icon: Icon(ThemeService().isSavedDarkMode() ?  CupertinoIcons.brightness_solid: CupertinoIcons.moon_stars,),

                                                          ),
                                                        ]
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );

                                  },
                                  child: Container(
                                    child: Center(
                                      child: Obx(() {
                                        return AnimatedRotation(
                                          duration: Duration(seconds: 5), // تحديد المدة
                                          turns: controller.rotation.value, // التدوير حسب القيم المحسوبة
                                          child: Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                            /// color: ThemeService().isSavedDarkMode() ? Colors.black : Colors.white,
                                            size: Get.size.width * 0.08,
                                          ),
                                        );
                                      }),),
                                    decoration:  const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight:Radius.circular(15) ,
                                        bottomRight: Radius.circular(0),
                                        bottomLeft:  Radius.circular(15),
                                      ),
                                      //color: Color.fromRGBO(176, 228, 221, 1.0),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerRight, // يبدأ التدرج من اليمين
                                        end: Alignment.centerLeft,   // ينتهي التدرج في اليسار
                                        colors: [
                                          Color(0xFFFFAB40),// لون OrangeAccent[200]
                                          Color(0xFFFFAB40),// لون OrangeAccent[200]

                                          Color(0xFFFCA474),
                                          Color(0xFFF98887),

                                        ],
                                      ),
                                    ),
                                    height:MediaQuery.of(context).size.height *0.07,
                                    width: MediaQuery.of(context).size.width *0.18,
                                  ) ,
                                ),
                                GestureDetector(
                                  onTap:(){
                                    // ProductModel:controller.catagerylist[index],
                                    Get.to(()=>Like_page());

                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                     // color: ThemeService().isSavedDarkMode() ? Colors.black : Colors.white,
                                      size: Get.size.width *0.09,
                                    ),
                                    decoration:  const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight:Radius.circular(7) ,
                                        bottomRight: Radius.circular(15),
                                        bottomLeft:  Radius.circular(0),
                                      ),
                                      // color: Color.fromRGBO(176, 228, 221, 1.0),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerRight, // يبدأ التدرج من اليمين
                                        end: Alignment.centerLeft,   // ينتهي التدرج في اليسار
                                        colors: [
                                          Color(0xFFFFAB40),// لون OrangeAccent[200]
                                          Color(0xFFFFAB40),// لون OrangeAccent[200]

                                          Color(0xFFFCA474),
                                          Color(0xFFF98887),

                                        ],
                                      ),
                                    ),

                                    height:MediaQuery.of(context).size.height *0.07,
                                    width: MediaQuery.of(context).size.width *0.18,

                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),)
    );
  }
}

// ... باقي الكود المساعد (الأنواع والأيقونات) يبقى كما هو بدون تغيير
final List<Map<String, Color>> _categories = [
  {'color': Color(0xffee59a2)},  // Green
  {'color': Color(0xffFFC300)}, // Yellow
  {'color': Color(0xff2196F3)}, // Blue
  {'color': Color(0xffC70039)}, // Red


  {'color': Color(0xffFF5733)}, // Orange

  {'color': Color(0xffFFC107)}, // Yellow Amber
  {'color': Color(0xff9C27B0)}, // Purple

  {'color': Color(0xff8BC34A)}, // Light Green
  {'color': Color(0xff03A9F4)}, // Light Blue
  {'color': Color(0xffFF9800)},// Amber
  {'color': Color(0xffF44336)}, // Deep Red

  {'color': Color(0xff00BCD4)},// Cyan
  {'color': Color(0xffE91E63)}, // Pink
  {'color': Color(0xffFFEB3B)},  // Yellow
];



final List<Map<String, dynamic>> iconMapList =[
  {
    "icon": Icons.all_inclusive,
    "color": Colors.blue,
  },
  {
    "icon": Icons.home_work_outlined,
    "color": Colors.red,
  },
  {
    "icon": Icons.favorite_border,
    "color": Colors.orange,
  },
  {
    "icon": Icons.devices,
    "color": Colors.green,
  },
  {
    "icon": Icons.checkroom,

    /// "icon": Icons.shopping_bag,
    "color": Colors.purple,
  },
  {
    "icon": Icons.shopping_bag,
    "color": Colors.pink,
  },
  {
    "icon": Icons.face,
    "color": Colors.indigo,
  },
  {
    "icon": Icons.shopping_bag,
    "color": Colors.yellow,
  },
  {
    // "icon": Icons.delivery_dining,
    "icon": Icons.child_care,

    "color": Colors.brown,
  },
  {
    // "icon": Icons.sports_esports,
    "icon": Icons.delivery_dining,
    "color": Colors.teal,
  },
  {
    "icon": Icons.sports_esports,
    // "icon": Icons.spa,
    "color": Colors.cyan,
  },
  {
    "icon": Icons.sports_football_outlined,
    "color": Colors.amber,
  },
  {
    "icon": Icons.spa,
    "color": Colors.deepPurple,
  },
  {
    "icon": Icons.card_giftcard,
    "color": Colors.deepOrange,
  },
  {
    "icon": Icons.favorite,
    "color": Colors.pink,
  },
  {
    "icon": Icons.visibility,
    "color": Colors.lightGreen,
  },
  {
    "icon": Icons.child_friendly,
    "color": Colors.amber,
  },
  {
    "icon": Icons.delivery_dining,
    "color": Colors.red,
  },
  {
    "icon": Icons.sports_basketball,
    "color": Colors.orange,
  },
  {
    "icon": Icons.pets,
    "color": Colors.brown,
  },
  {
    "icon": Icons.spa,
    "color": Colors.purple,
  },
  {
    "icon": Icons.emoji_nature,
    "color": Colors.green,
  },
  {
    "icon": Icons.shopping_cart,
    "color": Colors.blue,
  },
  {
    "icon": Icons.sports_football,
    "color": Colors.indigo,
  },
  {
    "icon": Icons.emoji_objects,
    "color": Colors.yellow,
  },
  {
    "icon": Icons.card_giftcard,
    "color": Colors.deepPurple,
  },
];



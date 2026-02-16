import 'package:coppon_3pp/DartMode/theme_service.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/MyHomePage.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/MyHomePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
class Like_page extends GetView {
  Like_page({super.key});

  final controller = Get.find<MyHomePageControlle>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('المفضلة',style: TextStyle(
              color:  Colors.white,
          ),),
          backgroundColor:  ThemeService().isSavedDarkMode() ?  Colors.black: Color(0xFFF8974F),
        ) ,
        body:SimpleGestureDetector(
            onHorizontalSwipe: (SwipeDirection direction) {
              if (direction == SwipeDirection.right || direction == SwipeDirection.left ) {
                Get.to(() => MyHomePage());
              }
            },
            child:

            LiquidPullToRefresh(
              animSpeedFactor: 1,
              color: ThemeService().isSavedDarkMode() ?  Colors.black: Colors.white ,
              height:Get.height * 0.15 ,
              backgroundColor:  ThemeService().isSavedDarkMode() ?  Colors.white: Colors.black,
              //  key: ,	// key if you want to add
              onRefresh: () async {
                return await Future.delayed(const Duration(seconds: 2));
              },	// refresh callback
              child: Obx((){
                if(controller.favouriteslist.isEmpty){
                  return  Container(
                    color: ThemeService().isSavedDarkMode() ?  Colors.black: Colors.white,

                    height:Get.height,
                    width: Get.width,

                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border,size: MediaQuery.of(context).size.width * 0.3,color:Colors.red[100],),
                        Text('قم بالاعجاب بكوبونك المفضل',style:TextStyle(
                          color:  Colors.green,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),),
                      ],
                    ),
                  );
                }else{
                  return Container(
                      padding: EdgeInsets.fromLTRB(0, Get.size.height * 0.01, 0, 0),
                      color: ThemeService().isSavedDarkMode() ? Colors.black : Colors.white,
                      width: Get.width,
                      child: SingleChildScrollView( // ✅ بدّل Expanded بـ ScrollView
                          child: Column(
                              children: [
                              Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                          GetBuilder<MyHomePageControlle>(
                          builder: (controller) => Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                      child: ListView.separated(
                                                      shrinkWrap: true, // ✅ مهم عشان يشتغل داخل ScrollView
                                                      physics: NeverScrollableScrollPhysics(), // ✅ يمنع التمرير المزدوج
                                                      itemCount: controller.favouriteslist.length,
                                                      separatorBuilder: (context, index) =>Container(height: 5,),
                                                      scrollDirection: Axis.vertical,
                                                      itemBuilder: (context, index) {

                                                        return    GestureDetector(
                                                          onTap:(){
                                                            /// controller.mnagfavourites(controller.couponsModel[index].IdNumber!);
                                                            showModalBottomSheet(

                                                                context: context,
                                                                builder: (context){
                                                                  return SafeArea(
                                                                    minimum: EdgeInsets.only(bottom: Get.height * 0.057),
                                                                    child: Container(

                                                                      height: Get.height* 0.45,
                                                                      child: Stack(
                                                                        alignment: Alignment.topCenter,
                                                                        children: [

                                                                          Container(
                                                                            height: MediaQuery.of(context).size.height * 0.45,
                                                                            width: MediaQuery.of(context).size.width,
                                                                            decoration:  BoxDecoration(
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
                                                                                  height: MediaQuery.of(context).size.height *0.17,
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  // ignore: prefer_const_constructors
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(controller.favouriteslist[index].ColorBG!),

                                                                                    // ignore: prefer_const_constructors
                                                                                    borderRadius: BorderRadius.only(
                                                                                        bottomRight: Radius.circular(30),
                                                                                        bottomLeft: Radius.circular(30)
                                                                                    ),
                                                                                  ),

                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        // image
                                                                                        height: MediaQuery.of(context).size.height *0.1,
                                                                                        width: MediaQuery.of(context).size.width*0.30,
                                                                                        child: Image.network(controller.favouriteslist[index].image!),
                                                                                      ),
                                                                                      /// الاسم ااسفل الايقونة
                                                                                      Container(

                                                                                        alignment: Alignment.center,
                                                                                        height: MediaQuery.of(context).size.height*0.05,
                                                                                        width:MediaQuery.of(context).size.width,

                                                                                        child: Text(
                                                                                          controller.favouriteslist[index].name!,style:

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
                                                                                    // color: Colors.white,
                                                                                    width: Get.width * 0.8,
                                                                                    height: Get.height * 0.09,
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          controller.favouriteslist[index].describe!,
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
                                                                                  child: Stack(
                                                                                    alignment: Alignment.center,
                                                                                    children: [
                                                                                      // الخلفية الملونة
                                                                                      Container(
                                                                                        width: Get.width * 0.3,
                                                                                        height: Get.height * 0.03,
                                                                                        decoration: ShapeDecoration(
                                                                                          color: Color(controller.favouriteslist[index].ColorBG!),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(6),
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                      // محتوى الخصم مع التمرير الأفقي
                                                                                      SingleChildScrollView(
                                                                                        scrollDirection: Axis.horizontal,
                                                                                        child: Animate(
                                                                                          effects: [
                                                                                            FadeEffect(duration: Duration(milliseconds: 300)),
                                                                                            ScaleEffect(duration: Duration(milliseconds: 300)),
                                                                                          ],
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text('%', style: TextStyle(color: Colors.white, fontSize: 13)),
                                                                                              SizedBox(width: 2),
                                                                                              Text(
                                                                                                controller.favouriteslist[index].discount_rate!,
                                                                                                style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontSize: 16,
                                                                                                  fontFamily: 'Inter',
                                                                                                  fontWeight: FontWeight.w400,
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(width: 2),
                                                                                              Text(
                                                                                                ' : الخصم',
                                                                                                style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontSize: 12,
                                                                                                  fontFamily: 'Inter',
                                                                                                  fontWeight: FontWeight.w400,
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(width: 2),
                                                                                              Icon(Icons.local_activity, size: 13, color: Colors.white),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),

                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * 0.15,
                                                                                  ///color: Colors.pinkAccent,
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  child: Column(
                                                                                    // تحديد المحاذاة بناءً على وجود الكوبون
                                                                                    mainAxisAlignment: controller.favouriteslist[index].coupon != null &&
                                                                                        controller.favouriteslist[index].coupon!.isNotEmpty
                                                                                        ? MainAxisAlignment.center
                                                                                        : MainAxisAlignment.center, // إذا لم يكن هناك كوبون، ضع الزر في المنتصف

                                                                                    children: [
                                                                                      // عرض الكوبون فقط إذا كان موجودًا
                                                                                      if (controller.favouriteslist[index].coupon != "null" &&
                                                                                          controller.favouriteslist[index].coupon!.isNotEmpty)
                                                                                        CouponWidget(
                                                                                          controller.favouriteslist[index].coupon,  // تمرير قيمة الكوبون كـ String
                                                                                          index,
                                                                                          colorBG: controller.favouriteslist[index].ColorBG!,
                                                                                          couponsModel: controller.favouriteslist[index],  // تمرير النموذج الكامل
                                                                                        ),

                                                                                      SizedBox(
                                                                                        height: MediaQuery.of(context).size.height * 0.002,
                                                                                      ),
                                                                                      // زر الذهاب للتطبيق
                                                                                      Container(
                                                                                        height: MediaQuery.of(context).size.height * 0.07,
                                                                                        width: MediaQuery.of(context).size.width * 0.9,
                                                                                        decoration: ShapeDecoration(
                                                                                          color: Color(controller.favouriteslist[index].ColorBG!),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(7),
                                                                                          ),
                                                                                        ),
                                                                                        child: TextButton(
                                                                                          onPressed: () {
                                                                                            // فتح الرابط
                                                                                            controller.openlink(controller.favouriteslist[index].website!);

                                                                                            // إذا كان هناك كوبون، قم بنسخه
                                                                                            if (controller.favouriteslist[index].coupon != null &&
                                                                                                controller.favouriteslist[index].coupon!.isNotEmpty) {
                                                                                              Clipboard.setData(
                                                                                                ClipboardData(text: controller.favouriteslist[index].coupon!),
                                                                                              );

                                                                                              // إظهار رسالة تأكيد النسخ
                                                                                              Get.snackbar("نجاح", "تم نسخ الكوبون ✅",
                                                                                                colorText: Colors.grey,
                                                                                                snackPosition: SnackPosition.BOTTOM,
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
                                                                                                  Icon(
                                                                                                    Icons.shopping_cart_outlined,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    controller.favouriteslist[index].coupon != null &&
                                                                                                        controller.favouriteslist[index].coupon!.isNotEmpty
                                                                                                        ?'انسخ و اذهب للتطبيق':'احصل على العرض',
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.white,
                                                                                                      fontFamily: 'Cairo',
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontSize: 20,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
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
                                                                              ////  color:Colors.deepPurpleAccent,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [

                                                                                  Container(
                                                                                    /// color:Colors.deepPurpleAccent,
                                                                                    height: MediaQuery.of(context).size.height*0.15,
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [

                                                                                        Container(

                                                                                          child: IconButton(
                                                                                            icon: Icon(
                                                                                              Icons.arrow_back,
                                                                                              size: 33,
                                                                                              color:Colors.white,
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Get.back();
                                                                                            },
                                                                                          ),),

                                                                                        Container(

                                                                                          child:  IconButton(

                                                                                            icon:Icon( Icons.share,
                                                                                              color:Colors.white,
                                                                                              size: 30,
                                                                                            ),
                                                                                            onPressed: () {

                                                                                              // تأكد من أن البيانات غير فارغة أو null
                                                                                              if (controller.favouriteslist.isNotEmpty) {
                                                                                                String name = controller.favouriteslist[index].name ?? "غير محدد";
                                                                                                String description = controller.favouriteslist[index].describe ?? "لا يوجد وصف";
                                                                                                String coupon = controller.favouriteslist[index].coupon ?? "لا يوجد كوبون";
                                                                                                String website = controller.favouriteslist[index].website ?? ""; // رابط العرض

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

                                                                                  Row(
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          if (controller.isfavourites(controller.favouriteslist[index].IdNumber!)) {
                                                                                            Get.back(); // إغلاق الصفحة أولًا
                                                                                            Future.delayed(Duration(milliseconds: 200), () {
                                                                                              controller.mnagfavourites(controller.favouriteslist[index].IdNumber!);
                                                                                            });
                                                                                          } else {
                                                                                            controller.mnagfavourites(controller.favouriteslist[index].IdNumber!);
                                                                                          }
                                                                                        },

                                                                                        child:Obx(() => Container(
                                                                                          child: controller.isfavourites(controller.favouriteslist[index].IdNumber!)?
                                                                                          Icon(
                                                                                            Icons.favorite,
                                                                                            color: Colors.red,
                                                                                            size: Get.size.width *0.09,
                                                                                          ) :Icon(
                                                                                            Icons.favorite_border,
                                                                                            color: Colors.red,
                                                                                            size: Get.size.width *0.09,
                                                                                          ),

                                                                                        ),),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: MediaQuery.of(context).size.width * 0.04,
                                                                                      )
                                                                                    ],
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
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius:BorderRadius.circular(7),
                                                              color: ThemeService().isSavedDarkMode() ? Color(4282400832) : Color(0xFFFFE1CB),

                                                              border: Border.all( width: 0.02,  color: ThemeService().isSavedDarkMode() ? Colors.white10:Colors.grey, ),

                                                            ),

                                                            height: Get.height * 0.165,
                                                            width: Get.width * 0.95,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                width: Get.width * 0.036,
                                                                height: Get.height * 0.040,
                                                                decoration: BoxDecoration(
                                                                  color:  ThemeService().isSavedDarkMode() ?  Colors.black87: Colors.white,
                                                                  borderRadius: const BorderRadius.only(
                                                                    bottomLeft: Radius.circular(50),
                                                                    bottomRight: Radius.circular(0),
                                                                    topLeft: Radius.circular(50),
                                                                    topRight: Radius.circular(0),
                                                                  ),
                                                                ),
                                                              ),

                                                                Container(
                                                                  width: Get.width * 0.26,
                                                                  height: Get.height * 0.1225,
                                                                  // color: Colors.cyan,

                                                                  child: Stack(

                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: 0,
                                                                        child: Container(
                                                                          width: 95, // حافظ على العرض للاتساق
                                                                          height: 95, // اضبط الارتفاع ليكون مساويًا للعرض للحصول على مربع
                                                                          decoration: ShapeDecoration(
                                                                            shape: RoundedRectangleBorder( // استخدم RoundedRectangleBorder للمربع ذو الزوايا المستديرة (اختياري)
                                                                              borderRadius: BorderRadius.circular(37.0), // اضبط تقريب الزاوية إلى 0 للحصول على مربع مثالي
                                                                              side: BorderSide(
                                                                                width: 0.20,
                                                                                strokeAlign: BorderSide.strokeAlignCenter,
                                                                                color: Color(controller.favouriteslist[index].ColorBG!),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      Positioned(
                                                                        left: 11,
                                                                        top: 9.8,
                                                                        child: Container(
                                                                          width: Get.width * 0.19,
                                                                          height: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.0944,
                                                                          decoration: ShapeDecoration(
                                                                            image: DecorationImage(
                                                                              image: NetworkImage(
                                                                                  controller.favouriteslist[index].image!),
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
                                                                Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: Get.width * 0.055,
                                                                      height: Get.height * 0.018,
                                                                      decoration: BoxDecoration(
                                                                        color:  ThemeService().isSavedDarkMode() ?  Colors.black87: Colors.white,
                                                                        borderRadius: const BorderRadius.only(
                                                                          bottomLeft: Radius.circular(30),
                                                                          bottomRight: Radius.circular(30),
                                                                          topLeft: Radius.circular(0),
                                                                          topRight: Radius.circular(0),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    // Generated code for this VerticalDivider Widget...
                                                                    SizedBox(
                                                                      height: Get.height * 0.10,
                                                                      child: VerticalDivider(
                                                                        thickness: 1.1,

                                                                        color: Color(0xFFF8974F),
                                                                      ),
                                                                    ),

                                                                    Container(
                                                                      width: Get.width * 0.055,
                                                                      height: Get.height * 0.018,
                                                                      decoration: BoxDecoration(
                                                                        color: ThemeService().isSavedDarkMode() ?  Colors.black87: Colors.white,
                                                                        borderRadius: const BorderRadius.only(
                                                                          bottomLeft: Radius.circular(0),
                                                                          bottomRight: Radius.circular(0),
                                                                          topLeft: Radius.circular(30),
                                                                          topRight: Radius.circular(30),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                                Container(
                                                                  // color: Colors.white,
                                                                  width: Get.width * 0.52,
                                                                  height: Get.height * 0.156,
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [

                                                                      Text(
                                                                        controller.favouriteslist[index].name!,
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 24,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        controller.favouriteslist[index].describe!,
                                                                        textAlign:TextAlign.center,
                                                                        style: TextStyle(
                                                                          color: ThemeService().isSavedDarkMode() ?  Colors.white:Color(4282400832),

                                                                          fontSize: 12,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      Obx(() => Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:(){
                                                                              controller.mnagfavourites(controller.favouriteslist[index].IdNumber!);
                                                                            },
                                                                            child: Container(
                                                                              child: controller.isfavourites(controller.favouriteslist[index].IdNumber!)?
                                                                              Icon(
                                                                                Icons.favorite,
                                                                                color: Colors.red,
                                                                                size: 30,
                                                                              ) : Icon(
                                                                                Icons.favorite_border,
                                                                                color: Colors.red,
                                                                                size: 30,
                                                                              ),

                                                                            ),
                                                                          ),
                                                                          Stack(
                                                                            alignment: Alignment.center,

                                                                            children: [
                                                                              Container(
                                                                                width: Get.width * 0.4,
                                                                                height: Get.height * 0.035,
                                                                                decoration: ShapeDecoration(
                                                                                  color: Color(0xFFF8974F),
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [

                                                                                  SizedBox(
                                                                                    width: Get.width * 0.22,
                                                                                    child: SingleChildScrollView(
                                                                                      scrollDirection: Axis.horizontal,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text('%',
                                                                                              style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Inter')),
                                                                                          Text(controller.favouriteslist[index].discount_rate!,
                                                                                              style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Inter')),
                                                                                          Text(' :الخصم',
                                                                                              style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter')),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    child: Icon(Icons.stars_rounded, size: 17, color: Colors.white),
                                                                                  ),



                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),

                                                                        ],
                                                                      ),)

                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: Get.width * 0.036,
                                                                  height: Get.height * 0.040,
                                                                  decoration: BoxDecoration(
                                                                    color:  ThemeService().isSavedDarkMode() ?  Colors.black87: Colors.white,
                                                                    borderRadius: const BorderRadius.only(
                                                                      bottomLeft: Radius.circular(0),
                                                                      bottomRight: Radius.circular(50),
                                                                      topLeft: Radius.circular(0),
                                                                      topRight: Radius.circular(50),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Generated code for this Container Widget...

                                                                // Generated code for this Container Widget...
                                                                // Generated code for this Container Widget...

                                                              ],
                                                            ),
                                                          ),
                                                        );}

                                                  )

                                              )
                                          )


                                    ],
                                  ),])
                                ),





                  );
                }
              }

              ),
            )

        ));
  }
}


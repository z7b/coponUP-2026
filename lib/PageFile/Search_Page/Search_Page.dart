import 'package:coppon_3pp/DartMode/theme_service.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/MyHomePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class Search_Page extends GetWidget<MyHomePageControlle> {

  final controller = Get.find<MyHomePageControlle>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, // هذا يحافظ على الخلفية ثابتة

        appBar:AppBar(
  automaticallyImplyLeading: false, // إخفاء سهم الرجوع
    backgroundColor:Color(0xFFF8974F),
 // backgroundColor:ThemeService().isSavedDarkMode() ?  Colors.black: Color.fromRGBO(176, 228, 221, 1.0) ,
  flexibleSpace:Align(
    alignment: Alignment.bottomCenter,
    child: GetBuilder<MyHomePageControlle>(
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.065,
        width: MediaQuery.of(context).size.width * 90,
        child: TextField(
          textAlign: TextAlign.right,  // محاذاة النص من اليمين
          textDirection: TextDirection.rtl, // تحديد اتجاه النص
          textAlignVertical: TextAlignVertical.bottom,
          controller: controller.searchTextController,
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          onChanged: (searchName) {
            controller.addSearchToList(searchName);
          },
          decoration: InputDecoration(
            fillColor: Color(0xFFF8974F),
            focusColor: Colors.red,
            prefixIcon: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ThemeService().isSavedDarkMode() ? Colors.black : Colors.white,
                size: 25,
              ),
              onPressed: () async {
                await controller.clearSearch(); // حذف البحث أولًا
                Get.back(); // ثم إغلاق الصفحة بعد الانتهاء
              },


            ),
            suffixIcon: controller.searchTextController.text.isNotEmpty
                ? IconButton(
              onPressed: () {
                controller.clearSearch();
              },
              icon: Icon(
                Icons.close,
                color: ThemeService().isSavedDarkMode() ? Colors.black : Colors.white,
                size: 25,
              ),
            )
                : null,
            hintText: "البحث بالاسم",
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 16,
            ),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.01),
              borderRadius: BorderRadius.circular(7),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.2),
              borderRadius: BorderRadius.circular(7),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.2),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ),
    ),
  ),


),
      body:SimpleGestureDetector(
          onHorizontalSwipe: (SwipeDirection direction) {
            if (direction == SwipeDirection.right || direction == SwipeDirection.left) {
              Get.back();
            }
          },
          child: Stack(
            children: [
              // الخلفية
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ThemeService().isSavedDarkMode()
                          ? const AssetImage('assets/images/BK_BG.png')
                          : const AssetImage('assets/images/bank.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
        SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // ليملأ العرض بالكامل

            children: [
              // الجسم السفلي الكوبنات
                GetBuilder<MyHomePageControlle>(
                    builder: (controller) =>  Container(

                      width: MediaQuery.of(context).size.width*0.95,
                      height:MediaQuery.of(context).size.height *0.9,

                      child: Obx((){
                     if(controller.searchlist.isEmpty){
                       return  Container(
                       //  color: ThemeService().isSavedDarkMode() ?  Colors.black: Colors.white,

                         height:Get.height,
                         width: Get.width,

                         child:Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [

                             Icon(Icons.local_activity_outlined,size: MediaQuery.of(context).size.width * 0.4,
                               color:Colors.orangeAccent,),
                             Text('قم بالبحث عن كوبون',style:TextStyle(
                               color:  Colors.orange,
                               fontSize: MediaQuery.of(context).size.width * 0.06,
                             ),),
                           ],
                         ),
                       );
                      }else{
                       return   ListView.separated(
                           itemCount: controller.searchlist.length,
                           separatorBuilder: (context, index) =>Container(height: 6,),
                           scrollDirection: Axis.vertical,
                           itemBuilder: (context, index) {
                             return  GestureDetector(
                               onTap:(){
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
                                                         color: Color(controller.searchlist[index].ColorBG!),

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
                                                             child: Image.network(controller.searchlist[index].image!),
                                                           ),
                                                           /// الاسم ااسفل الايقونة
                                                           Container(

                                                             alignment: Alignment.center,
                                                             height: MediaQuery.of(context).size.height*0.05,
                                                             width:MediaQuery.of(context).size.width,

                                                             child: Text(
                                                               controller.searchlist[index].name!,style:

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
                                                               controller.searchlist[index].describe!,
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
                                                                   color: Color(controller.searchlist[index].ColorBG!),
                                                                   shape: RoundedRectangleBorder(
                                                                     borderRadius: BorderRadius.circular(6),
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
                                                                       child: SingleChildScrollView(
                                                                         scrollDirection: Axis.horizontal, // تمرير أفقي
                                                                         child: Row(
                                                                           mainAxisSize: MainAxisSize.min,
                                                                           children: [
                                                                             Text(
                                                                               '%',
                                                                               style: TextStyle(
                                                                                 color: Colors.white,
                                                                                 fontSize: 13,
                                                                                 fontFamily: 'Inter',
                                                                                 fontWeight: FontWeight.w400,
                                                                               ),
                                                                             ),
                                                                             Text(
                                                                               controller.searchlist[index].discount_rate!,
                                                                               style: TextStyle(
                                                                                 color: Colors.white,
                                                                                 fontSize: 16,
                                                                                 fontFamily: 'Inter',
                                                                                 fontWeight: FontWeight.w400,
                                                                               ),
                                                                             ),
                                                                             Text(
                                                                               ' : الخصم',
                                                                               style: TextStyle(
                                                                                 color: Colors.white,
                                                                                 fontSize: 12,
                                                                                 fontFamily: 'Inter',
                                                                                 fontWeight: FontWeight.w400,
                                                                               ),
                                                                             ),
                                                                             Icon(
                                                                               Icons.local_activity,
                                                                               size: 13,
                                                                               color: Colors.white,
                                                                             ),
                                                                           ],
                                                                         ),
                                                                       )

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
                                                       ///color: Colors.pinkAccent,
                                                       width: MediaQuery.of(context).size.width,
                                                       child: Column(
                                                         // تحديد المحاذاة بناءً على وجود الكوبون
                                                         mainAxisAlignment: controller.searchlist[index].coupon != null &&
                                                             controller.searchlist[index].coupon!.isNotEmpty
                                                             ? MainAxisAlignment.center
                                                             : MainAxisAlignment.center, // إذا لم يكن هناك كوبون، ضع الزر في المنتصف

                                                         children: [
                                                           // عرض الكوبون فقط إذا كان موجودًا
                                                           if (controller.searchlist[index].coupon != "null" &&
                                                               controller.searchlist[index].coupon!.isNotEmpty)
                                                             CouponWidget(
                                                               controller.searchlist[index].coupon,  // تمرير قيمة الكوبون كـ String
                                                               index,
                                                               colorBG: controller.searchlist[index].ColorBG!,
                                                               couponsModel: controller.searchlist[index],  // تمرير النموذج الكامل
                                                             ),

                                                           SizedBox(
                                                             height: MediaQuery.of(context).size.height * 0.002,
                                                           ),
                                                           // زر الذهاب للتطبيق
                                                           Container(
                                                             height: MediaQuery.of(context).size.height * 0.07,
                                                             width: MediaQuery.of(context).size.width * 0.9,
                                                             decoration: ShapeDecoration(
                                                               color: Color(controller.searchlist[index].ColorBG!),
                                                               shape: RoundedRectangleBorder(
                                                                 borderRadius: BorderRadius.circular(7),
                                                               ),
                                                             ),
                                                             child: TextButton(
                                                               onPressed: () {
                                                                 // فتح الرابط
                                                                 controller.openlink(controller.searchlist[index].website!);

                                                                 // إذا كان هناك كوبون، قم بنسخه
                                                                 if (controller.searchlist[index].coupon != null &&
                                                                     controller.searchlist[index].coupon!.isNotEmpty) {
                                                                   Clipboard.setData(
                                                                     ClipboardData(text: controller.searchlist[index].coupon!),
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
                                                                         controller.searchlist[index].coupon != null &&
                                                                             controller.searchlist[index].coupon!.isNotEmpty
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
                                                                   color:ThemeService().isSavedDarkMode() ?  Colors.white: Colors.orange,
                                                                 ),
                                                                 onPressed: () {
                                                                   Get.back();
                                                                 },
                                                               ),),

                                                             Container(

                                                               child:  IconButton(

                                                                 icon:Icon( Icons.share,
                                                                   color:ThemeService().isSavedDarkMode() ?  Colors.white: Colors.orange,
                                                                   size: 30,
                                                                 ),
                                                                 onPressed: () {

                                                                   // تأكد من أن البيانات غير فارغة أو null
                                                                   if (controller.searchlist.isNotEmpty && index < controller.searchlist.length) {
                                                                   String name = controller.searchlist[index].name ?? "غير محدد";
                                                                   String description = controller.searchlist[index].describe ?? "لا يوجد وصف";
                                                                   String coupon = controller.searchlist[index].coupon ?? "لا يوجد كوبون";
                                                                   String website = controller.searchlist[index].website ?? "";

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
                                                             onTap:(){
                                                               controller.mnagfavourites(controller.searchlist[index].IdNumber!);
                                                             },
                                                             child:Obx(() => Container(
                                                               child: controller.isfavourites(controller.searchlist[index].IdNumber!)?
                                                               Icon(
                                                                 Icons.favorite,
                                                                 color: Colors.red,
                                                                 size: Get.size.width *0.066,
                                                               ) :Icon(
                                                                 Icons.favorite_border,
                                                                 color: Colors.red,
                                                                 size: Get.size.width *0.066,
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
                                 // ProductModel:controller.catagerylist[index],
                                /// Get.to(()=>PageCoupon( couponsModel:controller.searchlist[index],));
                               },
                               child: Container(
                                 decoration: BoxDecoration(
                                   color: ThemeService().isSavedDarkMode() ?  Colors.black54: Colors.white54,

                                 ),

                                       height: Get.height * 0.15,
                                       width: Get.width * 0.95,
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           // Generated code for this Container Widget...
                                           Container(
                                             width: Get.width * 0.036,
                                             height: Get.height * 0.040,
                                             decoration: BoxDecoration(
                                               color: ThemeService().isSavedDarkMode() ?  Colors.black: Colors.grey[50],
                                               borderRadius: const BorderRadius.only(
                                                 bottomLeft: Radius.circular(0),
                                                 bottomRight: Radius.circular(50),
                                                 topLeft: Radius.circular(0),
                                                 topRight: Radius.circular(50),
                                               ),
                                             ),
                                           ),

                                     Container(
                                       // color: ThemeService().isSavedDarkMode() ?  Colors.black87: Colors.white,
                                       width: Get.width * 0.44,
                                       height: Get.height * 0.145,
                                       child: Column(
                                         mainAxisSize: MainAxisSize.min,
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                         children: [

                                           Text(
                                             controller.searchlist[index].name!,
                                             style: TextStyle(
                                               color:ThemeService().isSavedDarkMode() ?  Colors.white: Colors.black,
                                               fontSize: 24,
                                               fontFamily: 'Inter',
                                               fontWeight: FontWeight.w400,
                                             ),
                                           ),
                                           Text(
                                             controller.searchlist[index].describe!,
                                             style: TextStyle(
                                               color: Colors.grey,
                                               fontSize: 12,
                                               fontFamily: 'Inter',
                                               fontWeight: FontWeight.w400,
                                             ),
                                           ),
                                           Obx(() =>  Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               GestureDetector(
                                                 onTap:(){
                                                   controller.mnagfavourites(controller.couponsModel[index].IdNumber!);
                                                 },
                                                 child: Container(
                                                   child: controller.isfavourites(controller.couponsModel[index].IdNumber!)?
                                                   Icon(
                                                     Icons.favorite,
                                                     color: Colors.red,
                                                     size: Get.size.width *0.08,
                                                   ) : Icon(
                                                     Icons.favorite_border,
                                                     color: Colors.red,
                                                     size: Get.size.width *0.08,
                                                   ),

                                                 ),
                                               ),
                                               Stack(
                                                 alignment: Alignment.center,

                                                 children: [
                                                   Container(
                                                     width: Get.width * 0.33,
                                                     height: Get.height * 0.026,
                                                     decoration: ShapeDecoration(
                                                       color: Colors.orangeAccent[20],
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
                                                               Text(
                                                                 '%',
                                                                 style: TextStyle(
                                                                   color: Color(0xFFF8974F),
                                                                   fontSize: 15,
                                                                   fontFamily: 'Inter',
                                                                   fontWeight: FontWeight.w400,
                                                                 ),
                                                               ),
                                                               Text(
                                                                 controller.searchlist[index].discount_rate!,
                                                                 style: TextStyle(
                                                                   color: Color(0xFFF8974F),
                                                                   fontSize: 15,
                                                                   fontFamily: 'Inter',
                                                                   fontWeight: FontWeight.w400,
                                                                 ),
                                                               ),
                                                               Text(
                                                                 ' :الخصم',
                                                                 style: TextStyle(
                                                                   color: Color(0xFFF8974F),
                                                                   fontSize: 14,
                                                                   fontFamily: 'Inter',
                                                                   fontWeight: FontWeight.w400,
                                                                 ),
                                                               ),
                                                             ],
                                                           ),
                                                         )

                                                       ),
                                                       Container(
                                                         child: Icon(Icons.stars_rounded, size: 17,
                                                           color: Color(0xFFF8974F),),
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

                                     Column(
                                       mainAxisSize: MainAxisSize.max,
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Container(
                                           width: Get.width * 0.055,
                                           height: Get.height * 0.018,
                                           decoration: BoxDecoration(
                                             color: ThemeService().isSavedDarkMode() ?  Colors.black: Colors.grey[50],                                             borderRadius: const BorderRadius.only(
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

                                             color: Colors.orange,
                                           ),
                                         ),

                                         Container(
                                           width: Get.width * 0.055,
                                           height: Get.height * 0.018,
                                           decoration: BoxDecoration(
                                             color: ThemeService().isSavedDarkMode() ?  Colors.black: Colors.grey[50],
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
                                       width: Get.width * 0.26,
                                       height: Get.height * 0.1225,
                                       // color: Colors.cyan,

                                       child: Stack(

                                         children: [
                                           Positioned(
                                             left: 11,
                                             top: 10.1,
                                             child: Container(
                                               width: 76,
                                               height: 76,
                                               decoration: ShapeDecoration(
                                                 color: Colors.red,
                                                 shape: OvalBorder(side: BorderSide(width: 0.50)),
                                               ),
                                             ),
                                           ),
                                           Positioned(
                                             left: 0,
                                             top: 0,
                                             child: Container(
                                               width: 97,
                                               height: 95,
                                               decoration: ShapeDecoration(
                                                 shape: OvalBorder(
                                                   side: BorderSide(
                                                     width: 0.50,
                                                     strokeAlign: BorderSide.strokeAlignCenter,
                                                     color: Color(0xFF00A991),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           ),
                                           Positioned(
                                             left: 12.5,
                                             top: 11.17,
                                             child: Container(
                                               width: Get.width * 0.19,
                                               height: MediaQuery
                                                   .of(context)
                                                   .size
                                                   .height * 0.0944,
                                               decoration: ShapeDecoration(
                                                 image: DecorationImage(
                                                   image: NetworkImage(
                                                       controller.searchlist[index].image!),
                                                   fit: BoxFit.fill,
                                                 ),
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(120),
                                                 ),
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                     // Generated code for this Container Widget...
                                     Container(
                                       width: Get.width * 0.036,
                                       height: Get.height * 0.040,
                                       decoration: BoxDecoration(
                                         color: ThemeService().isSavedDarkMode() ?  Colors.black: Colors.grey[50],

                                         borderRadius: const BorderRadius.only(
                                           bottomLeft: Radius.circular(50),
                                           bottomRight: Radius.circular(0),
                                           topLeft: Radius.circular(50),
                                           topRight: Radius.circular(0),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             );
                           }
                       );
                     }}
                      )

                  )
                                  )


          ],
                  ),
        ),
      ],
    ))
    );
  }
}

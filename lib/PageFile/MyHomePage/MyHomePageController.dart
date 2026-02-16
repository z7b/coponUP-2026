import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coppon_3pp/DartMode/theme_service.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/Home-Services.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/Model-MyHomePage/Banner_Model.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/Model-MyHomePage/Catageries_Model.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/Model-MyHomePage/Coupons_Model.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/Model-MyHomePage/Game_Box_Model.dart';
import 'package:coppon_3pp/PageFile/MyHomePage/Model-MyHomePage/Selected_Offers_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'Model-MyHomePage/BoxRedGreemAd_Model.dart';

class MyHomePageControlle extends GetxController {

  MyHomePageControlle() {
    getCatageries();
  }
  final RxBool isPressed = false.obs; // تعريف متغير لتخزين حالة الضغط
  // عدد الأعمدة في الشبكة (افتراضي 3)
  final RxInt columns = 3.obs;

  // اتجاه الشبكة (RTL أم LTR)
  final RxBool isRTL = true.obs;

  // المسافة بين العناصر (افتراضي 8.0)
  final RxDouble spacing = 8.0.obs;
  // حركة ايقونه الاعدادات
   var rotation = 0.0.obs;

  final int ikcoin = 4;
  @override
  void onInit() async {
    await getSelectedOffersV1();
    await getCouponsProducts();
    await getGameBoxModelModel();// تحميل العناصر عند بدء التطبيق
    await getBoxRedAd();// تحميل العناصر عند بدء التطبيق
    await getBoxGreenAd();// تحميل العناصر عند بدء التطبيق
    await getBannerFirst();
    await getBannerLast();
    await getBannerCenter();

  super.onInit();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var favouritesListJson = prefs.getString('favouritesList');
    if (favouritesListJson != null) {

      List<dynamic> favouritesListData = json.decode(favouritesListJson);
      favouriteslist = favouritesListData.map((e) =>  CouponsModel.fromJson(e)).toList().obs;
      // استخدام favouritesList لعرض القائمة المفضلة
    } else {
      // لا يوجد أي بيانات مخزنة حتى الآن
    }
    // تعيين القيم الأولية للقوائم الأخرى
    catagerylist.value = _couponsModel;
  //  searchlist.value = couponsModel;]


    // تنفيذ الحركة عند دخول التطبيق
    SchedulerBinding.instance.addPostFrameCallback((_) {
      rotation.value = 2 * 3.1416; // 360 درجة
    });
  }


  Widget imageSlider(String ? imageUrl) {
    // int ? inCont = 0;
    // وجت البنر المتحرك
    return Card(
     color: ThemeService().isSavedDarkMode() ? Colors.black : Colors.white,
     // shadowColor: const Color(0xFFF89809),
      //color: inCont == 2 ? Colors.blueAccent[100] : Colors.pinkAccent,
      // color:Color.fromRGBO(176, 228, 221, 0.5),
      child: Container(
        decoration: BoxDecoration(
           /// color: ThemeService().isSavedDarkMode() ? Colors.black : Colors.white,

            image: DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.fill,
          )
        ),
      )
    );
  }



  Future<void> openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
  await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
  Get.snackbar("خطأ", "لا يمكن فتح الرابط", snackPosition: SnackPosition.BOTTOM);
  }
  }


// داخل الدالة التي تتعامل مع الحدث (مثلاً عند الضغط على زر)


   int currentIndex= 0;
  int selectedIndex =0;

  List<double> rotationAngles = List.filled(100, 0.0); // مصفوفة لحفظ الزوايا (افتراضًا 100 عنصر)

  void setSelectedIndex(int index) {
    selectedIndex = index;
    rotationAngles[index] += 360; // تحديث الزاوية
    update();
  }
// وجت النقاط تحت البنر
   Widget circleSlider ( currentIndex ){
     // وجت النقاط تحت البنر
     return Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         for(int i =0 ; i<4; i++)
           Container(
             margin: const EdgeInsets.symmetric(horizontal: 1.5,vertical: 0.9),
             height: 7,
             width: i ==currentIndex?7:4,
             decoration: BoxDecoration(
               color: i == currentIndex? Colors.orange:const Color(0xFFF8974F),
               shape: BoxShape.circle,
             ),
           )
       ],
     );
   }

  void iseloding() async {
   return await Future.delayed(const Duration(seconds: 2));
  }



   List<CouponsModel> get couponsModel => _couponsModel;
   List<CouponsModel> _couponsModel =[];

  getCouponsProducts ()async{

    HomeServics().getCoupons().then((value) {
      for(int i=0 ;i< value.length;i++) {
        _couponsModel.add(CouponsModel.fromJson(value[i].data() as Map<String, dynamic>));
      }
      update();
    });
  }

  List<CatageriesModel> get catageriesModel => _catageriesModel;
  List<CatageriesModel> _catageriesModel =[];

  getCatageries ()async{

    HomeServics().getCatageries().then((value) {
      for(int i=0 ;i< value.length;i++) {
        _catageriesModel.add(CatageriesModel.fromJson(value[i].data() as Map<String, dynamic>));
      }
      update();
    });
  }

  var catagerylist =<CouponsModel>[].obs;
  // البحث بناءً على الفئة المختارة
  void addSearchWithCatagerylist(String catageryOnTap) {
    catagerylist.value = couponsModel.where((search) {
      var searchNameTitle = search.id?.toLowerCase();
      return searchNameTitle != null && searchNameTitle.contains(catageryOnTap.toLowerCase());
    }).toList();
  }

  void addSearchWithCatageryALL(){
    catagerylist.value = couponsModel.toList();
    update();
  }

  var searchlist = <CouponsModel>[].obs;
  
  void addSearchToList(String searchName) {
    final trimmedName = searchName.trim().toLowerCase();
    
    if (trimmedName.isEmpty) {
      // إذا كان الحقل فارغاً: عرض جميع الكوبونات
      searchlist.value = couponsModel.toList();
    } else {
      // البحث في الاسم والوصف
      searchlist.value = couponsModel.where((coupon) {
        final name = coupon.name?.toLowerCase() ?? '';
        final description = coupon.describe?.toLowerCase() ?? '';
        return name.contains(trimmedName) || description.contains(trimmedName);
      }).toList();
    }
    update();
  }

// كلاس حذف محتوى البحث
  TextEditingController searchTextController = TextEditingController();

  Future<void> clearSearch() async {
    searchTextController.clear(); // مسح النص في TextField
    addSearchToList(""); // إعادة تعيين القائمة إلى فارغة أو تصفية النتائج
    update(); // تحديث الواجهة مع GetX
  }


// >>

  //



  void mnagfavourites(int? couponid) async {
    if (couponid == null) return; // حماية من null
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var existingCoupon = favouriteslist.indexWhere((element) => element.IdNumber == couponid);

    if (existingCoupon >= 0) {
      // إزالة من القائمة والتخزين
      favouriteslist.removeAt(existingCoupon);
    } else {
      // إضافة إلى القائمة
      try {
        final coupon = couponsModel.firstWhere((element) => element.IdNumber == couponid);
        favouriteslist.add(coupon);
      } catch (e) {
        Get.snackbar("خطأ", "لم يتم العثور على الكوبون", snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }
    
    // حفظ القائمة المحدثة مرة واحدة فقط
    await prefs.setString('favouritesList', json.encode(favouriteslist.map((e) => e.toJson()).toList()));
  }


  var favouriteslist =<CouponsModel>[].obs;

  bool isfavourites ( int? couponid){
    return favouriteslist.any((element) => element.IdNumber == couponid);
  }

  Future<void> openlink(String? url) async {
    final Uri _url = Uri.parse(url!);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }



  List<BoxRedAdModel> get boxRedAdModel => _boxRedAdModel;
  List<BoxRedAdModel> _boxRedAdModel =[];

  getBoxRedAd ()async{

    HomeServics().getboxRedAd().then((value) {
      for(int i=0 ;i< value.length;i++) {
        _boxRedAdModel.add(BoxRedAdModel.fromJson(value[i].data() as Map<String, dynamic>));
      }
      update();
    });
  }

  List<BoxGreenAdModel> get boxGreenAdModel => _boxGreenAdModel;
  List<BoxGreenAdModel> _boxGreenAdModel =[];

  getBoxGreenAd ()async{

    HomeServics().getBoxGreenAd().then((value) {
      for(int i=0 ;i< value.length;i++) {
        _boxGreenAdModel.add(BoxGreenAdModel.fromJson(value[i].data() as Map<String, dynamic>));
      }
      update();
    });
  }
  List<BannerFirstModel> get bannerFirstModel => _bannerFirstModel;
  List<BannerFirstModel> _bannerFirstModel =[];

  getBannerFirst ()async{
    HomeServics().getBannerFirst().then(
        (value){
          for(int i=0 ;i< value.length;i++) {
            _bannerFirstModel.add(BannerFirstModel.fromJson(
                value[i].data() as Map<String, dynamic>
            ));
          }
          update();
        }
    );
  }

  List<BannerCenterModel> get bannerCenterModel => _bannerCenterModel;
  List<BannerCenterModel> _bannerCenterModel =[];
  getBannerCenter()async{
    HomeServics().getBannerCenter().then(
            (value){
          for(int i=0 ;i< value.length;i++) {
            _bannerCenterModel.add(BannerCenterModel.fromJson(
                value[i].data() as Map<String, dynamic>
            ));
          }
          update();
        }
    );
  }

  List<BannerLastModel> get bannerLastModel => _bannerLastModel;
  List<BannerLastModel> _bannerLastModel =[];

  getBannerLast()async{
    HomeServics().getBannerLast().then(
            (value){
          for(int i=0 ;i< value.length;i++) {
            _bannerLastModel.add(BannerLastModel.fromJson(
                value[i].data() as Map<String, dynamic>
            ));
          }
          update();
        }
    );
  }

  List<SelectedOffersV1Model> get selectedOffersV1Model => _selectedOffersV1Model;
  List<SelectedOffersV1Model> _selectedOffersV1Model =[];

  getSelectedOffersV1()async{
    HomeServics().getSelectedOffersV1().then(
            (value){
          for(int i=0 ;i< value.length;i++) {
            _selectedOffersV1Model.add(SelectedOffersV1Model.fromJson(
                value[i].data() as Map<String, dynamic>
            ));
          }
          update();
         /// print(_selectedOffersV1Model.length);
        }
    );
  }

  final RxList<GameBoxModelModel> _gameBoxModelModel = <GameBoxModelModel>[].obs;
  List<GameBoxModelModel> get gameBoxModelModel => _gameBoxModelModel;

  final HomeServics _homeServics = HomeServics();

  /// دالة لتحميل عناصر الكوبونات من Firebase وتحويلها إلى نماذج
  Future<void> getGameBoxModelModel() async {
    try {
      // تفريغ القائمة الحالية لتجنب التكرار عند استدعاء الدالة أكثر من مرة
      _gameBoxModelModel.clear();

      List<QueryDocumentSnapshot> docs = await _homeServics.getGamebox();
      for (int i = 0; i < docs.length; i++) {
        // تحويل بيانات الوثيقة إلى نموذج وإضافتها إلى القائمة
        _gameBoxModelModel.add(
          GameBoxModelModel.fromJson(docs[i].data() as Map<String, dynamic>),
        );
      }
      update(); // تحديث الواجهة عند الانتهاء
    } catch (e) {
    //  print("Error in getCouponsProducts: $e");
    }

  }


  /// **دالة لتحديث عدد الأعمدة ديناميكياً**
  void updateColumns(int newColumns) {
    if (newColumns > 0) {
      columns.value = newColumns;
    }
  }

  /// **دالة لتغيير الاتجاه (RTL/LTR)**
  void toggleDirection() {
    isRTL.value = !isRTL.value;
  }

  /// **دالة لتحديث المسافة بين العناصر**
  void updateSpacing(double newSpacing) {
    spacing.value = newSpacing;
  }
}

/// **Widget لعرض الشبكة باستخدام GetX**

class DescendingGridView extends GetView<MyHomePageControlle> {
  const DescendingGridView({Key? key}) : super(key: key);

  /// دالة لحساب بداية كل صف لضمان الترتيب الصحيح
  int calculateStartIndex(int rowIndex, int columnsValue) {
    int sum = 0;
    for (int i = 0; i < rowIndex; i++) {
      sum += columnsValue - (i % columnsValue);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int columnsValue = controller.columns.value;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, rowIndex) {
                  // حساب عدد العناصر في كل صف بناءً على النمط المتناقص
                  int itemsPerRow = columnsValue - (rowIndex % columnsValue);

                  // حساب بداية الصف باستخدام دالة أكثر دقة
                  int start = calculateStartIndex(rowIndex, columnsValue);
                  int end = start + itemsPerRow - 1;

                  // التأكد من أن الصف الأخير لا يكون عنصر واحد فقط إلا إذا كان العدد يفرض ذلك
                  if (start >= controller._gameBoxModelModel.length) return Container();

                  List<Widget> currentRowItems = [];
                  for (int i = start; i <= end; i++) {
                    if (i < controller._gameBoxModelModel.length) {
                      final imageUrl = controller._gameBoxModelModel[i].image;
                      final describeE = controller._gameBoxModelModel[i].describe;
                      final urlWeb = controller._gameBoxModelModel[i].website;
                      final codeDecon = controller._gameBoxModelModel[i].coupon;

                      currentRowItems.add(
                        Flexible(
                          child: Column(

                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.5), // تغميق الخلفية
                                    builder: (context) {
                                      // متغير لتحديد حالة ظهور الكوبون داخل النافذة
                                      bool showCoupon = false;
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // تأثير الزجاج
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.85,
                                              padding: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.15), // لون زجاجي شفاف
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: Colors.white.withOpacity(0.4)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.redAccent.withOpacity(0.3),
                                                    blurRadius: 15,
                                                    spreadRadius: 3,
                                                  ),
                                                ],
                                              ),
                                              // استخدام StatefulBuilder لتحديث حالة ظهور الكوبون عند الضغط
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  return Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      // صورة اللعبة
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(15),
                                                        child: Image.network(
                                                          imageUrl!,
                                                          width: MediaQuery.of(context).size.width * 0.7,
                                                          height: MediaQuery.of(context).size.height * 0.2,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                      // نسبة الخصم
                                                      Text(
                                                        describeE ?? '',
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                          shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                      // زر الذهاب لموقع اللعبة
                                                      ElevatedButton.icon(
                                                        onPressed: () async {
                                                          Uri url = Uri.parse(urlWeb!);
                                                          if (await canLaunchUrl(url)) {
                                                            await launchUrl(url, mode: LaunchMode.externalApplication);
                                                          }
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Colors.blueAccent[100],
                                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                        ),
                                                        icon: Icon(Icons.gamepad, color: Colors.white),
                                                        label: Text(
                                                          "الذهاب إلى الموقع 🎮",
                                                          style: TextStyle(color: Colors.white, fontSize: 15),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                      // زر نسخ الكوبون مع استخدام flutter_animate
                                                      if (codeDecon != null && codeDecon.isNotEmpty)
                                                  ElevatedButton(
                                                  onPressed: () {
                                                  // عند الضغط نقوم بتغيير الحالة لإظهار الكوبون
                                                  setState(() {
                                                  showCoupon = true;
                                                  });
                                                  Clipboard.setData(ClipboardData(text: codeDecon));
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                  content: Text("تم نسخ الكوبون! ✅"),
                                                  backgroundColor: Colors.green,
                                                  ),
                                                  );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.redAccent,
                                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                  shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  ),
                                                  child: Animate(
                                                  effects: [
                                                  FadeEffect(duration: 300.ms),
                                                  ScaleEffect(duration: 300.ms),
                                                  ],
                                                  child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                  Text(
                                                  showCoupon ? codeDecon : "نسخ الكوبون",
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Icon(Icons.copy, color: Colors.white, size: 22),
                                                  ],
                                                  ),
                                                  ),
                                                  ),
                                                      SizedBox(height: 10),

                                                      // زر إغلاق النافذة
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context),
                                                        child: Text(
                                                          "❌ إغلاق",
                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: Get.width * 0.17,
                                  height: Get.height * 0.07,
                                  decoration: ShapeDecoration(
                                    image: imageUrl != null && imageUrl.isNotEmpty
                                        ? DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.fill,
                                    )
                                        : null,
                                    color: imageUrl == null || imageUrl.isEmpty ? Colors.grey : null,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: imageUrl == null || imageUrl.isEmpty
                                      ? const Icon(Icons.image_not_supported)
                                      : null,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.17,
                                height: Get.height * 0.04,
                                child: Center(
                                  child: Stack(
                                    children: [
                                      // النص مع الحدود (stroke)
                                      Text(
                                        describeE ?? '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 10,
                                          foreground: ThemeService().isSavedDarkMode()
                                              ? (Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 1
                                            ..color = Colors.red)
                                              : (Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 1
                                            ..color = Colors.red[100]!),// حدود حمراء
                                        ),
                                      ),
                                      // النص مع التعبئة (fill)
                                      Text(
                                        describeE ?? '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 10,
                                          color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      );
                    }
                  }

                  // إدراج مسافة بين العناصر باستخدام SizedBox
                  List<Widget> spacedChildren = [];
                  for (int i = 0; i < currentRowItems.length; i++) {
                    spacedChildren.add(currentRowItems[i]);
                    if (i < currentRowItems.length - 1) {
                      spacedChildren.add(SizedBox(width: controller.spacing.value));
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      textDirection: controller.isRTL.value
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      mainAxisSize: MainAxisSize.min,
                      children: spacedChildren,
                    ),
                  );
                },
                childCount: (controller._gameBoxModelModel.length / columnsValue).ceil(),
                // ضمان حساب الصفوف الصحيحة
              ),
            ),
          ],
        ),
      );
    });
  }

}

class CouponWidget extends GetView {
  final int index;

  // لا حاجة لتعريف "controller" هنا لأن GetView توفره تلقائيًا.
  final int? colorBG;
  final String? coupon;
  final CouponsModel couponsModel; // إذا كنت تحتاج إلى تمرير نموذج الكوبون

  // المُنشئ مع تحديد الأنواع وتمرير Key إذا لزم الأمر
  CouponWidget(this.coupon,
      this.index, {
        required this.couponsModel,
        this.colorBG,
        Key? key,
      }) : super(key: key);

  // متغير الحالة الخاص بالكوبون باستخدام GetX
  final showCoupon = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

          // تغيير الحالة لإظهار الكوبون
          showCoupon.value = true;

          // نسخ الكوبون إلى الحافظة
          Clipboard.setData(
            ClipboardData(text: coupon ?? ''),
          );

          // إظهار رسالة تأكيد النسخ
          Get.snackbar("نجاح", "تم نسخ الكوبون ✅",
            colorText: Colors.orangeAccent,
            snackPosition: SnackPosition.TOP,
            /// backgroundColor:Colors.green,
          );


      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          // هنا اللون محدد بشكل ثابت؛ يمكنك تغييره حسب احتياجاتك
          color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.white,
          border: Border.all(
            color: Color(colorBG ?? 0xFFFFFFFF),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        height: MediaQuery
            .of(context)
            .size
            .height * 0.07,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        child: Animate(
          effects: [
            FadeEffect(duration: 300.ms),
            ScaleEffect(duration: 300.ms),
          ],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Obx(() {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: Text(
                    showCoupon.value ? (coupon ?? '') : "نسخ الكوبون",
                    key: ValueKey<bool>(showCoupon.value),
                    style: TextStyle(
                      color: ThemeService().isSavedDarkMode()
                          ? Colors.black87
                          : Color(colorBG ?? 0xFF000000),
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                );
              }),
              Icon(
                Icons.copy,
                color: Color(colorBG ?? 0xFFFFFFFF),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // رابط سياسة الخصوصية الخارجي

}

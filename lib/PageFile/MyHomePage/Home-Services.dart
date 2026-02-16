
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeServics{
  // instance
  final CollectionReference  _couponsCollectionRef = FirebaseFirestore.instance.collection('Coupons');
  //getData
  Future<List<QueryDocumentSnapshot>> getCoupons()async{
      var value = await _couponsCollectionRef.get();
        return value.docs;
  }

  final CollectionReference _CatageriesCollectionReference = FirebaseFirestore.instance.collection('Catageries');
  Future<List<QueryDocumentSnapshot>> getCatageries()async{
    var value = await _CatageriesCollectionReference.get();
    return value.docs;
  }

  final CollectionReference  _GameboxCollectionRef = FirebaseFirestore.instance.collection('game_box');
  //getData
  Future<List<QueryDocumentSnapshot>> getGamebox()async{
    var value = await _GameboxCollectionRef.get();
    return value.docs;
  }

  final CollectionReference _boxRedAdCollectionRef = FirebaseFirestore.instance.collection('boxRed_ad1');
  Future<List<QueryDocumentSnapshot>> getboxRedAd()async{
    var value = await _boxRedAdCollectionRef.get();
    return value.docs;
  }

  final CollectionReference _getboxGreenAdCollectionRef = FirebaseFirestore.instance.collection('boxGreen-ad2');
  Future<List<QueryDocumentSnapshot>> getBoxGreenAd()async{
    var value = await _getboxGreenAdCollectionRef.get();
    return value.docs;
  }

 final CollectionReference _BannerFirstCollectionRef = FirebaseFirestore.instance.collection("Banner-first");
 Future<List<QueryDocumentSnapshot>> getBannerFirst()async{
  var value = await _BannerFirstCollectionRef.get();
  return value.docs;
  }

  final CollectionReference _BannerCenterCollectionRef = FirebaseFirestore.instance.collection("Banner-Center");
  Future<List<QueryDocumentSnapshot>> getBannerCenter()async{
    var value = await _BannerCenterCollectionRef.get();
    return value.docs;
  }

  final CollectionReference _BannerLastCollectionRef = FirebaseFirestore.instance.collection("Banner-last");
  Future<List<QueryDocumentSnapshot>> getBannerLast()async{
    var value = await _BannerLastCollectionRef.get();
    return value.docs;
  }

  final CollectionReference _SelectedOffersV1CollectionRef = FirebaseFirestore.instance.collection("Selected Offers v1");
  Future<List<QueryDocumentSnapshot>> getSelectedOffersV1()async{
    var value = await _SelectedOffersV1CollectionRef.get();
    return value.docs;
  }
}

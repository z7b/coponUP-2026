class BoxRedAdModel {
  // ignore: non_constant_identifier_names
  String? rate ;
  String? Short_description ;
  String ? coupon;
  String? Price_before;
  String? price_after;
  String? id ;
  String? image ;
  String? name ;
  String? website ;
  int? IdNumber;
  // ignore: non_constant_identifier_names
  BoxRedAdModel({this.coupon,this.IdNumber,this.id,this.image,this.name,this.website,
    this.price_after,this.Price_before,this.Short_description,this.rate,});

  BoxRedAdModel.fromJson(Map<String, dynamic> json) {
    IdNumber = json['IdNumber'];
    Price_before = json['Price_before'];
    Short_description = json['Short_description'];
    id = json['id'];
    coupon = json['coupon'];
    image = json['image'];
    name = json['name'];
    price_after = json['price_after'];
    rate = json['rate'];
    website = json['website'];
  }
  toJson(){
    return {
      'price_after': price_after,
      'rate': rate,
      'IdNumber': IdNumber,
      'Price_before': Price_before,
      'Short_description': Short_description,
      'id': id,
      'coupon':coupon,
      'image': image,
      'name': name,
      'website': website,
    };}


}

class BoxGreenAdModel {
  // ignore: non_constant_identifier_names
  String? rate ;
  String? Short_description ;
  String ? coupon;
  String? Price_before;
  String? price_after;
  String? id ;
  String? image ;
  String? name ;
  String? website ;
  int? IdNumber;
  // ignore: non_constant_identifier_names
  BoxGreenAdModel({this.coupon,this.IdNumber,this.id,this.image,this.name,this.website,
    this.price_after,this.Price_before,this.Short_description,this.rate,});

  BoxGreenAdModel.fromJson(Map<String, dynamic> json) {
    IdNumber = json['IdNumber'];
    Price_before = json['Price_before'];
    Short_description = json['Short_description'];
    id = json['id'];
    coupon = json['coupon'];
    image = json['image'];
    name = json['name'];
    price_after = json['price_after'];
    rate = json['rate'];
    website = json['website'];
  }
  toJson(){
    return {
      'price_after': price_after,
      'rate': rate,
      'IdNumber': IdNumber,
      'Price_before': Price_before,
      'Short_description': Short_description,
      'id': id,
      'coupon':coupon,
      'image': image,
      'name': name,
      'website': website,
    };}
}
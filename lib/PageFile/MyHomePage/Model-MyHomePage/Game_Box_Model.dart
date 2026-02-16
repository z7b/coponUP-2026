 class GameBoxModelModel {
  int? ColorBG;
  // ignore: non_constant_identifier_names
  String? discount_rate ;
  String? country ;
  String ? coupon;
  String? describe;
  // ignore: non_constant_identifier_names
  String? discount_description;
  String? id ;
  String? image ;
  String? name ;
  String? website ;
  int? IdNumber;
  // ignore: non_constant_identifier_names
  GameBoxModelModel({this.discount_rate,this.country,this.describe,
    // ignore: non_constant_identifier_names
    this.coupon,
    this.ColorBG,
    this.IdNumber,
    this.discount_description,this.id,this.image,this.name,this.website});

  GameBoxModelModel.fromJson(Map<String, dynamic> json) {
    ColorBG = json['ColorBG'];
    IdNumber = json['IdNumber'];
    discount_rate = json['discount_rate'];
    country = json['country'];
    describe = json['describe'];
    discount_description = json['discount_description'];
    id = json['id'];
    coupon = json['coupon'];
    image = json['image'];
    name = json['name'];
    website = json['website'];
  }
  toJson(){
    return {
      'ColorBG' : ColorBG,
      'IdNumber': IdNumber,
      'discount_rate': discount_rate,
      'country': country,
      'describe': describe,
      'discount_description': discount_description,
      'id': id,
      'coupon':coupon,
      'image': image,
      'name': name,
      'website': website,
    };}


}
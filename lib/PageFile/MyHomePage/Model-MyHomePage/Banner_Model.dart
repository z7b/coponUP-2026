class BannerFirstModel{
  String? name;
  String? rate ;
  String? Short_description ;
  String ? coupon;
  String? id ;
  String? image ;
  String? website ;
  int? IdNumber;
  BannerFirstModel({ this.rate, this.Short_description, this.coupon, this.IdNumber,
    this.id,  this.image,  this.name,  this.website,});

  BannerFirstModel.fromJson(Map<String, dynamic> json) {
    IdNumber = json['IdNumber'];
    id = json['id'];
    coupon = json['coupon'];
    image = json['image'];
    name = json['name'];
    website = json['website'];
    rate =json['rate'];
    Short_description = json['Short_description'];
  }
}



class BannerCenterModel{
  String? name;
  String? rate ;
  String? Short_description ;
  String ? coupon;
  String? id ;
  String? image ;
  String? website ;
  int? IdNumber;
  BannerCenterModel({ this.rate, this.Short_description, this.coupon, this.IdNumber,
    this.id,  this.image,  this.name,  this.website,});

  BannerCenterModel.fromJson(Map<String, dynamic> json) {
    IdNumber = json['IdNumber'];
    id = json['id'];
    coupon = json['coupon'];
    image = json['image'];
    name = json['name'];
    website = json['website'];
    rate =json['rate'];
    Short_description = json['Short_description'];
  }
}

class BannerLastModel{
  String? name;
  String? rate ;
  String? Short_description ;
  String ? coupon;
  String? id ;
  String? image ;
  String? website ;
  int? IdNumber;
  BannerLastModel({ this.rate, this.Short_description, this.coupon, this.IdNumber,
    this.id,  this.image,  this.name,  this.website,});

  BannerLastModel.fromJson(Map<String, dynamic> json) {
    IdNumber = json['IdNumber'];
    id = json['id'];
    coupon = json['coupon'];
    image = json['image'];
    name = json['name'];
    website = json['website'];
    rate =json['rate'];
    Short_description = json['Short_description'];
  }
}
class SelectedOffersV1Model{
  String? name;
  String? rate ;
  String? Short_description ;
  String ? coupon;
  String? id ;
  String? image ;
  String? website ;
  int? IdNumber;
  SelectedOffersV1Model({ this.rate, this.Short_description, this.coupon, this.IdNumber,
    this.id,  this.image,  this.name,  this.website,});

  SelectedOffersV1Model.fromJson(Map<String, dynamic> json) {
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
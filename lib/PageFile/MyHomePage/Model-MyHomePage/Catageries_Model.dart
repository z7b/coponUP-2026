class CatageriesModel{
  String? id;
  String? name;
CatageriesModel(
  {
    this.name,
    this.id,
  });
  CatageriesModel.fromJson(Map<String, dynamic> json){
    name = json['name'];

    id =json['id'];
  }
  toJson(){
    return {
      'id':id,
      'name':name,

    };
  }


}
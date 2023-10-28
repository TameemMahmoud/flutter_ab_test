class ItemModel {
  int? id;
  String? title;
  String? description;
  String? imgLink;
  String? email;

  ItemModel({this.id, this.title, this.description, this.imgLink, this.email});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imgLink = json['img_link'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['img_link'] = imgLink;
    data['email'] = email;
    return data;
  }
}

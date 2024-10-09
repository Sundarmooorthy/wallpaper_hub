class CategoryModel {
  String? categoryName;
  String? imgUrl;

  CategoryModel({this.categoryName, this.imgUrl});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}

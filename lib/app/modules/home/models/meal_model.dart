class MealModel {
  List<Meal>? categories;

  MealModel({this.categories});

  MealModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Meal>[];
      json['categories'].forEach((v) {
        categories!.add(Meal.fromJson(v));
      });
    }
  }
}

class Meal {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  Meal({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        idCategory: json['idCategory'],
        strCategory: json['strCategory'],
        strCategoryThumb: json['strCategoryThumb'],
        strCategoryDescription: json['strCategoryDescription'],
      );

  Map<String, dynamic> toJson() => {
        'idCategory': idCategory,
        'strCategory': strCategory,
        'strCategoryThumb': strCategoryThumb,
        'strCategoryDescription': strCategoryDescription,
      };
}

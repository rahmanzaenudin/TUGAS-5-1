class DetailModel {
  List<Detail>? meals;

  DetailModel({this.meals});

  DetailModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Detail>[];
      json['meals'].forEach((v) {
        meals!.add(Detail.fromJson(v));
      });
    }
  }
}

class Detail {
  String strMeal;
  String strMealThumb;

  Detail({
    required this.strMeal,
    required this.strMealThumb,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        strMeal: json['strMeal'],
        strMealThumb: json['strMealThumb'],
      );

  Map<String, dynamic> tojson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
      };
}

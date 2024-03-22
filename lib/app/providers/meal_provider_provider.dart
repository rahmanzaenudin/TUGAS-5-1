import 'package:apiget/app/modules/home/models/detail_model.dart';
import 'package:apiget/app/modules/home/models/meal_model.dart';
import 'package:get/get.dart';

class MealProvider extends GetConnect {
  Future<MealModel> getMeals() async {
    final Response =
        await get('https://www.themealdb.com/api/json/v1/1/categories.php');
    if (Response.status.hasError) {
      return Future.error(Response.statusText!);
    } else {
      return MealModel.fromJson(Response.body as Map<String, dynamic>);
    }
  }

  Future<DetailModel> getMealsByCategory(String apiUrl) async {
    final Response = await get(apiUrl);
    if (Response.status.hasError) {
      return Future.error(Response.statusText!);
    } else {
      return DetailModel.fromJson(Response.body as Map<String, dynamic>);
    }
  }
}

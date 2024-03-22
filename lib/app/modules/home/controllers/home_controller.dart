import 'package:apiget/app/modules/home/models/detail_model.dart';
import 'package:apiget/app/modules/home/models/meal_model.dart';
import 'package:apiget/app/providers/meal_provider_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Future<MealModel> getMeals() async {
    final data = await MealProvider().getMeals();
    return data;
  }

  Future<DetailModel> getMealsByCategory(String apiUrl) async {
    final data = await MealProvider().getMealsByCategory(apiUrl);
    return data;
  }
}

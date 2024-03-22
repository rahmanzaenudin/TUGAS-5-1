import 'package:apiget/app/modules/home/models/detail_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class DetailView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final String apiUrl =
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=${Get.arguments}";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${Get.arguments} Recipe',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: FutureBuilder<DetailModel>(
              future: controller.getMealsByCategory(apiUrl),
              builder: (_, snapshot) {
                var data = snapshot.data?.meals;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.h,
                      crossAxisCount: 1,
                      childAspectRatio: .8,
                    ),
                    itemBuilder: (_, index) => detailmeal(data, index),
                    itemCount: data?.length,
                  );
                } else {
                  return const Center(
                    child: Text("Data Kosong"),
                  );
                }
              },
            ),
          )
        ],
      ).paddingOnly(left: 10.w, right: 10.w, bottom: 5.h),
    );
  }
}

Container detailmeal(List<Detail>? data, int index) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        ScreenUtil().setWidth(10),
      ),
      border: Border.all(
        color: Colors.grey[300]!,
        width: 1.h,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              ScreenUtil().setWidth(10),
            ),
            topRight: Radius.circular(
              ScreenUtil().setWidth(10),
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: "${data?[index].strMealThumb}",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  data?[index].strMeal ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              15.verticalSpace,
            ],
          ).paddingOnly(
            top: 10.h,
            left: 10.w,
            right: 10.w,
          ),
        ),
      ],
    ),
  );
}

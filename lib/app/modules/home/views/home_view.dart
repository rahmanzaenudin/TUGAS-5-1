import 'package:apiget/app/modules/home/views/detail_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apiget/app/modules/home/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(10),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 18.r,
                      color: Colors.grey[500],
                    ),
                    20.horizontalSpace,
                    Text(
                      "Search",
                      style: GoogleFonts.poppins(fontSize: 12.sp),
                    )
                  ],
                ).paddingAll(10.r),
              ),
            ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Meal List From API",
            style: GoogleFonts.poppins(
                fontSize: 20.sp, fontWeight: FontWeight.w500),
          ).paddingOnly(bottom: 20.h),
          Flexible(
            child: FutureBuilder<MealModel>(
              future: controller.getMeals(),
              builder: (_, snapshot) {
                var data = snapshot.data?.categories;
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
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                    ),
                    itemBuilder: (_, index) => itemMeal(data, index),
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

Container itemMeal(List<Meal>? data, int index) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        ScreenUtil().setWidth(5),
      ),
      border: Border.all(
        color: Colors.grey[300]!,
        width: 1.h,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            await Get.to(
              DetailView(),
              arguments: data?[index].strCategory,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                ScreenUtil().setWidth(10),
              ),
              topRight: Radius.circular(
                ScreenUtil().setWidth(10.h),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: "${data?[index].strCategoryThumb}",
              height: 135.h,
              width: 200.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
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
                  data?[index].strCategory ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: Text(
                  data?[index].strCategoryDescription ?? "",
                  style: GoogleFonts.poppins(fontSize: 10),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

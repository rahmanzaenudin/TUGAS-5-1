import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
  );
}

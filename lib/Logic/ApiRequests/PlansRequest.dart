import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagment/PlansState.dart';
import 'package:test_store/Logic/StateManagment/UserState.dart';
import 'package:test_store/Variables/EndPoints.dart';

Future requestPlans({required isRefresh, required BuildContext context}) async {
  Dio dio = Dio();
  final _userToken = context.read(userStateManagment).userToken;
  Options requestOptions = Options(
    responseType: ResponseType.json,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _userToken!,
      'Charset': 'utf-8'
    },
  );
  if (isRefresh) {
    context.read(plansStateManagment).plans.clear();
  }
  try {
    final response = await dio.get(
      apiPlansUrl,
      options: requestOptions,
    );
    context.read(plansStateManagment).addPlans(response.data["data"]["plans"]);
  } catch (e) {
    Get.defaultDialog(title: "خطأ", middleText: e.toString());
  }
}

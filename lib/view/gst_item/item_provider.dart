import 'package:flutter/material.dart';
import 'package:mvvm_demo/modals/gst_section_data.dart';
import 'package:mvvm_demo/repository/repository.dart';
import 'package:mvvm_demo/service/api_response.dart';
import 'package:mvvm_demo/utils/common_toast.dart';

import '../../modals/goods_item_code.dart';

class ItemProvider with ChangeNotifier {
  final _appRepository = AppRepository();

  ApiResponse<List<GoodsItemCode>> sections = ApiResponse.loading();

  setCodes(ApiResponse<List<GoodsItemCode>> response) {
    sections = response;
    notifyListeners();
  }

  Future<void> fetchGSTCode() async {
    setCodes(ApiResponse.loading());
    _appRepository.getItemCode().then((value) {
      setCodes(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      commonToast("Something went wrong: ${error.toString()}");
      setCodes(ApiResponse.error(error.toString()));
      print(error);
    });
  }
}
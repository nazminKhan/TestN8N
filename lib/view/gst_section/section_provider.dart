import 'package:flutter/material.dart';
import 'package:mvvm_demo/modals/gst_section_data.dart';
import 'package:mvvm_demo/repository/repository.dart';
import 'package:mvvm_demo/service/api_response.dart';
import 'package:mvvm_demo/utils/common_toast.dart';

class SectionProvider with ChangeNotifier {
  final _appRepository = AppRepository();

  ApiResponse<List<GSTSectionData>> sections = ApiResponse.loading();

  setSections(ApiResponse<List<GSTSectionData>> response) {
    sections = response;
    notifyListeners();
  }

  Future<void> fetchSections() async {
    setSections(ApiResponse.loading());
    _appRepository.getSections().then((value) {
      setSections(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      commonToast("Something went wrong: ${error.toString()}");
      setSections(ApiResponse.error(error.toString()));
      print(error);
    });
  }
}
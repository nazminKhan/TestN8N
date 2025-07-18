import 'package:mvvm_demo/modals/user_list.dart';
import 'package:mvvm_demo/service/network_services.dart';
import 'package:mvvm_demo/utils/common_toast.dart';
import 'package:flutter/services.dart'; // Add this import
import 'dart:convert'; // Add this import

import '../modals/goods_item_code.dart';
import '../modals/gst_section_data.dart';

class AppRepository{
  final BaseApiServices _apiServices=NetworkApiServices();
  String baseUrl="https://reqres.in";
  
  Future<dynamic> userLogin(dynamic data)async{
    var response = await _apiServices.postApi("$baseUrl${"/api/login"}", data);
    print(response);
    
    try{
        return response;
    }
    catch(e)
    {
      commonToast(e.toString());
    }
  }

  Future<UserList?> userList()async{
    var response = await _apiServices.getApi("$baseUrl${"/api/users?page=2"}");
    print(response);
    
    try{
        return response=UserList.fromJson(response);
    }
    catch(e)
    {
      commonToast(e.toString());
    }
    return null;
  }

  Future<List<GSTSectionData>> getSections() async {
    final String response = await rootBundle.loadString('asset/gst.json');
    // final Map<String, dynamic> jsonObject = json.decode(response);
    // final List<dynamic> jsonArray = jsonObject['acts'];
    // return jsonArray.map((json) => GSTSectionData.fromJson(json)).toList();

    return getGstJsonData(response);
  }

  Future<List<GSTSectionData>> getGstJsonData(String strSection) async {
  try {
    final List<GSTSectionData> sectionDataList = [];
    final Map<String, dynamic> jsonObject = json.decode(strSection);
    final List<dynamic> jsonArray = jsonObject['acts'];

    for (var jsonObj in jsonArray) {
      final String st = jsonObj['st'];
      final String titleValue = jsonObj['title']['value'];
      final String detailsValue = jsonObj['details']['value'];

      final GSTSectionData sectionData = GSTSectionData(
        st: st,
        title: titleValue,
        details: detailsValue,
      );
      sectionDataList.add(sectionData);
    }

    return sectionDataList;
   
  } catch (e) {
    print('Error parsing JSON: $e');
  }
  return [];
}

// Future<List<GoodsItemCode>> getItemCode() async {
//     final String response = await rootBundle.loadString('asset/hsn.json');
//     // final Map<String, dynamic> jsonObject = json.decode(response);
//     // final List<dynamic> jsonArray = jsonObject['acts'];
//     // return jsonArray.map((json) => GSTSectionData.fromJson(json)).toList();

//     final Map<String, dynamic> jsonObject = json.decode(response);
//     return jsonObject.map((json) => GoodsItemCode.fromJson(json)).toList();
//   }
Future<List<GoodsItemCode>> getItemCode() async {
    try {
    // Load the JSON data from the asset file
    final String response = await rootBundle.loadString('asset/hsn.json');
    final Map<String, dynamic> jsonObject = json.decode(response);
    final List<dynamic> jsonArray = jsonObject['features'];

    // Parse the JSON data and create a list of GoodsItemCode objects
    final List<GoodsItemCode> goodsItemCodeList = jsonArray.map((json) {
      final properties = json['properties'];
      return GoodsItemCode.fromJson(properties);
    }).toList();
    return goodsItemCodeList;
    
  } catch (e) {
    print('Error parsing JSON: $e');
  }
  return [];
  }
  
}
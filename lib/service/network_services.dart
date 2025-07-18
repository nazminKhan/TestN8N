import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import 'app_exception.dart';

abstract class BaseApiServices{
  Future<dynamic> postApi(String url, dynamic data);
  Future<dynamic> getApi(String url);
}

class NetworkApiServices extends BaseApiServices{

  // dynamic apiResponse(http.Response response)
  // {
  //     switch(response.statusCode){
  //       case 200:
  //        return  jsonDecode(response.body);
  //       case 201:
  //         return jsonDecode(response.body);

  //       case 401:
  //         throw UnAuthorizedException(message: response.body.toString());

  //       default:
  //         throw FetDataException(message: "Error during communication");
  //     }
  // }

  dynamic apiResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      if (response.headers['content-type']?.contains('application/xml') ?? false) {
        // Parse XML response
        return xml.XmlDocument.parse(response.body);
      } else if (response.headers['content-type']?.contains('application/json') ?? false) {
        // Parse JSON response
        return jsonDecode(response.body);
      } else {
        throw Exception('Unsupported content type: ${response.headers['content-type']}');
      }

    case 401:
      throw UnAuthorizedException(message: response.body.toString());

    default:
      throw FetDataException(message: "Error during communication");
  }
}

  @override
  Future getApi(String url)async {
    dynamic responseJson;
    try {
      http.Response response=await http.get(Uri.parse(url)).timeout(const Duration(seconds:30));
      responseJson = apiResponse(response);
    }  catch (e) {
      print(e.toString());
    }
    return responseJson;

  }

  @override
  Future postApi(String url, data)async {
    dynamic responseJson;
    try {
      http.Response response=await http.post(Uri.parse(url),body:data).timeout(const Duration(seconds:30));
      print('response$response');
      responseJson = apiResponse(response);
    }  catch (e) {
     print(e.toString());
    }
    return responseJson;
  }

}
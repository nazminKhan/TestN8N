import 'package:mvvm_demo/modals/user_list.dart';
import 'package:mvvm_demo/service/network_services.dart';
import 'package:mvvm_demo/utils/common_toast.dart';

class AppRepositoryNews{
  final BaseApiServices _apiServices=NetworkApiServices();
  String baseUrl="https://news.google.com/rss/search";
  
  // Future<dynamic> userLogin(dynamic data)async{
  //   var response = await _apiServices.postApi("$baseUrl${"/api/login"}", data);
  //   print(response);
    
  //   try{
  //       return response;
  //   }
  //   catch(e)
  //   {
  //     commonToast(e.toString());
  //   }
  // }

Future<dynamic> newsList(String q, String hl, String gl) async {
  try {
    // Construct the full URL with query parameters
    final String url = "$baseUrl?q=$q&hl=$hl&gl=$gl";

    // Make the API call
    var response = await _apiServices.getApi(url);
    print("API Response: $response");

    // Parse the response into a UserList object
    return response;
  } catch (e) {
    // Show error toast and handle exceptions gracefully
    commonToast("Error: ${e.toString()}");
    return null;
  }
}

}



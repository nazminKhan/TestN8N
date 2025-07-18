import 'package:flutter/material.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/service/api_service.dart';
import 'package:mvvm_demo/app_store/app_store.dart';
import 'package:mvvm_demo/utils/common_toast.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _token;

  bool get isLoading => _isLoading;
  String? get token => _token;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> useLogin(Map data, BuildContext context) async {
    setLoading(true);

    try {
      final Map<String, dynamic> loginData = {
        'email': data['email'].toString(),
        'password': data['password'].toString(),
      };
      
      final response = await ApiService().loginApi(loginData);
      if (response != null && response['token'] != null) {
        _token = response['token'];
        AppStore().setUserToken(_token!);
        commonToast("Login successful");
        Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
      } else {
        throw Exception('Login failed: Invalid response');
      }
    } catch (e) {
      commonToast("Login failed: ${e.toString()}");
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:mvvm_demo/modals/user_list.dart';
import 'package:mvvm_demo/repository/repository.dart';
import 'package:mvvm_demo/service/api_response.dart';
import 'package:mvvm_demo/utils/common_toast.dart';

class UserListProvider with ChangeNotifier{
  final _appRepository =AppRepository();

  ApiResponse<UserList> userList = ApiResponse.loading();
  setUserList(ApiResponse<UserList> response){
    userList=response;
    notifyListeners();
  }

   Future<void> fetchUserList()async{
    setUserList(ApiResponse.loading());
    _appRepository.userList().then((value){

     setUserList(ApiResponse.complete(value));

    }).onError((error,stackTrace){
      commonToast("Something went wrong$error.toString()");
      setUserList(ApiResponse.error(error.toString()));
      print(error);
    });
  }
}
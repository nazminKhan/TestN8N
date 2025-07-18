class AppException implements Exception{
  final message;
  final prefix;
  AppException([this.message,this.prefix]);

  String toString(){
    return '$prefix$message';
  }
}

class FetDataException extends AppException{
  FetDataException({String? message}): super(message," Error during communication");
}

class UnAuthorizedException extends AppException{
  UnAuthorizedException({String? message}): super(message," Error during communication");
}
import 'package:tasks_app/exceptions/custom_exception.dart';

class UserNotExistException extends CustomException {
  UserNotExistException([String message])
      : super(message, 'There is no user currently signed-in.');
}

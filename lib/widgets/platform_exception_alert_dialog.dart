import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:pets/widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );
  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': 'your password is weak.',
    'ERROR_EMAIL_ALREADY_IN_USE': 'This email is already used.',
    'ERROR_INVALID_EMAIL': 'Invalid email',
    'ERROR_WRONG_PASSWORD': 'Your password is invalid.',
    'ERROR_USER_NOT_FOUND': 'User is not found.',
    'ERROR_USER_DISABLED': 'This email is disabled.',
    'ERROR_TOO_MANY_REQUESTS': 'Too many request please try again later',
    'ERROR_OPERATION_NOT_ALLOWED':
        'This operation is not allowed at the moment.'
  };
}

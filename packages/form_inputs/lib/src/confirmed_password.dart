import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError { invalid }

/// Form input for a confirmed password input.
class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// The original password
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String? value){
    return password == value ? null : ConfirmedPasswordValidationError.invalid;
  }
}

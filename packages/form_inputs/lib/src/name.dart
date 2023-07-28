import 'package:formz/formz.dart';


enum NameValidationError { invalid }

/// Form input for a confirmed name input.
class Name
    extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');

  const Name.dirty([super.value = ''])
      : super.dirty();

  static final RegExp _nameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,}$');

  @override
  NameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '') ? null : NameValidationError.invalid;
  }
}
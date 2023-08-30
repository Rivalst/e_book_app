import 'package:shared_preferences/shared_preferences.dart';

abstract class LoadLanguageFromSharedPreferences {
  Future<void> safeLanguage({required newLanguage});
  Future<String?> loadSelectLanguage();
}

/// This class for safe and load last selcted language in app.
class LanguageSetManager extends LoadLanguageFromSharedPreferences {

  @override
  Future<void> safeLanguage({required newLanguage}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', newLanguage.toString());
  }

  @override
  Future<String?> loadSelectLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selectedLanguage');
    return selectedLanguage;
  }
}

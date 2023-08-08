import 'package:shared_preferences/shared_preferences.dart';

class LanguageSetManager {

  Future<void> safeLanguage({required newLanguage}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', newLanguage.toString());
  }

  Future<String?> loadSelectLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selectedLanguage');
    return selectedLanguage;
  }
}

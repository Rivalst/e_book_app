import 'package:bloc/bloc.dart';
import 'package:e_book_app/model/dataresources/local/language_set_manager.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(Language.english)){
    loadLanguage();
  }

  void changeLanguage(Language newLanguage) {
    emit(LanguageState(newLanguage));
    LanguageSetManager().safeLanguage(newLanguage: newLanguage);
  }

  void loadLanguage() async {
    Future<String?> language = LanguageSetManager().loadSelectLanguage();
    String? selectedLanguage = await language;
    if (selectedLanguage == Language.ukrainian.toString()) {
      emit(LanguageState(Language.ukrainian));
    } else {
      emit(LanguageState(Language.english));
    }
  }
}

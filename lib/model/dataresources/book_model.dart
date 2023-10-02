class Book {
  final int id;
  final String title;
  final String authorName;
  final int authorBirthday;
  final int authorDeath;
  final String photo;
  final String text;

  final List<String> language;
  final List<String> subjects;

  Book({
    required this.id,
    required this.title,
    required this.authorName,
    required this.language,
    required this.authorBirthday,
    required this.authorDeath,
    required this.photo,
    required this.text,
    required this.subjects,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return Book(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        authorName: json['authors'] != null && json['authors'].isNotEmpty
            ? json['authors'][0]['name'] ?? ''
            : '',
        authorBirthday: json['authors'] != null &&
                json['authors'].isNotEmpty &&
                json['authors'][0]['birth_year'] != null
            ? json['authors'][0]['birth_year']
            : 0,
        authorDeath: json['authors'] != null &&
                json['authors'].isNotEmpty &&
                json['authors'][0]['death_year'] != null
            ? json['authors'][0]['death_year']
            : 0,
        photo: json['image'] ?? '',
        language: json['languages'] != null
            ? List<String>.from(json['languages'])
            : [],
        text: json['text'] ?? '',
        subjects:
            json['subjects'] != null ? List<String>.from(json['subjects']) : [],
      );
    } else {
      return Book(
        id: 0,
        title: '',
        authorName: '',
        authorBirthday: 0,
        authorDeath: 0,
        language: [],
        text: '',
        photo: '',
        subjects: [],
      );
    }
  }
}

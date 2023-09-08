import 'package:equatable/equatable.dart';

class User extends Equatable {

  const User({required this.id, this.email, this.name, this.photo, this.books});

  /// The current user's email
  final String? email;

  /// The current user's id
  final String id;

  /// The current user's name
  final String? name;

  /// Url for the current user's photo
  final String? photo;

  final Map<String, dynamic>? books;

  /// Empty user which represents an unauthenticated user
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [email, id, name, photo];
}
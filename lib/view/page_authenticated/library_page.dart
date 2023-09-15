import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/bloc/book_library_get/book_library_get_bloc.dart';
import 'package:e_book_app/controller/cubit/book_discover_library/book_discover_library_cubit.dart';
import 'package:e_book_app/controller/cubit/loaded_book/is_load_cubit.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:e_book_app/model/repositories/book_repository.dart';
import 'package:e_book_app/view/page_authenticated/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final FocusNode _focusNode = FocusNode();
  bool focusCheck = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          focusCheck = true;
        });
      } else {
        setState(() {
          focusCheck = false;
        });
      }
    });

    return BlocBuilder<BookLibraryGetBloc, BookLibraryGetState>(
      builder: (context, state) {
        return BlocBuilder<BookDiscoverLibraryCubit, List<Book>>(
          builder: (context, stateBooks) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: DefaultTabController(
                length: focusCheck ? 0 : 5,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: AppColorThemeBraunBlack.of(context)
                          .whiteColorBackground,
                      title: TextField(
                        decoration: const InputDecoration(
                            hintText: 'Search', prefixIcon: Icon(Icons.search)),
                        focusNode: _focusNode,
                        onChanged: (element) {
                          context
                              .read<BookDiscoverLibraryCubit>()
                              .search(element);
                        },
                      ),
                      bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: AppColorThemeBraunBlack.of(context)
                            .lightBraunColor100,
                        labelColor: AppColorThemeBraunBlack.of(context)
                            .lightBraunColor100,
                        tabs: focusCheck
                            ? []
                            : const [
                          Text('All Library'),
                          Text('In reading'),
                          Text('Will be read'),
                          Text('Has been read'),
                          Text('Likes')
                        ],
                      ),
                    ),
                    body: focusCheck
                        ? SizedBox(
                      height:
                      MediaQuery.of(context).size.height - 22.0 * 2,
                      child: ListView.builder(
                          itemCount: stateBooks.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Book book = stateBooks[index];
                            final String title = book.title;
                            final String authorName = book.authorName;
                            final String urlImage = book.photo;
                            final List<String> languages = book.language;
                            return bookWidget(
                                urlImage: urlImage,
                                title: title,
                                authorName: authorName,
                                languages: languages,
                                book: book);
                          }),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: TabBarView(
                            children: [
                              /// All Library
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height -
                                    22.0 * 2,
                                child: ListView.builder(
                                    itemCount: state.books.length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      final Book book =
                                      state.books[index];
                                      final String title = book.title;
                                      final String authorName =
                                          book.authorName;
                                      final String urlImage = book.photo;
                                      final List<String> languages =
                                          book.language;
                                      return bookWidget(
                                          urlImage: urlImage,
                                          title: title,
                                          authorName: authorName,
                                          languages: languages,
                                          book: book);
                                    }),
                              ),

                              /// In Reading
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height -
                                    22.0 * 2,
                                child: ListView.builder(
                                    itemCount: state.books
                                        .where((book) =>
                                    BooksRepository.instance
                                        .booksInLibraryMap![
                                    book.id.toString()]
                                    ['status'] ==
                                        'In reading')
                                        .length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      final books = state.books
                                          .where((book) =>
                                      BooksRepository.instance
                                          .booksInLibraryMap![
                                      book.id.toString()]
                                      ['status'] ==
                                          'In reading')
                                          .toList();
                                      final Book book = books[index];
                                      final String title = book.title;
                                      final String authorName =
                                          book.authorName;
                                      final String urlImage = book.photo;
                                      final List<String> languages =
                                          book.language;
                                      return bookWidget(
                                          urlImage: urlImage,
                                          title: title,
                                          authorName: authorName,
                                          languages: languages,
                                          book: book);
                                    }),
                              ),

                              /// Will be reading books
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height -
                                    22.0 * 2,
                                child: ListView.builder(
                                    itemCount: state.books
                                        .where((book) =>
                                    BooksRepository.instance
                                        .booksInLibraryMap![
                                    book.id.toString()]
                                    ['status'] ==
                                        'Will be read')
                                        .length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      final books = state.books
                                          .where((book) =>
                                      BooksRepository.instance
                                          .booksInLibraryMap![
                                      book.id.toString()]
                                      ['status'] ==
                                          'Will be read')
                                          .toList();
                                      final Book book = books[index];
                                      final String title = book.title;
                                      final String authorName =
                                          book.authorName;
                                      final String urlImage = book.photo;
                                      final List<String> languages =
                                          book.language;
                                      return bookWidget(
                                          urlImage: urlImage,
                                          title: title,
                                          authorName: authorName,
                                          languages: languages,
                                          book: book);
                                    }),
                              ),

                              /// Has been reading books
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height -
                                    22.0 * 2,
                                child: ListView.builder(
                                    itemCount: state.books
                                        .where((book) =>
                                    BooksRepository.instance
                                        .booksInLibraryMap![
                                    book.id.toString()]
                                    ['status'] ==
                                        'Has been reading')
                                        .length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      final books = state.books
                                          .where((book) =>
                                      BooksRepository.instance
                                          .booksInLibraryMap![
                                      book.id.toString()]
                                      ['status'] ==
                                          'Has been reading')
                                          .toList();
                                      final Book book = books[index];
                                      final String title = book.title;
                                      final String authorName =
                                          book.authorName;
                                      final String urlImage = book.photo;
                                      final List<String> languages =
                                          book.language;
                                      return bookWidget(
                                          urlImage: urlImage,
                                          title: title,
                                          authorName: authorName,
                                          languages: languages,
                                          book: book);
                                    }),
                              ),

                              /// Liked books
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height -
                                    22.0 * 2,
                                child: ListView.builder(
                                    itemCount: state.books
                                        .where((book) =>
                                    BooksRepository.instance
                                        .booksInLibraryMap![
                                    book.id.toString()]
                                    ['status'] ==
                                        'Likes')
                                        .length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      final books = state.books
                                          .where((book) =>
                                      BooksRepository.instance
                                          .booksInLibraryMap![
                                      book.id.toString()]
                                      ['status'] ==
                                          'Likes')
                                          .toList();
                                      final Book book = books[index];
                                      final String title = book.title;
                                      final String authorName =
                                          book.authorName;
                                      final String urlImage = book.photo;
                                      final List<String> languages =
                                          book.language;
                                      return bookWidget(
                                          urlImage: urlImage,
                                          title: title,
                                          authorName: authorName,
                                          languages: languages,
                                          book: book);
                                    }),
                              ),
                            ],
                          )),
                    ),
                    backgroundColor: AppColorThemeBraunBlack.of(context)
                        .whiteColorBackground),
              ),
            );
          },
        );
      },
    );
  }

  Widget bookWidget(
      {required String urlImage,
        required String title,
        required String authorName,
        required List<String> languages,
        required Book book}) {
    return BlocBuilder<IsLoadCubit, bool>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookDetailPage(book: book, key: UniqueKey()),
                )).then((value) {
                  setState(() {
                    focusCheck = true;
                  });
                  setState(() {
                    focusCheck = false;
                  });
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)),
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.0),
                    child: Stack(
                      children: [
                        if (!state)
                          Center(
                              child: CircularProgressIndicator(
                                color: AppColorThemeBraunBlack.of(context)
                                    .lightBraunColor100,
                              )),
                        SizedBox(
                          height: 170,
                          width: 110,
                          child: Image.network(
                            urlImage,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                context.read<IsLoadCubit>().loaded();
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColorThemeBraunBlack.of(context)
                                        .lightBraunColor100,
                                    value: loadingProgress.expectedTotalBytes !=
                                        null
                                        ? loadingProgress
                                        .cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              context.read<IsLoadCubit>().loaded();
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.transparent));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 5.0),
                  // width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: AppColorThemeBraunBlack.of(context)
                                  .blackColor80)),
                      Text(authorName,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColorThemeBraunBlack.of(context)
                                  .blackColor40)),
                      const Placeholder(
                        fallbackHeight: 100,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
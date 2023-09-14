import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/bloc/book_library_get/book_library_get_bloc.dart';
import 'package:e_book_app/controller/cubit/book_library/book_library_cubit.dart';
import 'package:e_book_app/controller/cubit/loaded_book/is_load_cubit.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:e_book_app/model/repositories/book_repository.dart';
import 'package:e_book_app/view/page_authenticated/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookLibraryGetBloc(
          booksList: BooksRepository.instance.books,
          booksMap: BooksRepository.instance.booksInLibraryMap),
      child: BlocBuilder<BookLibraryGetBloc, BookLibraryGetState>(
        builder: (context, state) {
          return DefaultTabController(
            length: 5,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      AppColorThemeBraunBlack.of(context).whiteColorBackground,
                  toolbarHeight: 0,
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorColor:
                        AppColorThemeBraunBlack.of(context).lightBraunColor100,
                    labelColor:
                        AppColorThemeBraunBlack.of(context).lightBraunColor100,
                    tabs: [
                      Text('All Library'),
                      Text('In reading'),
                      Text('Will be read'),
                      Text('Has been read'),
                      Text('Likes')
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: TabBarView(
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height - 22.0 * 2,
                            child: ListView.builder(
                                itemCount: state.books.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Book book = state.books[index];
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
                          ),
                          Text('In reading'),
                          Text('Will be read'),
                          Text('Has Been Read'),
                          Text('Likes')
                        ],
                      )),
                ),
                backgroundColor:
                    AppColorThemeBraunBlack.of(context).whiteColorBackground),
          );
        },
      ),
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
                  builder: (context) => BookDetailPage(book: book)),
            );
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
                      maxWidth: MediaQuery.of(context).size.width / 2.1),
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
                IconButton(
                    onPressed: () {
                      if (state == false) {
                        context.read<BookLibraryCubit>().bookAddInCollection();
                        print('add');
                      } else {
                        context.read<BookLibraryCubit>().bookRemoveInLibrary();
                        print('remove');
                      }
                    },
                    color: AppColorThemeBraunBlack.of(context).blackColor40,
                    icon: state == true
                        ? const Icon(Icons.bookmark)
                        : const Icon(FontAwesomeIcons.bookmark)),
              ],
            ),
          ),
        );
      },
    );
  }
}

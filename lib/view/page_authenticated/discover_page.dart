import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/cubit/book_discover/book_discover_cubit.dart';
import 'package:e_book_app/controller/cubit/filter_for_books/filter_mark_cubit.dart';
import 'package:e_book_app/controller/cubit/loaded_book/is_load_cubit.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:e_book_app/view/page_authenticated/book_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDiscoverCubit, List<Book>>(
      builder: (contextDiscover, stateDiscover) {
        return BlocBuilder<FilterMarkCubit, FilterMarkState>(
          builder: (contextFilter, stateFilter) {
            return Scaffold(
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                  decoration: InputDecoration(
                                      helperText: '',
                                      hintText: 'Search',
                                      prefixIcon: const Icon(Icons.search),
                                      suffixIcon: Container(
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
                                              .lightBraunColor100,
                                        ),
                                        child: Center(
                                          child: IconButton(
                                              onPressed: () => print('all'),
                                              icon: const Icon(
                                                FontAwesomeIcons.list,
                                                color: Colors.white,
                                              )),
                                        ),
                                      )),
                                  onChanged: (text) {
                                    switch (stateFilter.filter) {
                                      case FilterMark.title:
                                        contextDiscover
                                            .read<BookDiscoverCubit>()
                                            .bookSearchByTitle(text);
                                        break;
                                      case FilterMark.author:
                                        contextDiscover
                                            .read<BookDiscoverCubit>()
                                            .bookSearchByAuthor(text);
                                        break;
                                    }
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: stateDiscover.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Book book = stateDiscover[index];
                                final String title = book.title;
                                final String authorName = book.authorName;
                                final String urlImage = book.photo;
                                return bookWidget(
                                    urlImage: urlImage,
                                    title: title,
                                    authorName: authorName,
                                    book: book);
                              }),
                        )
                      ]),
                ),
              ),
              backgroundColor:
                  AppColorThemeBraunBlack.of(context).whiteColorBackground,
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
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: const EdgeInsets.fromLTRB(
                      16.0, 5.0, 10.0, 5.0),
                  width: 190,
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
                      Placeholder(
                        fallbackHeight: 100,
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () => print('asd'),
                    color: AppColorThemeBraunBlack.of(context)
                        .blackColor40,
                    icon:
                    const Icon(FontAwesomeIcons.bookmark)
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

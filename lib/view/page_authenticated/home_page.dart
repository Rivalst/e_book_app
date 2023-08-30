import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/bloc/book_get_bloc/book_get_bloc.dart';
import 'package:e_book_app/controller/cubit/loaded_book/count_of_book_cubit.dart';
import 'package:e_book_app/controller/cubit/loaded_book/is_load_cubit.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller1 = ScrollController();
  final ScrollController _controller2 = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller1.addListener(() {
      if (_isControllerAtEnd(_controller1)) {
        context.read<CountOfBookCubit>().load();
      }
    });

    _controller2.addListener(() {
      if (_isControllerAtEnd(_controller2)) {
        context.read<CountOfBookCubit>().load();
      }
    });
  }

  bool _isControllerAtEnd(ScrollController controller) {
    final maxScrollExtent = controller.position.maxScrollExtent;
    final currentScrollPosition = controller.position.pixels;

    return currentScrollPosition >= maxScrollExtent;
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookGetBloc, BookGetState>(builder: (context, state) {
      final List<Book>? randomBook = state.randomListOfBooks();
      final List<Book>? booksAfter1800 = state.newestListOfBooks();

      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(17.0, 0, 17.0, 0),
          child: ListView.builder(
              primary: false,
              itemCount: 2, // Number of vertical grids
              itemBuilder: (BuildContext context, int indexVertical) {
                switch (indexVertical) {
                  case 0:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('For your attention',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                color: AppColorThemeBraunBlack.of(context)
                                    .blackColor40)),
                        SizedBox(
                            height: 460, // Adjust the height as needed
                            child: BlocBuilder<CountOfBookCubit, int>(
                              builder: (context, state) {
                                return randomBook == null
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color:
                                            AppColorThemeBraunBlack.of(context)
                                                .lightBraunColor100,
                                      ))
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state,
                                        controller: _controller1,
                                        itemBuilder: (BuildContext context,
                                            int indexHorizontal) {
                                          final Book book =
                                              randomBook[indexHorizontal];
                                          final String title =
                                              randomBook[indexHorizontal].title;
                                          final String authorName =
                                              randomBook[indexHorizontal]
                                                  .authorName;
                                          final String urlImage =
                                              randomBook[indexHorizontal].photo;

                                          return bookWidget(
                                              urlImage: urlImage,
                                              title: title,
                                              authorName: authorName);
                                        },
                                      );
                              },
                            )),
                      ],
                    );
                  case 1:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('After the 17th century',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                color: AppColorThemeBraunBlack.of(context)
                                    .blackColor40)),
                        SizedBox(
                          height: 460,
                          child: BlocBuilder<CountOfBookCubit, int>(
                            builder: (context, state) {
                              return booksAfter1800 == null
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: AppColorThemeBraunBlack.of(context)
                                          .lightBraunColor100,
                                    ))
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state,
                                      controller: _controller2,
                                      itemBuilder: (BuildContext context,
                                          int indexHorizontal) {
                                        final Book book =
                                            booksAfter1800[indexHorizontal];
                                        final String title =
                                            booksAfter1800[indexHorizontal]
                                                .title;
                                        final String authorName =
                                            booksAfter1800[indexHorizontal]
                                                .authorName;
                                        final String urlImage =
                                            booksAfter1800[indexHorizontal]
                                                .photo;
                                        return bookWidget(
                                            urlImage: urlImage,
                                            title: title,
                                            authorName: authorName);
                                      });
                            },
                          ),
                        ),
                      ],
                    );
                }
                return CircularProgressIndicator(
                    color:
                        AppColorThemeBraunBlack.of(context).lightBraunColor100);
              }),
        ),
        backgroundColor:
            AppColorThemeBraunBlack.of(context).whiteColorBackground,
      );
    });
  }

  Widget bookWidget(
      {required String urlImage,
      required String title,
      required String authorName}) {
    return BlocBuilder<IsLoadCubit, bool>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => BookDetailScreen(book)),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 25),
              child: Column(
                children: [
                  Card(
                    elevation: 7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          if (!state)
                            Center(
                                child: CircularProgressIndicator(
                              color: AppColorThemeBraunBlack.of(context)
                                  .lightBraunColor100,
                            )),
                          SizedBox(
                            height: 300,
                            width: 200,
                            child: Image.network(
                              urlImage,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  context.read<IsLoadCubit>().loaded();
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: AppColorThemeBraunBlack.of(context)
                                          .lightBraunColor100,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500,
                                color: AppColorThemeBraunBlack.of(context)
                                    .blackColor80)),
                        Text(authorName,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: AppColorThemeBraunBlack.of(context)
                                    .blackColor40)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

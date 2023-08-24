import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/bloc/book_get_bloc/book_get_bloc.dart';
import 'package:e_book_app/controller/cubit/count_of_loaded_book/count_of_book_cubit.dart';
import 'package:e_book_app/model/dataresources/remote/book_model.dart';
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
        body: ListView.builder(
            primary: false,
            itemCount: 2, // Number of vertical grids
            itemBuilder: (BuildContext context, int indexVertical) {
              switch (indexVertical) {
                case 0:
                  return SizedBox(
                      height: 450, // Adjust the height as needed
                      child: BlocBuilder<CountOfBookCubit, int>(
                        builder: (context, state) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state,
                            controller: _controller1,
                            itemBuilder:
                                (BuildContext context, int indexHorizontal) {
                              final String title =
                                  randomBook![indexHorizontal].title;
                              final String authorName =
                                  randomBook[indexHorizontal].authorName;
                              final String urlImage =
                                  randomBook[indexHorizontal].photo;

                              /// For after 1800
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => BookDetailScreen(book)),
                                    // );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 25),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 300,
                                          width: 200,
                                          child: Card(
                                            elevation: 7,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                urlImage,
                                                fit: BoxFit
                                                    .cover, // Ensure the image covers the available space
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(title,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColorThemeBraunBlack
                                                                  .of(context)
                                                              .blackColor80)),
                                              Text(authorName,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColorThemeBraunBlack
                                                                  .of(context)
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
                        },
                      ));
                case 1:
                  return SizedBox(
                    height: 450,
                    child: BlocBuilder<CountOfBookCubit, int>(
                      builder: (context, state) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state,
                            controller: _controller2,
                            itemBuilder:
                                (BuildContext context, int indexHorizontal) {
                              final String title =
                                  booksAfter1800![indexHorizontal].title;
                              final String authorName =
                                  booksAfter1800[indexHorizontal].authorName;
                              final String urlImage =
                                  booksAfter1800[indexHorizontal].photo;
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => BookDetailScreen(book)),
                                    // );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 25),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 300,
                                          width: 200,
                                          child: Card(
                                            elevation: 7,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                urlImage,
                                                fit: BoxFit
                                                    .cover, // Ensure the image covers the available space
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(title,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColorThemeBraunBlack
                                                                  .of(context)
                                                              .blackColor80)),
                                              Text(authorName,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColorThemeBraunBlack
                                                                  .of(context)
                                                              .blackColor40)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  );
              }
              return const CircularProgressIndicator();
            }),
        backgroundColor:
            AppColorThemeBraunBlack.of(context).whiteColorBackground,
      );
    });
  }
}

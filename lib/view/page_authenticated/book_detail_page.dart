import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/model/dataresources/books_library_set_or_remove.dart';
import 'package:e_book_app/controller/cubit/book_library/book_library_cubit.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:e_book_app/model/repositories/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({required this.book, Key? key}) : super(key: key);
  final Book book;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookLibraryCubit(
          id: widget.book.id,
          bookLibraryAddOrDelete: BookLibraryAddOrDelete(),
          booksRepository: BooksRepository.instance),
      child: BlocBuilder<BookLibraryCubit, bool>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor:
                  AppColorThemeBraunBlack.of(context).lightBraunColor10,
            ),
            body: ListView(
              children: [
                Stack(
                  children: [
                    const SizedBox(
                      height: 600,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        color: AppColorThemeBraunBlack.of(context)
                            .lightBraunColor10,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(17.0, 0, 17.0, 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        (MediaQuery.of(context).size.width -
                                                200) /
                                            2,
                                        0,
                                        0,
                                        0),
                                    child: SizedBox(
                                      height: 230,
                                      width: 160,
                                      child: Card(
                                        elevation: 7.0,
                                        child: Image.network(
                                          widget.book.photo,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () => print('asd'),
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
                                              .blackColor60,
                                          icon: const Icon(
                                              FontAwesomeIcons.download)),
                                      const SizedBox(height: 5),
                                      // IconButton(
                                      //     iconSize: 28.0,
                                      //     highlightColor: Colors.transparent,
                                      //     onPressed: () {
                                      //       if (state == false) {
                                      //         context
                                      //             .read<BookLibraryCubit>()
                                      //             .bookAddInCollection();
                                      //       } else {
                                      //         context
                                      //             .read<BookLibraryCubit>()
                                      //             .bookRemoveInLibrary();
                                      //       }
                                      //     },
                                      //     color: AppColorThemeBraunBlack.of(
                                      //             context)
                                      //         .blackColor40,
                                      //     icon: AnimatedSwitcher(
                                      //       duration: const Duration(
                                      //           milliseconds: 200),
                                      //       child: Icon(
                                      //         state == false
                                      //             ? Icons.bookmark_border
                                      //             : Icons.bookmark,
                                      //         color: state == false
                                      //             ? null
                                      //             : AppColorThemeBraunBlack.of(
                                      //                     context)
                                      //                 .lightBraunColor100,
                                      //         key:
                                      //             UniqueKey(), // важливо вказати ключ, щоб анімація працювала
                                      //       ),
                                      //     )),
                                      MyButton(
                                          contextBook: context,
                                          stateCheck: state)
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  widget.book.title,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.0,
                                      color: AppColorThemeBraunBlack.of(context)
                                          .blackColor80),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(widget.book.authorName,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColorThemeBraunBlack.of(context)
                                                .blackColor40)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 305,
                      left: (MediaQuery.of(context).size.width - 350) / 2,
                      child: SizedBox(
                        width: 350,
                        height: 65,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          surfaceTintColor: Colors.white,
                          shadowColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('272',
                                      style: TextStyle(
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
                                              .lightBraunColor100,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                  Text('Pages',
                                      style: TextStyle(
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
                                              .blackColor80,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(widget.book.language[0].toUpperCase(),
                                      style: TextStyle(
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
                                              .lightBraunColor100,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                  Text('Language',
                                      style: TextStyle(
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
                                              .blackColor80,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('***',
                                      style: TextStyle(
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
                                              .lightBraunColor100,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                  Text('Rating',
                                      style: TextStyle(
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
                                              .blackColor80,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            backgroundColor:
                AppColorThemeBraunBlack.of(context).whiteColorBackground,
          );
        },
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  final bool stateCheck;
  final BuildContext contextBook;

  const MyButton(
      {super.key, required this.contextBook, required this.stateCheck});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _buttonSize = 30.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _animation = Tween<double>(
      begin: _buttonSize,
      end: 40.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          _buttonSize = _animation.value;
        });
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
    if (widget.stateCheck == false) {
      widget.contextBook.read<BookLibraryCubit>().bookAddInCollection();
    } else {
      widget.contextBook.read<BookLibraryCubit>().bookRemoveInLibrary();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onTap: _onButtonPressed,
          child: Icon(
            widget.stateCheck == false ? Icons.bookmark_border : Icons.bookmark,
            size: _buttonSize,
            color: widget.stateCheck == false
                ? AppColorThemeBraunBlack.of(context).blackColor80
                : AppColorThemeBraunBlack.of(context).lightBraunColor100,
            key: UniqueKey(),
          )),
    );
  }
}

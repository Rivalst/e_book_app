import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/bloc/book_library_get/book_library_get_bloc.dart';
import 'package:e_book_app/model/dataresources/books_library_set_or_remove.dart';
import 'package:e_book_app/controller/cubit/book_library/book_library_cubit.dart';
import 'package:e_book_app/model/dataresources/book_model.dart';
import 'package:e_book_app/model/repositories/book_repository.dart';
import 'package:e_book_app/view/utils_widgets/button_bookmark_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({required this.book, Key? key}) : super(key: key);
  final Book book;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookLibraryCubit(
              id: widget.book.id,
              bookLibraryAddOrDelete: BookLibraryAddOrDelete(),
              booksRepository: BooksRepository.instance),
        ),
      ],
      child: BlocBuilder<BookLibraryGetBloc, BookLibraryGetState>(
        builder: (contextLibrary, stateLibrary) {
          return BlocBuilder<BookLibraryCubit, bool>(
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
                              padding:
                                  const EdgeInsets.fromLTRB(17.0, 0, 17.0, 25),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                                onTap: () => print('asd'),
                                                child: Icon(
                                                  Icons
                                                      .sim_card_download_rounded,
                                                  size: 30,
                                                  color: AppColorThemeBraunBlack
                                                          .of(context)
                                                      .blackColor80,
                                                )),
                                          ),
                                          const SizedBox(height: 5.0),
                                          MyButton(
                                              contextBook: contextLibrary,
                                              stateCheck: state),
                                          const SizedBox(height: 5.0),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkResponse(
                                              onTap: () {
                                                statusChanger(
                                                    contextBook: context);
                                              },
                                              child: Icon(
                                                Icons.pending,
                                                color:
                                                    AppColorThemeBraunBlack.of(
                                                            context)
                                                        .blackColor80,
                                                size: 28,
                                              ),
                                            ),
                                          )
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
                                          color: AppColorThemeBraunBlack.of(
                                                  context)
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
                                            color: AppColorThemeBraunBlack.of(
                                                    context)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                      Text(
                                          widget.book.language[0].toUpperCase(),
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
                        Positioned(
                            top: 380,
                            left: (MediaQuery.of(context).size.width - 350) / 2,
                            child: SizedBox(
                              height: 45,
                              width: 350,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WebViewApp(url: widget.book.text)),
                                  );
                                },
                                style: buttonStyle(),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sticky_note_2_outlined),
                                    SizedBox(width: 10),
                                    Text(
                                      'Read',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
                backgroundColor:
                    AppColorThemeBraunBlack.of(context).whiteColorBackground,
              );
            },
          );
        },
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            AppColorThemeBraunBlack.of(context).lightBraunColor100),
        foregroundColor: MaterialStateProperty.all<Color>(
            AppColorThemeBraunBlack.of(context).lightBraunColor10),
        overlayColor: MaterialStateProperty.all<Color>(
            AppColorThemeBraunBlack.of(context).lightBraunColor80),
        shadowColor: MaterialStateProperty.all<Color>(
            AppColorThemeBraunBlack.of(context).lightBraunColor100),
        surfaceTintColor: MaterialStateProperty.all<Color>(
            AppColorThemeBraunBlack.of(context).lightBraunColor100));
  }

  Future<dynamic> statusChanger({required BuildContext contextBook}) {
    String bookStatus = BooksRepository.instance.booksInLibraryMap
            .containsKey(widget.book.id.toString())
        ? BooksRepository.instance.booksInLibraryMap[widget.book.id.toString()]
            ['status']
        : '';
    return showDialog(
        context: contextBook,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor:
                AppColorThemeBraunBlack.of(context).whiteColorBackground,
            surfaceTintColor:
                AppColorThemeBraunBlack.of(context).whiteColorBackground,
            children: [
              TextButton(
                onPressed: () {
                  contextBook
                      .read<BookLibraryCubit>()
                      .bookAddInCollection(status: 'In reading');
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.in_reading,
                  style: TextStyle(
                      color: bookStatus == 'In reading'
                          ? AppColorThemeBraunBlack.of(context)
                              .lightBraunColor100
                          : AppColorThemeBraunBlack.of(context).blackColor60),
                ),
              ),
              TextButton(
                onPressed: () {
                  contextBook
                      .read<BookLibraryCubit>()
                      .bookAddInCollection(status: 'Will be read');
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.will_be_read,
                  style: TextStyle(
                      color: bookStatus == 'Will be read'
                          ? AppColorThemeBraunBlack.of(context)
                              .lightBraunColor100
                          : AppColorThemeBraunBlack.of(context).blackColor60),
                ),
              ),
              TextButton(
                onPressed: () {
                  contextBook
                      .read<BookLibraryCubit>()
                      .bookAddInCollection(status: 'Has been reading');
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.has_been_read,
                  style: TextStyle(
                      color: bookStatus == 'Has been reading'
                          ? AppColorThemeBraunBlack.of(context)
                              .lightBraunColor100
                          : AppColorThemeBraunBlack.of(context).blackColor60),
                ),
              ),
              TextButton(
                onPressed: () {
                  contextBook
                      .read<BookLibraryCubit>()
                      .bookAddInCollection(status: 'Likes');
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.likes,
                  style: TextStyle(
                      color: bookStatus == 'Likes'
                          ? AppColorThemeBraunBlack.of(context)
                              .lightBraunColor100
                          : AppColorThemeBraunBlack.of(context).blackColor60),
                ),
              ),
            ],
          );
        });
  }
}

class WebViewApp extends StatefulWidget {
  final String url;

  const WebViewApp({required this.url, super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
      ),
      body: WebViewStack(controller: controller),
    );
  }
}

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key}); // MODIFY

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}

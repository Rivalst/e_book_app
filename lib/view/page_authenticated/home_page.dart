import 'package:e_book_app/controller/bloc/book_get_bloc/book_get_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookGetBloc, Map<String, dynamic>?>(
      builder: (context, state) {
        return FutureBuilder<Map<String, dynamic>?>(
          future: BlocProvider.of<BookGetBloc>(context).mapEventToState('load'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text('Error'));
            } else {
              final data = snapshot.data!;
              return Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Popular'),
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> book = data['results'][index];
                          final String title = book['title'];
                          final String urlImage = book['formats']['image/jpeg'];

                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => BookDetailScreen(book)),
                              // );
                            },
                            child: Column(
                              children: [
                                Image.network(
                                  urlImage,
                                  fit: BoxFit
                                      .cover, // Ensure the image covers the available space
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    // Limit the number of lines for the title
                                    overflow: TextOverflow
                                        .ellipsis, // Show ellipsis (...) if text overflows
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2.5,
                          // You can adjust this ratio based on your needs
                          crossAxisSpacing: 50,
                          mainAxisSpacing: 50,
                        ),
                      ),
                    ),
                    Placeholder()
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}

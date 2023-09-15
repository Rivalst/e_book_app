import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/bloc/book_library_get/book_library_get_bloc.dart';
import 'package:e_book_app/controller/cubit/book_library/book_library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      widget.contextBook
          .read<BookLibraryGetBloc>()
          .add(const GetAllBookEvent());
    } else {
      widget.contextBook.read<BookLibraryCubit>().bookRemoveInLibrary();
      widget.contextBook
          .read<BookLibraryGetBloc>()
          .add(const GetAllBookEvent());
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

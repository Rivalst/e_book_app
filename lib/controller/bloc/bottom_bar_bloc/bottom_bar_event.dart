part of 'bottom_bar_bloc.dart';

@immutable
abstract class BottomBarEvent {
  const BottomBarEvent();
}


final class BottomBarSetIndex extends BottomBarEvent{
  const BottomBarSetIndex({required this.index});
  final int index;
}

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// part 'is_online_state.dart';
//
// class IsOnlineCubit extends Cubit<bool> {
//   IsOnlineCubit() : super(false) {
//     isConnection();
//   }
//
//   void isConnection() async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     print("Connectivity Result: $connectivityResult");
//     if (connectivityResult == ConnectivityResult.none) {
//       emit(false);
//     } else if (connectivityResult == ConnectivityResult.ethernet ||
//         connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi) {
//       emit(true);
//     } else {
//       emit(false);
//     }
//   }
// }

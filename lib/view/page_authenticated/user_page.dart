import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    final user = null;
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Avatar(photo: user.photo),
            // const SizedBox(height: 4),
            // Text(user.email ?? ''),
            // const SizedBox(height: 4),
            // Text(user.name ?? ''),
            const Text('User page')
          ],
        ),
      ),
    );
  }
}

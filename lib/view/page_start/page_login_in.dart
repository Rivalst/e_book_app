import 'package:authentication_repository/authentication_repository.dart';
import 'package:e_book_app/data/data_theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

import '../../cubit/login/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    final AppColorThemeBraunBlack theme = AppColorThemeBraunBlack();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(backgroundColor: theme.whiteColorBackground),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider<LoginCubit>(
            create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
            child: LoginForm(theme: theme),
          ),
        ),
        backgroundColor: theme.whiteColorBackground,
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({this.theme, Key? key}) : super(key: key);
  final AppColorThemeBraunBlack? theme;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content:
                      Text(state.errorMessage ?? 'Authentication Failuder')));
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Log in',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10.0),
              Text(
                'It\'s great to see you again! Please log in to continue reading',
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: theme!.blackColor40),
              ),
              const SizedBox(height: 30.0),
              const _EmailInput(),
              const _PasswordInput(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _GoogleLoginButton(theme: theme),
                    const SizedBox(height: 10.0),
                    const _LoginButton(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email address',
              helperText: '',
              errorText:
                  state.email.displayError != null ? 'invalid email' : null,
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              helperText: '',
              errorText: state.password.displayError != null
                  ? 'invalid password'
                  : null,
            ),
          );
        });
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton({this.theme, Key? key}) : super(key: key);
  final AppColorThemeBraunBlack? theme;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('loginForm_googleLogin_raisedButton'),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/google_logo.svg',
            height: 24,
            width: 24,
          ),
          Text(
            'SIGN IN WITH GOOGLE',
            style: TextStyle(color: theme!.blackColor40),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return state.status.isInProgress
          ? const CircularProgressIndicator()
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.isValid
                    ? () {
                        context
                            .read<LoginCubit>()
                            .logInWithCredentials()

                            /// .then used for bug when after log in user can't redirected to home page
                            .then((_) => Navigator.of(context).pop());
                      }
                    : null,
                child: const Text('LOGIN'),
              ),
            );
    });
  }
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:e_book_app/cubit/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../utilit_widgets/color_theme.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: SingUpPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColorThemeBraunBlack.of(context).whiteColorBackground),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
          child: const SingUpForm(),
        ),
      ),
      backgroundColor: AppColorThemeBraunBlack.of(context).whiteColorBackground,
    );
  }
}

class SingUpForm extends StatelessWidget {
  const SingUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: ListView(
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Welcome to word\'s of book. Sign up to start reading',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                  color: AppColorThemeBraunBlack.of(context).blackColor40),
            ),
            const SizedBox(height: 30.0),
            _EmailInput(),
            const SizedBox(height: 5.0),
            _NameInput(),
            const SizedBox(height: 5.0),
            _PasswordInput(),
            const SizedBox(height: 5.0),
            _ConfirmPasswordInput(),
            const SizedBox(height: 5.0),
            const Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _SignUpButton(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Your email',
            icon: const Icon(Icons.email),
            helperText: '',
            errorText:
                state.email.displayError != null ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.name != current.name,
        builder: (context, state) {
          return TextField(
            key: const Key('singUpForm_nameInput_textField'),
            onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Your name',
              icon: const Icon(Icons.person),
              helperText: '',
              errorText:
                  state.name.displayError != null ? 'invalid name' : null,
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            icon: const Icon(Icons.password),
            helperText: '',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'confirm password',
            icon: const Icon(Icons.lock),
            helperText: '',
            errorText: state.confirmedPassword.displayError != null
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? CircularProgressIndicator(
                color: AppColorThemeBraunBlack.of(context).lightBraunColor100,
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  key: const Key('signUpForm_continue_raisedButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor:
                        AppColorThemeBraunBlack.of(context).lightBraunColor100,
                  ),
                  onPressed: state.isValid
                      ? () {
                          context.read<SignUpCubit>().signUpFormSubmitted();
                        }
                      : null,
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: AppColorThemeBraunBlack.of(context)
                            .lightBraunColor10),
                  ),
                ),
              );
      },
    );
  }
}

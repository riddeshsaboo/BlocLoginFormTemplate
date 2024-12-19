import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_responsive_login_ui/bloc/auth_bloc.dart';
import 'package:flutter_responsive_login_ui/login_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // final authState = context.watch<AuthBloc>().state as AuthSuccess;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logged Out Successfully')));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          // print("LOADING ...");
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          body: Center(
            child: Column(children: [
              Text(
                  "This is the home Page and your UserID : ${(state as AuthSuccess).userId}"),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                  child: const Text("Log Out"))
            ]),
          ),
        );
      },
    );
  }
}

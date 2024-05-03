import 'package:application/bloc/login_bloc.dart';
import 'package:application/bloc/login_event.dart';
import 'package:application/bloc/login_state.dart';
import 'package:application/data/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(LoginService()),
        child: SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('error'),
            duration: Duration(seconds: 2),
          ));
        } else if (state is LoginSuccess) {
          final String token = state.user.token!;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NextScreen()),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authBloc.add(
                  LoginUser(
                    emailController.text,
                    passwordController.text,
                  ),
                );
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}

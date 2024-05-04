import 'package:application/bloc/login_bloc.dart';
import 'package:application/bloc/login_event.dart';
import 'package:application/bloc/login_state.dart';
import 'package:application/data/service/login_service.dart';
import 'package:application/screens/user_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(LoginService()),
        child: SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('error'),
            duration: Duration(seconds: 2),
          ));
        } else if (state is LoginSuccess) {
          final String token = state.user.token!;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserInformationScreen(
                      name:
                          '${state.user.userData!.firstname} ${state.user.userData!.lastname}',
                      role: state.user.roles?[0].name,
                    )),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Войдите в QAZAQMURA",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
              SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xff3062D4),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Политика конфиденциальности",
                        style: TextStyle(
                          color: Color(0xff3062D4),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  authBloc.add(
                      LoginUser(emailController.text, passwordController.text));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff3062D4),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 165, vertical: 16),
                    child: Text(
                      "Войти",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

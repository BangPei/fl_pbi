import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/screen/login/bloc/login_bloc.dart';
import 'package:fl_pbi/widget.dart/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SingleChildScrollView(child: LoginForm()));
  }
}

class LoginForm extends StatefulWidget {
  final String? message;
  const LoginForm({super.key, this.message});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  IconData iconData = Icons.visibility;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Common.imageLogo),
                scale: 1,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 218, 215, 215),
                  offset: Offset(0, 3),
                  blurRadius: 24,
                )
              ],
            ),
            height: 350,
            width: 350,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  const CustomText(
                    text: "Perniagaan Bumi Indah",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 5),
                  const CustomText(
                    text: "LOGIN",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (prev, curr) =>
                                prev.username != curr.username,
                            builder: (context, state) {
                              return TextFormField(
                                controller: _usernameController,
                                onChanged: (val) {
                                  context
                                      .read<LoginBloc>()
                                      .add(OnChangeUsername(val));
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Username Tidak Boleh Kosong";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username',
                                  icon: Icon(Icons.person),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (prev, curr) =>
                                prev.password != curr.password,
                            builder: (context, state) {
                              return TextFormField(
                                obscureText: obscureText,
                                controller: _passwordController,
                                onChanged: (val) {
                                  context
                                      .read<LoginBloc>()
                                      .add(OnChangePassword(val));
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password Tidak Boleh Kosong";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  icon: const Icon(Icons.lock_open),
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                        iconData = obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        iconData,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue[400]!,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                        return state.isLoading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              )
                            : TextButton(
                                onPressed: () {
                                  bool isValid =
                                      _formKey.currentState!.validate();
                                  if (isValid) {
                                    context
                                        .read<LoginBloc>()
                                        .add(OnLoginSubmit());
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: "LOGIN",
                                        size: 22,
                                        color: Colors.white,
                                        weight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      }),
                    ),
                  ),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    return Visibility(
                      visible: state.isError,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              state.errorMessage ?? "Server Error",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

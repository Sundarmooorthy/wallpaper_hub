import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/my_app_exports.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late SignInScreenCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    _cubit = BlocProvider.of<SignInScreenCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SignInScreenCubit, SignInScreenState>(
        listener: (context, state) {
          if (state is SignInLoading) {
            isLoading = true;
          }
          if (state is SignInSuccess) {
            isLoading = false;
          }
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.18),
                    brandName(fontSize: 38),
                    // Image.network(
                    //   "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
                    //   height: 100,
                    // ),
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Text(
                      "Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            textInputType: TextInputType.visiblePassword,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "This field cannot be empty";
                              }
                              return '';
                            },
                            hintText: 'Email',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: CustomTextField(
                              controller: _passwordController,
                              textInputType: TextInputType.visiblePassword,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "This field cannot be empty";
                                }
                                return '';
                              },
                              hintText: 'Password',
                            ),
                          ),
                          CommonElevatedButton(
                            onPressed: () async {
                              await _cubit.signIn(
                                _emailController.text,
                                _passwordController.text,
                                context,
                              );
                            },
                            width: double.infinity,
                            text: 'Sign In',
                          ),
                          const SizedBox(height: 16.0),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => SignUpScreenCubit(),
                                    child: SignUpScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Text.rich(
                              const TextSpan(
                                text: "Don’t have an account? ",
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

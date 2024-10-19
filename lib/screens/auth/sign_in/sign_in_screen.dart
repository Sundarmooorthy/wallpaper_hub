import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/screens/auth/forgot_password/forgot_password_cubit.dart';

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
  bool isOnBoardingDone = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    _cubit = BlocProvider.of<SignInScreenCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Text(
                      AppStrings.signIn,
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
                            hintText: AppStrings.email,
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
                              hintText: AppStrings.password,
                            ),
                          ),
                          CommonElevatedButton(
                            isLoading: isLoading,
                            onPressed: () async {
                              await _cubit.signIn(
                                _emailController.text,
                                _passwordController.text,
                                context,
                              );
                              setState(() {
                                isLoggedIn = true;
                              });
                              await AppStorage.setLoggedIn(isLoggedIn);
                              debugPrint('is Login Done ? <<<<<< $isLoggedIn');
                            },
                            width: double.infinity,
                            text: AppStrings.signIn,
                          ),
                          const SizedBox(height: 16.0),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          ForgotPasswordCubit(),
                                      child: ForgotPassword(),
                                    ),
                                  ));
                            },
                            child: Text(
                              AppStrings.forgotPassword,
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
                                text: AppStrings.dontHaveAccount,
                                children: [
                                  TextSpan(
                                    text: AppStrings.signIn,
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

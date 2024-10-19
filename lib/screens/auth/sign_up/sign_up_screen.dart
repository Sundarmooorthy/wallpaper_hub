import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/utils/utils_method.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpScreenCubit _cubit;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String selectedCity = '';
  bool isLoading = false;

  @override
  void initState() {
    _cubit = BlocProvider.of<SignUpScreenCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SignUpScreenCubit, SignUpScreenState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            isLoading = true;
          }
          if (state is SignUpSuccess) {
            isLoading = false;
            debugPrint("Name  <<<< ${_nameController.text}");
            debugPrint("Email <<< ${_emailController.text}");
            debugPrint("Password <<<< ${_passwordController.text}");
          }
        },
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
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
                  SizedBox(height: constraints.maxHeight * 0.08),
                  Text(
                    AppStrings.signUp,
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
                          hintText: AppStrings.name,
                          controller: _nameController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return '';
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          hintText: AppStrings.email,
                          controller: _emailController,
                          validator: (v) {
                            return UtilsMethod().emailValidator(v);
                          },
                          textInputType: TextInputType.emailAddress,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: CustomTextField(
                            hintText: AppStrings.password,
                            controller: _passwordController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return '';
                            },
                          ),
                        ),
                        /* DropdownButtonFormField(
                        items: countries,
                        icon: const Icon(Icons.expand_more),
                        onSaved: (country) {
                          // save it
                        },
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Country',
                          hintStyle: AppTextStyle.normal16(
                            color: Colors.grey.shade600,
                          ),
                          filled: true,
                          fillColor: Color(0xFFF5FCF9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0 * 1.5, vertical: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),*/
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: CommonElevatedButton(
                            isLoading: isLoading,
                            width: double.infinity,
                            text: AppStrings.signUp,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                              } else {
                                await _cubit.signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  context,
                                );
                                debugPrint("sign Up");
                              }
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => SignInScreenCubit(),
                                  child: SignInScreen(),
                                ),
                              ),
                            );
                          },
                          child: Text.rich(
                            const TextSpan(
                              text: AppStrings.alreadyHaveAccount,
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
          }),
        ),
      ),
    );
  }
}

// only for demo
List<DropdownMenuItem<String>>? countries = [
  "Bangladesh",
  "India",
  "Pakistan",
  "America",
  "UAE",
  "Europe",
  "Switzerland",
  'Canada',
  'Japan',
  'Germany',
  'Australia',
  'Sweden',
].map<DropdownMenuItem<String>>((String value) {
  return DropdownMenuItem<String>(value: value, child: Text(value));
}).toList();

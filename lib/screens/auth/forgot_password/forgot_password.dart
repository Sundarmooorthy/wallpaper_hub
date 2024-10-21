import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/screens/auth/forgot_password/forgot_password_cubit.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late ForgotPasswordCubit _cubit;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ForgotPasswordCubit>(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordLoading) {
            isLoading = true;
          }
          if (state is ForgotPasswordSuccess) {
            isLoading = false;
          }
        },
        child: LogoWithTitle(
          title: AppStrings.forgotPassword,
          subText: AppStrings.forgotPassDesc,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Form(
                key: _formKey,
                child: CustomTextField(
                  hintText: AppStrings.email,
                  controller: _emailController,
                  validator: (v) {
                    return UtilsMethod().emailValidator(v);
                  },
                ),
              ),
            ),
            CommonElevatedButton(
              isLoading: isLoading,
              width: double.infinity,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _cubit.forgotPassword(
                    _emailController.text,
                    context,
                  );
                }
              },
              text: AppStrings.verify,
            ),
          ],
        ),
      ),
    );
  }
}

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle(
      {super.key,
      required this.title,
      this.subText = '',
      required this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.2),
              brandName(fontSize: 38),
              SizedBox(
                height: constraints.maxHeight * 0.1,
                width: double.infinity,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  subText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.64),
                  ),
                ),
              ),
              ...children,
            ],
          ),
        );
      }),
    );
  }
}

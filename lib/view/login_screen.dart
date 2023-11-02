import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/bloc/auth/auth_bloc.dart';
import 'package:medicine_reminder/config/app_icon.dart';
import 'package:medicine_reminder/config/color_palette.dart';
import 'package:medicine_reminder/config/text_styles.dart';
import 'package:medicine_reminder/view/medication_tracker_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isHiddenPassword = true;

  void onGoogleClick() {
    BlocProvider.of<AuthBloc>(context).add(SignInEvent());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onTogglePasswordVisible() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromRGBO(102, 102, 102, 0.08),
          ),
        ),
        backgroundColor: ColorPalette.white,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: ColorPalette.grayDark,
            size: 24,
          ),
          onPressed: () {},
        ),
        title: const Text(
          'Sign In Screen',
          style: TextStyles.semiBold,
        ),
        centerTitle: true,
      ),
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const MedicationTrackerScreen()));
            } else if (state.status == AuthStatus.unauthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sign In Failure")));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.blueBase,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Login to keep exploring amazing destinations around the world!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: ColorPalette.grayDark,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required!";
                      }
                      if (!RegExp(r"^[a-zA-Z\d.]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "email invalid!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                      hintText: "Enter email or username",
                      hintStyle: TextStyle(
                        color: ColorPalette.grayDark.withOpacity(0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        borderSide: BorderSide(
                          color: ColorPalette.grayDark,
                          width: 1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        borderSide: BorderSide(
                          color: ColorPalette.grayDark,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: ColorPalette.grayDark,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isHiddenPassword,
                    obscuringCharacter: '*',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required!";
                      }
                      if (value.length < 6) {
                        return "password must from 6 chars!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                      hintText: "Enter password",
                      hintStyle: TextStyle(
                        color: ColorPalette.grayDark.withOpacity(0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHiddenPassword = !isHiddenPassword;
                          });
                        },
                        icon: isHiddenPassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        borderSide: BorderSide(
                          color: ColorPalette.grayDark,
                          width: 1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        borderSide: BorderSide(
                          color: ColorPalette.grayDark,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: ColorPalette.grayDark,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 20),
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorPalette.blueBase,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                  const Text(
                    'or social login',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildSocialButton(
                        image: AppIcons.google,
                        onPressed: onGoogleClick,
                      ),
                      const SizedBox(width: 24),
                      buildSocialButton(
                        image: AppIcons.facebook,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 24),
                      buildSocialButton(
                        image: AppIcons.apple,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: ColorPalette.grayDark,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Register an account',
                          style: const TextStyle(
                            color: ColorPalette.blueBase,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: ColorPalette.grayDark,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: "Forgot password? "),
                        TextSpan(
                          text: 'Reset password',
                          style: const TextStyle(
                            color: ColorPalette.blueBase,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {},
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
    );
  }
  Widget buildSocialButton({
    required String image,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      iconSize: 24,
      onPressed: onPressed,
      icon: Image.asset(
        image,
        height: 48,
        width: 48,
      ),
    );
  }

}

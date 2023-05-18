import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/utils/extensions.dart';
import 'package:recipe_app/view_models/login_view_model.dart';
import 'package:recipe_app/widgets/action_button.dart';
import 'package:recipe_app/widgets/input_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewProvider);

    /// Listens to the current status of state
    ref.listen(
      loginViewProvider,
      (_, state) => state.whenOrNull(
        data: (_) {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          Navigator.pushNamed(context, '/home');
        },
        error: (_, __) => state.showBannerOnError(context),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'Enter Email Address',
                    leadingIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.isValidEmail()) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InputField(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter Password',
                    leadingIcon: Icons.lock_outline,
                    isObscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 5) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ActionButton(
                    label: 'Login',
                    isLoading: state.isLoading,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await ref.read(loginViewProvider.notifier).login(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

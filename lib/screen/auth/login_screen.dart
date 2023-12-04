import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/local/model/auth/login/login_request.dart';
import 'package:story_app/provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  final Function() toRegisterScreen;
  final Function() onLogin;
  const LoginScreen(
      {Key? key, required this.toRegisterScreen, required this.onLogin})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/story-app.png',
                color: const Color(0xFFB3005E),
                width: 24,
                height: 24,
              ),
              const SizedBox(
                height: 24,
                width: 8,
              ),
              const Text(
                'Story App',
                style: TextStyle(
                    color: Color(0xFFB3005E),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFFB3005E),
                        ),
                        labelText: 'Email...',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan alamat email';
                        }
                        final emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Alamat email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFFB3005E),
                        ),
                        labelText: 'Password...',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan password';
                        }
                        if (value.length < 8) {
                          return 'Password harus memiliki minimal 8 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    context.watch<AuthProvider>().isLoadingLogin
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final scaffoldMessenger =
                                    ScaffoldMessenger.of(context);
                                final request = LoginRequest(
                                    email: emailController.text,
                                    password: passwordController.text);

                                final authRead = context.read<AuthProvider>();

                                final login = await authRead.login(request);
                                if (login) {
                                  scaffoldMessenger.showSnackBar(const SnackBar(
                                      content: Text('login berhasil')));
                                  widget.onLogin();
                                } else {
                                  scaffoldMessenger.showSnackBar(const SnackBar(
                                      content: Text('Login Gagal')));
                                }
                              }
                            },
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: 60,
                              child: const Center(
                                child: Text("LOGIN"),
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Belum punya akun?'),
                        TextButton(
                          onPressed: () {
                            widget.toRegisterScreen();
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

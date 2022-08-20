import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailEditingControllrt = TextEditingController();
  final TextEditingController _passwordEditingControllrt =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                const Text(
                  "TikTok Clone",
                  style: TextStyle(
                    fontSize: 35,
                    color: Color.fromRGBO(233, 51, 83, 1),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const Text(
              "Log in",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                icon: Icons.email,
                lable: 'Email',
                textEditingController: _emailEditingControllrt,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                icon: Icons.lock,
                lable: 'Password',
                textEditingController: _passwordEditingControllrt,
                isObscure: true,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => authController.loginUser(
                  _emailEditingControllrt.text,
                  _passwordEditingControllrt.text,
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account? ',
                    style: TextStyle(fontSize: 15)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Register Now',
                    style: TextStyle(fontSize: 15, color: buttonColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

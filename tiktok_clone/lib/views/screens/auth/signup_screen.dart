import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController _emailEditingControllrt = TextEditingController();
  final TextEditingController _passwordEditingControllrt =
      TextEditingController();
  final TextEditingController _usernameEditingController =
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
                Text(
                  "TikTok Clone",
                  style: TextStyle(
                    fontSize: 35,
                    color: buttonColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 25),
            Stack(
              children: [
                Positioned(
                  bottom: -14,
                  left: 92,
                  child: IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () => authController.pickImage(),
                  ),
                ),
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1'),
                  backgroundColor: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                icon: Icons.person,
                lable: 'Username',
                textEditingController: _usernameEditingController,
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
                onTap: () => authController.registerUser(
                    _usernameEditingController.text,
                    _emailEditingControllrt.text,
                    _passwordEditingControllrt.text,
                    authController.profilePic),
                child: const Text(
                  'Register',
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
                const Text('Allready have an account ? ',
                    style: TextStyle(fontSize: 15)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Log in',
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:im_chat_app/widgets/picker/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this._isLoading);
  final bool _isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please pick an image',
            style: TextStyle(
              color: Theme.of(context).errorColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(192, 255, 228, 228),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState?.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.pink],
          tileMode: TileMode.clamp,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Center(
        child: Card(
          color: const Color.fromARGB(192, 255, 228, 228),
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) UserImagePicker(_pickedImage),
                    TextFormField(
                      key: const ValueKey('email'),
                      validator: ((value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      }),
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('username'),
                        validator: ((value) {
                          if (value!.isEmpty || value.length <= 4) {
                            return 'Please enter a valid Username.';
                          }
                          return null;
                        }),
                        onSaved: (value) {
                          _userName = value!;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person_outlined),
                        ),
                      ),
                    TextFormField(
                      key: const ValueKey('password'),
                      keyboardType: TextInputType.visiblePassword,
                      validator: ((value) {
                        if (value!.isEmpty || value.length <= 7) {
                          return 'Password must be at least 8 characters.';
                        }
                        return null;
                      }),
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (widget._isLoading) const CircularProgressIndicator(),
                    if (!widget._isLoading)
                      ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                      ),
                    if (!widget._isLoading)
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateColor.resolveWith(
                              (_) => Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

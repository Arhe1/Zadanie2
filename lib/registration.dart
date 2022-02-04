import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _returnpasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _returnpasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Форма регистрации',
              style: TextStyle(
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.people),
                labelText: 'Имя',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black38, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? val) =>
                  val!.isEmpty ? 'Необходимо заполнить поле Name' : null,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _loginController,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone_android),
                labelText: 'Телефон',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black38, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? val) =>
                  val!.isEmpty ? 'Необходимо заполнить поле Телефон' : null,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePass,
              maxLength: 4,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black38, width: 2)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black87, width: 2)),
                icon: Icon(Icons.password_sharp),
                labelText: 'Пароль',
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
              ),
              validator: _vall,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _returnpasswordController,
              obscureText: _hidePass,
              maxLength: 4,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black38, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black87, width: 2)),
                icon: Icon(Icons.password_sharp),
                labelText: 'Повторите пароль',
              ),
              validator: _vall,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _validation();
                  }
                },
                child: const Text('Зарегистрироваться')),
            const SizedBox(
              height: 60,
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () => exit(0),
              child: const Text('Закрыть'),
            )
          ],
        ),
      ),
    );
  }

  String? _vall(String? value) {
    if (_passwordController.text.length != 4) {
      return 'Пароль должен состоять из 4 символов';
    } else if (_passwordController.text != _returnpasswordController.text) {
      return 'Пароли не совпадают';
    } else {
      return null;
    }
  }

  void _validation() async {
    final prefs = await SharedPreferences.getInstance();
    var _summ = _loginController.text + _passwordController.text;
    prefs.setInt('password', _passwordController.text.hashCode);
    prefs.setInt('login', _summ.hashCode);
    prefs.setString('name', _nameController.text);
    _showDialogRegistration(prefs: prefs);
  }

  Future<void> _showDialogRegistration({prefs}) async {
    var name = prefs.getString('name');
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Подздравляем $name'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Регистрация пройдена.'),
                Text('Вы можите продолжить использовать приложение'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Продолжить'),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            TextButton(
              child: const Text('Закрыть'),
              onPressed: () => exit(0),
            ),
          ],
        );
      },
    );
  }
}

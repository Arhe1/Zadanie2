import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Pagesauthorization extends StatefulWidget {
  Pagesauthorization({Key? key}) : super(key: key);

  @override
  _PagesauthorizationState createState() => _PagesauthorizationState();
}

class _PagesauthorizationState extends State<Pagesauthorization> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginForm(),

    );
  }

  void _validation() async {
    final prefs = await SharedPreferences.getInstance();
    var _summ = _loginController.text + _passwordController.text;
    //int password=
    if (prefs.getInt('password') == _passwordController.text.hashCode) {
      if (_summ.hashCode == prefs.getInt('login')) {
        Navigator.pushNamed(context, '/ counter');
      }
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Извините!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Вы ввели неверные данные'),
                  Text('Вы можите заного зарегистрироваться'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Регистрация'),
                onPressed: () {
                  Navigator.pushNamed(context, '/ registration');
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

  Widget _LoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              ' Cотрудники',
              style: TextStyle(
                fontSize: 56,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _loginController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Телефон',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.black38, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.black54, width: 2)),
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? val) =>
                  val!.isEmpty ? 'Необходимо заполнить поле Телефон' : null,
            ),
            SizedBox(
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
                icon: Icon(Icons.security),
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
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  _validation();
                },
                child: const Text('Войти'),
              style: ElevatedButton.styleFrom(primary: Color(0xFF0079D0),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(36.0),
),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/ registration');
              },
              child: const Text('Регистрация'),
            )
          ],
        ),
      ),
    );
  }
}


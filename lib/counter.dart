import 'dart:convert';
//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'user_id.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late Future<List<User>> userlist;
  @override
  void initState() {
    super.initState();
    userlist = getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drooo(),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            tooltip: 'Предыдущая страница',
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text('Список сотрудников'),
      ),
      body: FutureBuilder<List<User>>(
        future: userlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text ('Имя: ${snapshot.data![index].name}', style: TextStyle(fontSize: 20,color: Colors.blue[500])),
                      subtitle: Text('Email: ${snapshot.data![index].email}',style: TextStyle(fontSize: 15, color: Colors.black)),
                      leading: Text('ID: ${snapshot.data![index].id}'),
                      onTap: () async {
                        UserID uid = UserID(
                            snapshot.data![index].id,
                            '${snapshot.data![index].name}',
                            '${snapshot.data![index].username}',
                            '${snapshot.data![index].email}',
                            '${snapshot.data![index].address!.street}',
                            '${snapshot.data![index].address!.suite}',
                            '${snapshot.data![index].address!.city}',
                            '${snapshot.data![index].address!.zipcode}',
                            '${snapshot.data![index].address!.geo!.lat}',
                            '${snapshot.data![index].address!.geo!.lng}',
                            '${snapshot.data![index].phone}',
                            '${snapshot.data![index].website}',
                            '${snapshot.data![index].company!.name}',
                            '${snapshot.data![index].company!.catchPhrase}',
                            '${snapshot.data![index].company!.bs}');
                        Navigator.pushNamed(context, '/ infoUser',
                            arguments: uid);
                      },
                    ),
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<User>> getUserList() async {
    List<User> prodList = [];
    const url = 'https://jsonplaceholder.typicode.com/users';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      for (var prod in jsonList) {
        prodList.add(User.fromJson(prod));
      }
      return prodList;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}

class Drooo extends StatelessWidget {
  const Drooo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: FlutterLogo(
              size: 80,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.engineering,
              color: Colors.blue,
            ),
            title: Text('Инженеры'),
            onTap: () {},
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.developer_board,
              color: Colors.blueAccent,
            ),
            title: Text('Разработчики'),
            onTap: () {},
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.qr_code,
              color: Colors.blue,
            ),
            title: Text('Тестировщики'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

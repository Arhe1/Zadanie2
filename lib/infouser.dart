import 'dart:convert';
//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'check.dart';
import 'counter.dart';
import 'user_id.dart';

// ignore: use_key_in_widget_constructors
class InfoUser extends StatelessWidget {
  late final UserID uid;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    uid = settings.arguments as UserID;

    // checklist.
    //if (id == checklist){}
    return Scaffold(
      drawer: const Drooo(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            tooltip: 'Go to the next page',
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text('Сотрудник'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя: ${uid.name}', style: TextStyle(fontSize: 15, color: Colors.black)),
            Text('Логин: ${uid.username}',style: TextStyle(fontSize: 15, color: Colors.black)),
            Text('Почта: ${uid.email}',style: TextStyle(fontSize: 15, color: Colors.black)),
            Text('Телефон: ${uid.phone}',style: TextStyle(fontSize: 15, color: Colors.black)),
            Text(
                'Адрес: индекс:${uid.zipcode} г.${uid.city}, ул. ${uid.street}, ст.${uid.suite}, ', style: TextStyle(fontSize: 15, color: Colors.black)),
            // Text('координаты: ${uid.lat}'),
            Text('website: ${uid.website}', style: TextStyle(fontSize: 15, color: Colors.black)),
            Text('Место работы: ${uid.cname}', style: TextStyle(fontSize: 15, color: Colors.black)),
            Text('Лозунг компании: ${uid.catchPhrase}', style: TextStyle(fontSize: 15, color: Colors.black)),
            Text('Сфера деятельности: ${uid.bs}', style: TextStyle(fontSize: 15, color: Colors.black)),
            Center(child: const Text('Поставленные задачи:', style: TextStyle(fontSize: 20),)),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CheksID('${uid.id}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheksID extends StatefulWidget {
  final String _id;
  const CheksID(this._id, {Key? key}) : super(key: key);
  @override
  _CheksIDState createState() => _CheksIDState();
}

class _CheksIDState extends State<CheksID> {
  late Future<List<Check>> checklist;
  @override
  void initState() {
    super.initState();
    String id = widget._id;
    checklist = getCheckList(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Check>>(
      future: checklist,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var fix = snapshot.data![index].completed as bool;
              return Card(
                color: fix ? Colors.green : Colors.blueAccent,
                child: ListTile(
                  title: Text(
                      'Поставленная задача: ${snapshot.data![index].title}'),
                  subtitle: Row(
                    children: [
                      const Text('Задача выполнена? '),
                      Checkbox(value: fix, onChanged: null)
                    ],
                  ),
                  leading: Text('№: ${index + 1}'),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<Check>> getCheckList(String id) async {
    List<Check> prodList = [];
    String url = 'https://jsonplaceholder.typicode.com/todos?userId=$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      for (var prod in jsonList) {
        prodList.add(Check.fromJson(prod));
      }
      return prodList;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}

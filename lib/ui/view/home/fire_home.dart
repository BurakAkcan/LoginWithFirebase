import 'package:firebasetry/core/service/firebase_service.dart';
import 'package:flutter/material.dart';

import '../../../core/models/student_model.dart';

class FireHomeView extends StatefulWidget {
  const FireHomeView({Key? key}) : super(key: key);

  @override
  _FireHomeViewState createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<FireHomeView> {
  late FirebaseService service;
  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: service.getStudent(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Student>?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return _listUser(snapshot.data!);
              }
              break;
            default:
              return getCircelar();
          }
          return getCenter();
        },
      ),
    );
  }

  Widget _listUser(List<Student> liste) {
    return ListView.builder(
      itemCount: liste.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text((liste[index].name)),
          ),
        );
      },
    );
  }

  Widget getCenter() => const Center(
        child: Text('Hata'),
      );
  Widget getCircelar() => const Center(
        child: CircularProgressIndicator(),
      );
}

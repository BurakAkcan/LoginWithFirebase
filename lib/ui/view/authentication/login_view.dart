import 'package:firebasetry/core/models/user_request.dart';
import 'package:firebasetry/core/service/fire_auth.dart';
import 'package:firebasetry/core/service/firebase_service.dart';
import 'package:firebasetry/core/service/google_signin.dart';
import 'package:firebasetry/ui/view/home/fire_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;
  String? password;
  FirebaseService service = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.grey.shade700,
          ),
          onPressed: () async {
            await GoogleHelper.instance.googleSignOut();
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(height: 60, child: Text('Çıkış yapıldı'));
              },
            );
          },
        )
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userNameTextField(),
                const SizedBox(
                  height: 20,
                ),
                passwordTextField(),
                InkWell(
                  onTap: () async {},
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/images/google.png'),
                        Text(
                          'Google Giriş',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    primary: Colors.yellow,
                    onPrimary: Color.fromARGB(255, 33, 24, 88),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  icon: FaIcon(FontAwesomeIcons.google),
                  label: Text(
                    'Gogle Giriş',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onPressed: () async {
                    await MyAuthServices.instance.signWithGoogle();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await MyAuthServices.instance.registerWithEmail(
              context: context, mail: email!, password: password!);
        },
        child: const Icon(
          Icons.verified_user,
          size: 40,
        ),
      ),
    );
  }

  TextField passwordTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {});
        password = value;
      },
      decoration: InputDecoration(
          labelText: 'password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
    );
  }

  TextField userNameTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {});
        email = value;
      },
      decoration: InputDecoration(
          labelText: 'email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
    );
  }
}

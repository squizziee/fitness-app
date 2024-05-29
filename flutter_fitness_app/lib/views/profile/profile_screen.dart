import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/services/notfication_service.dart';
import 'package:flutter_fitness_app/services/user_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Widget _field(String text, String placeholder, TextEditingController controller,
    TextInputType type) {
  controller.text = text;
  return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: placeholder,
        contentPadding:
            const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
        filled: true,
        fillColor: const Color.fromARGB(31, 180, 180, 180),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
      ));
}

Widget _removeAllRegimentsButton(
    BuildContext context, UserService userService) {
  return GestureDetector(
    onTap: () => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Confirmation'),
              content: const Text(
                  "Are you sure you want to delete all your regiments?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      await userService
                          .removeAllUserRegiments(context)
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: const Text(
                      'Proceed',
                      style: TextStyle(color: Colors.redAccent),
                    )),
              ],
            )),
    child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: const Text("Delete all regiments")),
  );
}

Widget _removeAllGoalsButton(BuildContext context, UserService userService) {
  return GestureDetector(
    onTap: () => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Confirmation'),
              content:
                  const Text("Are you sure you want to delete all your goals?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      await userService
                          .removeAllUserGoals(context)
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: const Text(
                      'Proceed',
                      style: TextStyle(color: Colors.redAccent),
                    )),
              ],
            )),
    child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: const Text("Delete all Goals")),
  );
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Auth _authService = Auth();
  final UserService _userService = UserService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void _clearControllers() {
    _emailController.text = "";
    _passwordController.text = "";
    _newPasswordController.text = "";
  }

  Widget _changeEmailButton(BuildContext context, Auth authService) {
    return GestureDetector(
      onTap: () => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Confirmation'),
                content: Column(
                  children: [
                    _field(authService.currentUser!.email.toString(), "Email",
                        _emailController, TextInputType.emailAddress),
                    const SizedBox(
                      height: 10,
                    ),
                    _field("", "Confirm with password", _passwordController,
                        TextInputType.visiblePassword),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        var credential = EmailAuthProvider.credential(
                            email: authService.currentUser!.email!,
                            password: _passwordController.text);
                        await authService.currentUser!
                            .reauthenticateWithCredential(credential)
                            .then((value) async => await authService
                                .currentUser!
                                .updateEmail(_emailController.text)
                                .then((value) => Navigator.of(context).pop()));
                        _clearControllers();
                        setState(() {});
                      },
                      child: const Text(
                        'Proceed',
                        style: TextStyle(color: Colors.redAccent),
                      )),
                ],
              )),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: const Text("Change email")),
    );
  }

  Widget _changePasswordButton(BuildContext context, Auth authService) {
    return GestureDetector(
      onTap: () => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Confirmation'),
                content: Column(
                  children: [
                    _field("", "Old Password", _passwordController,
                        TextInputType.visiblePassword),
                    const SizedBox(
                      height: 10,
                    ),
                    _field("", "New Password", _newPasswordController,
                        TextInputType.visiblePassword),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        var credential = EmailAuthProvider.credential(
                            email: authService.currentUser!.email!,
                            password: _passwordController.text);
                        await authService.currentUser!
                            .reauthenticateWithCredential(credential)
                            .then((value) async => await authService
                                .currentUser!
                                .updatePassword(_newPasswordController.text)
                                .then((value) => Navigator.of(context).pop()));

                        _clearControllers();
                      },
                      child: const Text(
                        'Proceed',
                        style: TextStyle(color: Colors.redAccent),
                      )),
                ],
              )),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: const Text("Change password")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text("${_authService.currentUser!.email}"),
                ElevatedButton(
                    onPressed: () async {
                      await _authService.signOut();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.doorOpen,
                      size: 15,
                    )),
              ]),
        ),
        _removeAllRegimentsButton(context, _userService),
        _removeAllGoalsButton(context, _userService),
        _changeEmailButton(context, _authService),
        _changePasswordButton(context, _authService),
        ElevatedButton(
            onPressed: () async {
              await NotificationService().showNotification(
                title: 'Non-scheduled Notification',
                body: 'huh?',
              );
            },
            child: const Text("Test instant notification")),
        ElevatedButton(
            onPressed: () async {
              await NotificationService().scheduleNotification(
                  title: 'Scheduled Notification',
                  body: 'huh?',
                  scheduledNotificationDateTime:
                      DateTime.now().add(const Duration(seconds: 5)));
            },
            child: const Text("Test notification"))
      ]),
    ));
  }
}

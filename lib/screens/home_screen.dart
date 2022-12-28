import 'package:flutter/material.dart';
import 'package:ieee_forms/services/user.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My forms'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: MyUser.currentUser.forms.length,
            itemBuilder: (context, index) {

            return Center(child: Text('$index'));
            }),
      ),
    );
  }
}

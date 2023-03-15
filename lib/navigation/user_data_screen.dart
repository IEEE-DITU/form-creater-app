import 'package:flutter/material.dart';
import 'package:ieee_forms/navigation/home_screen.dart';
import 'package:ieee_forms/services/user.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  bool isProcessing = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    await MyUser.getCurrentUser();
    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isProcessing) ? const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) : const HomeScreen();
  }
}

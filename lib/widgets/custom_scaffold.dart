import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {Key? key, this.appBar, required this.child, this.floatingActionButton, this.resize})
      : super(key: key);
  final PreferredSizeWidget? appBar;
  final Widget child;
  final Widget? floatingActionButton;
  final bool? resize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: resize ?? false,
        floatingActionButton: floatingActionButton,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/Background.png'),
                    fit: BoxFit.cover)),
            child: child,
          ),
        ));
  }
}

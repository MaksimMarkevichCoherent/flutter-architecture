import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LoginFlow extends StatelessWidget {
  static const purpose = 'login';

  const LoginFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const AutoRouter();
}

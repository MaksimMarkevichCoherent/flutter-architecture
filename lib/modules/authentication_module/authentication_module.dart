import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AuthenticationModule extends StatefulWidget {
  const AuthenticationModule({Key? key}) : super(key: key);

  @override
  State<AuthenticationModule> createState() => _AuthenticationModuleState();
}

class _AuthenticationModuleState extends State<AuthenticationModule> {
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

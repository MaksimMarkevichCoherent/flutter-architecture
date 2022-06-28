import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_manager.dart';
import '../core/cubit/connectivity_manager/connectivity_cubit.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({required this.child, Key? key}) : super(key: key);

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animatable<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 1),
    ).chain(
      CurveTween(curve: Curves.fastOutSlowIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        widget.child,
        BlocConsumer<ConnectivityCubit, ConnectivityState>(
          listener: (context, state) {
            if (state.connected) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          },
          builder: (context, state) {
            return Align(
              alignment: Alignment.topCenter,
              child: SlideTransition(
                position: _animationController.drive(_offsetAnimation),
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().statusBarHeight,
                  color: theme.colorScheme.error,
                  child: Text(
                    tr.errorInternetConnection,
                    style: theme.textTheme.bodyText1!.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

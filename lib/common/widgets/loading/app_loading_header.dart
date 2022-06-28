import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppLoadingHeader extends StatefulWidget {
  final bool hasLoadingIndicator;

  const AppLoadingHeader({
    this.hasLoadingIndicator = true,
    Key? key,
  }) : super(key: key);

  @override
  _AppLoadingHeaderState createState() => _AppLoadingHeaderState();
}

class _AppLoadingHeaderState extends State<AppLoadingHeader> {
  double? _offset;

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      refreshStyle: RefreshStyle.UnFollow,
      height: 30.w,
      builder: (BuildContext context, RefreshStatus? mode) {
        return widget.hasLoadingIndicator
            ? Container(
                height: 30.w,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 24.w,
                  width: 24.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    value: _offset,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

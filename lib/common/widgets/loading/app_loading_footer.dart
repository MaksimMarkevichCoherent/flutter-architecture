import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppLoadingFooter extends StatefulWidget {
  const AppLoadingFooter({Key? key}) : super(key: key);

  @override
  _AppLoadingFooterState createState() => _AppLoadingFooterState();
}

class _AppLoadingFooterState extends State<AppLoadingFooter> {
  double? _offset;

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      height: 30,
      builder: (BuildContext context, LoadStatus? mode) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w),
          child: Container(
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
          ),
        );
      },
    );
  }
}

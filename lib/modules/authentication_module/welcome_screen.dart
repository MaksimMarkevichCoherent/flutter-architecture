import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

import '../../common/core/app_manager.dart';
import '../../common/core/utils/translate_extension.dart';
import '../../common/widgets/app_screen_wrapper.dart';
import '../../common/widgets/buttons/app_button.dart';
import '../../resources/theme/app_typography.dart';
import '../../resources/theme/custom_color_scheme.dart';
import '../../router.gr.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    tr = AppLocalizations.of(context)!;

    return AppScreenWrapper(
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Column(
        children: <Widget>[
          SizedBox(height: 41.w),
          // TODO(anybody): add logo
          // Image.asset(
          //   AppImages.logoBlue,
          //   width: 230.w,
          // ),
          Expanded(
            child: PageView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int index) {
                _currentPageNotifier.value = index;
              },
              children: [
                PageContentWidget(
                  title: context.tr.welcomeTitle,
                  subTitle: context.tr.welcomeSubTitle,
                ),
                PageContentWidget(
                  title: context.tr.welcomeTitle2,
                  subTitle: context.tr.welcomeSubTitle2,
                ),
              ],
            ),
          ),
          CirclePageIndicator(
            itemCount: 2,
            dotColor: theme.colorScheme.border,
            dotSpacing: 12.w,
            size: 5.w,
            selectedSize: 8.w,
            selectedDotColor: theme.colorScheme.primary,
            currentPageNotifier: _currentPageNotifier,
          ),
          SizedBox(height: 24.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                AppButton(
                  key: const ValueKey('SignInButton'),
                  titleText: context.tr.signIn,
                  onPressed: () {
                    context.router.push(const LoginFlow());
                  },
                ),
                SizedBox(height: 20.w),
                AppButton(
                  key: const ValueKey('SignUpButton'),
                  titleText: context.tr.signUp,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  textColor: theme.colorScheme.primaryText,
                  onPressed: () {
                    context.router.push(const OnboardingFlow());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@visibleForTesting
class PageContentWidget extends StatelessWidget {
  const PageContentWidget({
    required this.title,
    required this.subTitle,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 48.w),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.m24,
          ),
        ),
        SizedBox(height: 16.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 48.w),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.r16.copyWith(color: theme.colorScheme.secondaryText),
          ),
        ),
      ],
    );
  }
}

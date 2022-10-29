import 'package:flutter/material.dart';

import '../utils/theme_util.dart';

class FullScreenInfo extends StatelessWidget {
  final IconData iconName;
  final String title;
  final String subTitle;

  const FullScreenInfo(
      {Key? key,
      required this.iconName,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: null,
            icon: Icon(
              iconName,
              size: 64.0,
            ),
            color: ThemeUtil.primaryColor,
            disabledColor: ThemeUtil.primaryColor,
          ),
          const SizedBox(
            height: 48.0,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}

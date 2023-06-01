import 'package:flutter/material.dart';

import '../../const/app.dart';
import '../../utils/link_text_span.dart';

/// An about icon button used on the example's app app bar.
class AboutIconButton extends StatelessWidget {
  const AboutIconButton({super.key, this.color, this.useRootNavigator = true});

  /// The color used on the icon button.
  ///
  /// If null, default to Icon() class default color.
  final Color? color;

  /// Use root navigator?
  final bool useRootNavigator;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info, color: color),
      onPressed: () {
        showAppAboutDialog(context, useRootNavigator);
      },
    );
  }
}

// This [showAppAboutDialog] function is based on the [AboutDialog] example
// that exist(ed) in the Flutter Gallery App.
void showAppAboutDialog(BuildContext context, [bool useRootNavigator = true]) {
  final ThemeData theme = Theme.of(context);
  final TextStyle aboutTextStyle = theme.textTheme.bodyLarge!;
  final TextStyle footerStyle = theme.textTheme.bodySmall!;
  final TextStyle linkStyle =
      theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary);

  final MediaQueryData media = MediaQuery.of(context);
  final double width = media.size.width;
  final double height = media.size.height;

  // Get the card's ShapeBorder from the themed card shape.
  // This was kind of interesting to do, seem to work, for this case at least.
  final ShapeBorder? shapeBorder = theme.cardTheme.shape;
  double buttonRadius = 4; // Default un-themed value
  if (shapeBorder is RoundedRectangleBorder?) {
    final BorderRadiusGeometry? border = shapeBorder?.borderRadius;
    if (border is BorderRadius?) {
      final Radius? radius = border?.topLeft;
      buttonRadius = radius?.x == radius?.y ? (radius?.x ?? 4.0) : 4.0;
    }
  }

  showAboutDialog(
    context: context,
    applicationName: App.title(context),
    applicationVersion: App.version,
    useRootNavigator: useRootNavigator,
    applicationIcon: const Image(
                      image: AssetImage('assets/images/play_store_512.png'),
                      width: 80,
                      // TO-DO: This is not working, why?
                      // colorBlendMode: .,
                    ),
    applicationLegalese: '${App.copyright}\n${App.author}\n${App.license}',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: '${App.title(context)} 开始是为了帮助记忆十二长生宫做的，做着做着就加了一些其他的功能 '
                    ', 也算是一个练手的项目吧。\n\n'
                    '项目是开源的，你可以在',
              ),
              LinkTextSpan(
                style: linkStyle,
                uri: App.packageUri,
                text: 'github.com ',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '获取代码。源代码中的奇门算法涉及版权和专利。如有需要请提供晨植学派身份。\n\n',
              ),
              TextSpan(
                style: footerStyle,
                text: 'Built with Flutter ${App.flutterVersion}, '
                    'using ${App.packageName} '
                    '${App.packageVersion}\n'
                    'Media size (w:${width.toStringAsFixed(0)}, '
                    'h:${height.toStringAsFixed(0)})\n\n',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

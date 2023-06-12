import 'package:cfm_learning/src/provider/selected_index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import 'shared/widgets/app/about.dart';

class NavigationDrawerBuilder extends StatelessWidget {
  const NavigationDrawerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!
        .copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: false,
      removeLeft: true,
      removeRight: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.618,
        child: ChangeNotifierProvider<SelectedValue<int>>(
            create: (context) => SelectedValue(0),
            builder: (context, snapshot) {
              return Consumer<SelectedValue<int>>(
                builder: (context, selected, child) {
                  return NavigationDrawer(
                    selectedIndex: selected.value,
                    onDestinationSelected: (int value) {
                      tapAction(context, value);
                      selected.value = value;
                    },
                    children: <Widget>[
                      const SizedBox(height: 16),
                      NavigationDrawerDestination(
                        icon: const Icon(Icons.home_outlined),
                        label: Text(
                          S.of(context).homeTitle,
                          style: denseHeader,
                        ),
                      ),
                      const Divider(),
                       NavigationDrawerDestination(
                        icon: const Icon(Icons.timelapse_outlined),
                        label: Text(
                          S.of(context).solarTimeTitle,
                          style: denseBody,
                        ),
                      ),
                      NavigationDrawerDestination(
                        icon: const Icon(Icons.grid_on_outlined),
                        label: Text(
                          S.of(context).qimenTitle,
                          style: denseBody,
                        ),
                      ),
                      NavigationDrawerDestination(
                        icon: const Icon(Icons.route_outlined),
                        label: Text(
                          S.of(context).lifePalaceTitle,
                          style: denseBody,
                        ),
                      ),
                      NavigationDrawerDestination(
                        icon: const Icon(Icons.cyclone_outlined),
                        label: Text(
                          S.of(context).cycleTitle,
                          style: denseBody,
                        ),
                      ),
                      NavigationDrawerDestination(
                        icon: const Icon(Icons.calendar_today_outlined),
                        label: Text(
                          S.of(context).timesetTitle,
                          style: denseBody,
                        ),
                      ),
                      NavigationDrawerDestination(
                        icon: const Icon(Icons.settings_outlined),
                        label:
                            Text(S.of(context).settingTitle, style: denseBody),
                      ),
                      const Divider(),
                      NavigationDrawerDestination(
                        icon: const Icon(Icons.info_outline),
                        label: Text(S.of(context).aboutTitle, style: denseBody),
                      ),
                    ],
                  );
                },
                // child: ,
              );
            }),
      ),
    );
  }

  buildHeader(BuildContext context) => Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                      'https://applanding-102181.oss-cn-hangzhou.aliyuncs.com/wuxingtu.jpg'),
                ),
                SizedBox(height: 12),
                // Text('晨植五行',
                //     style: TextStyle(fontSize: 28, color: Colors.white)),
                // Text('support@bestheme.ac.cn',
                //     style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
        ),
      );

  buildMenuItem(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(
            12,
            12 + MediaQuery.of(context).padding.top,
            12,
            24 + MediaQuery.of(context).padding.bottom),
        child: Wrap(
            runSpacing: 0, // vertical spacing
            children: [
              ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: Text(S.of(context).homeTitle),
                  onTap: () => context.go('/')),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_one),
                  title: Text(S.of(context).qimenTitle),
                  onTap: () {
                    if (Scaffold.of(context).isDrawerOpen) {
                      Navigator.pop(context);
                    }
                    context.go('/qimen');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_two),
                  title: Text(S.of(context).lifePalaceTitle),
                  onTap: () {
                    if (Scaffold.of(context).isDrawerOpen) {
                      Navigator.pop(context);
                    }
                    context.go('/lifePalace');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_3),
                  title: Text(S.of(context).cycleTitle),
                  onTap: () {
                    if (Scaffold.of(context).isDrawerOpen) {
                      Navigator.pop(context);
                    }
                    context.push('/cyclehexdecades');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_4),
                  title: Text(S.of(context).solarTimeTitle),
                  onTap: () {
                    if (Scaffold.of(context).isDrawerOpen) {
                      Navigator.pop(context);
                    }
                    context.go('/person');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_5),
                  title: Text(S.of(context).timesetTitle),
                  onTap: () {
                    if (Scaffold.of(context).isDrawerOpen) {
                      Navigator.pop(context);
                    }
                    context.go('/timesetcalendar');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: Text(S.of(context).settingTitle),
                  onTap: () {
                    if (Scaffold.of(context).isDrawerOpen) {
                      Navigator.pop(context);
                    }
                    context.push('/settings');
                  }),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(S.of(context).aboutTitle),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    // applicationIcon: const Image(
                    //   image: AssetImage('lib/assets/Icon-App-288x288@1x.png'),
                    //   width: 80,
                    // ),
                    applicationName: '这是一个晨植五行学习工具',
                    applicationVersion: '1.1.2(7c24d89)',
                    applicationLegalese: '璧馨研究院开发',
                    children: <Widget>[
                      const Text('软件著作权人: 上海晨植企业管理有限公司'),
                      const Text('软件开发人: 璧馨研究院'),
                      const Text('软件支持: support@bestheme.ac.cn')
                    ],
                  );
                },
              )
            ]),
      );

  void tapAction(BuildContext context, int value) {
    switch (value) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/solartime');
        break;
      case 2:
        context.go('/qimen');
        break;
      case 3:
        context.go('/lifePalace');
        break;
      case 4:
        context.go('/cyclehexdecades');
        break;
      case 5:
        context.go('/timesetcalendar');
        break;
      case 6:
        context.go('/settings');
        break;
      case 7:
        showAppAboutDialog(context);
    }
  }
}

// This [showAppAboutDialog] function is based on the [AboutDialog] example
// that exist(ed) in the Flutter Gallery App.
// void showMaterial3AboutDialog(BuildContext context,
//     [bool useRootNavigator = true]) {
//   final ThemeData theme = Theme.of(context);
//   final TextStyle aboutTextStyle = theme.textTheme.bodyLarge!;
//   final TextStyle footerStyle = theme.textTheme.bodySmall!;
//   final TextStyle linkStyle =
//       theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary);

//   final MediaQueryData media = MediaQuery.of(context);
//   final double width = media.size.width;
//   final double height = media.size.height;

//   final Uri sourceLink = Uri(
//     scheme: 'https',
//     host: 'www.bestheme.ac.cn',
//     path: '/',
//   );

//   showAboutDialog(
//     context: context,
//     applicationName: 'Material 3 Demo',
//     applicationVersion: '1.0',
//     useRootNavigator: useRootNavigator,
//     applicationIcon: Icon(
//       Icons.looks_3_outlined,
//       size: 55,
//       color: theme.colorScheme.primary,
//     ),
//     applicationLegalese: '© 2021-2023 The Flutter Team\nBSD-style license.',
//     children: <Widget>[
//       Padding(
//         padding: const EdgeInsets.only(top: 24),
//         child: RichText(
//           text: TextSpan(
//             children: <TextSpan>[
//               TextSpan(
//                 style: aboutTextStyle,
//                 text: 'This is a slightly modified version of the '
//                     'official Material 3 demo app found in ',
//               ),
//               LinkTextSpan(
//                 style: linkStyle,
//                 uri: sourceLink,
//                 text: 'flutter/samples',
//               ),
//               TextSpan(
//                 style: aboutTextStyle,
//                 text: '. It is included here to show the configured theme '
//                     'using the official Material 3 sample app.\n\n',
//               ),
//               TextSpan(
//                 style: footerStyle,
//                 text: 'Built with Flutter ${App.flutterVersion}, '
//                     'using ${App.packageName} '
//                     '${App.packageVersion}\n'
//                     'Media size (w:${width.toStringAsFixed(0)}, '
//                     'h:${height.toStringAsFixed(0)})\n\n',
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }

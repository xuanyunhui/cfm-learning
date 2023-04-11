import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'generated/l10n.dart';

class NavigationDrawerBuilder extends StatelessWidget {
  const NavigationDrawerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // buildHeader(context),
            buildMenuItem(context),
          ],
        ),
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
            child: Column(
              children: const [
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
                  onTap: () {
                    //close navigation drawer before
                    // Navigator.pop(context);

                    // Navigator.pushReplacementNamed(context, '/');
                    return context.go('/');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_one),
                  title: Text(S.of(context).qimenTitle),
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.pushReplacementNamed(context, '/qimen');
                    return context.go('/qimen');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_two),
                  title: Text(S.of(context).lifePalaceTitle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/lifepalace');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_3),
                  title: Text(S.of(context).cycleTitle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/cyclehexdecades');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_4),
                  title: Text(S.of(context).solarTimeTitle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/solartime');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.looks_5),
                  title: Text(S.of(context).timesetTitle),
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/timesetcalendar');
                  }),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: Text(S.of(context).settingTitle),
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/settings');
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
}

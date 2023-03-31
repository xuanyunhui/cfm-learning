import 'package:flutter/material.dart';

class NavigationDrawerBuilder extends StatelessWidget {
  const NavigationDrawerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItem(context),
            ],
          ),
        ),
      );

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

  buildMenuItem(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
            runSpacing: 0, // vertical spacing
            children: [
              ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('首页'),
                  onTap: () {
                    //close navigation drawer before
                    Navigator.pop(context);

                    Navigator.pushReplacementNamed(context, '/');
                  }),
              const Divider(color: Colors.black54),
              ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('奇门'),
                  onTap: () {
                    //close navigation drawer before
                    Navigator.pop(context);

                    Navigator.pushReplacementNamed(context, '/qimen');
                  }),
              const Divider(color: Colors.black54),
              ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('长生宫'),
                  onTap: () {
                    //close navigation drawer before
                    Navigator.pop(context);

                    Navigator.pushReplacementNamed(context, '/lifepalace');
                  }),
              const Divider(color: Colors.black54),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('关于'),
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

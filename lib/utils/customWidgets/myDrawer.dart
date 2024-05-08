import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:write_me/utils/constants/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Utils.secondaryColor,
            height: 100.0,
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text("Menu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Utils.secondaryColor,
            ),
            title: const Text(
              "Fermer l'application",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
    );
  }
}

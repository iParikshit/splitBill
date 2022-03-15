import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:splitbill/redux/action_dispatcher.dart';
import 'package:splitbill/redux/app_state.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    return SliverAppBar(
      expandedHeight: 180,
      collapsedHeight: 150,
      pinned: true,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.chevron_left,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              store.dispatch(logout());
            })
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Color(0xFF00A371),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Split Bill",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Total Bill Amount",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "\$64.5",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

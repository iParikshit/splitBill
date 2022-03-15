import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:splitbill/redux/action_dispatcher.dart';
import 'package:splitbill/redux/app_state.dart';

import 'components/app_bar.dart';
import 'components/body.dart';

class SplitScreen extends StatelessWidget {
  const SplitScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    if (store.state.billState.bill == null) {
      store.dispatch(getBill());
    }
    print('rebuilding split screen');
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        MyAppBar(),
        Body(),
      ],
    ));
  }
}

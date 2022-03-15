import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:splitbill/redux/app_state.dart';
import 'package:splitbill/util/constants.dart';

class BillWidget extends StatelessWidget {
  const BillWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo show loading sign
    return Container(
      color: kGreenColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: StoreConnector<AppState, BillState>(
              distinct: true,
              builder: (context, billState) {
                return billState.isLoading
                    ? Center(
                        child: Text('Loading Bill...'),
                      )
                    : Table(
                        children: billState.bill.items
                            .map((billItem) => TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          billItem.name,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          billItem.quantity.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          billItem.price.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                            .toList(),
                      );
              },
              converter: (store) {
                return store.state.billState;
              },
            ),
          ),
        ),
      ),
    );
  }
}

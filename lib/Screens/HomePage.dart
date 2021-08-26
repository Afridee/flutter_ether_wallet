import 'package:ether_wallet_flutter_app/functions/getETHBalanceAPI.dart';
import 'package:ether_wallet_flutter_app/functions/getTokenBalanceAPI.dart';
import 'package:ether_wallet_flutter_app/functions/getTokentxList.dart';
import 'package:ether_wallet_flutter_app/functions/gettxList.dart';

import '../custom_widgets.dart/custom_appbar.dart';
import '../utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = List<String>.generate(10000, (i) => "ETH $i");
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        textTheme: _textTheme,
        title: 'itmar.argent.xyz',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: Text(
                      'Total Asset Value',
                      style:
                      _textTheme.bodyText1!.copyWith(color: Colors.white70),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8),
                        child: Text(
                          '8.02 ETH',
                          style: _textTheme.headline3!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Icon(
                          CupertinoIcons.exclamationmark_shield,
                          color: Colors.white,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: Text(
                      '\$ 3,602',
                      style: _textTheme.headline5!.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async{
                                Map<String, dynamic>  g = await getTokenTransactions(network: "-rinkeby", address: "0x303605ddAAF2690b989c2c734eA1B03F7Cc6637a");
                                print(g);
                              },
                              icon: Icon(CupertinoIcons.arrow_swap, size: 30),
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'HHH',
                              style: _textTheme.headline6!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 290,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    subtitle: Text(""),
                    tileColor: index == 0
                        ? Colors.grey.withOpacity(0.1)
                        : index == 1
                        ? Colors.grey.withOpacity(0.1)
                        : Colors.white,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        items[index],
                        style: _textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        CupertinoIcons.money_euro_circle,
                        size: 35,
                      ),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          index == 0 || index == 1
                              ? 'In Progress'
                              : "5,299", // set the price
                          style: _textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: index == 0 || index == 1 ? 14 : 20,
                            color: index == 0 || index == 1
                                ? Colors.red.withOpacity(0.8)
                                : Colors.black,
                          ),
                        ),
                        index == 0 || index == 1 ? Text('') : Text('\$6.383')
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

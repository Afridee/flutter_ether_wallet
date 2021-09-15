import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import '../../widgets/EthAccountBottomSheet.dart';
import 'package:ether_wallet_flutter_app/utils/custom_shape_clipper.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class hmPageTopPart extends StatelessWidget {
  const hmPageTopPart({
    Key? key,
    required TextTheme textTheme,
  }) : _textTheme = textTheme, super(key: key);

  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(
              MediaQuery.of(context).size.width,
              (MediaQuery.of(context).size.width * 0.8)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        Container(
          height: 280,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 8),
                child: GetBuilder<WalletController>(
                  builder: (wC) {
                    return Text(
                      "0x" +
                          wC.activeAccount.substring(0, 4) +
                          "...." +
                          wC.activeAccount.substring(
                              wC.activeAccount.length - 5,
                              wC.activeAccount.length),
                      style: _textTheme.headline5!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: GetBuilder<WalletController>(builder: (wC) {
                      return Text(
                        wC.activeAccountEthBalance + ' ETH',
                        style: _textTheme.headline3!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: IconButton(
                      iconSize: 50,
                      icon: Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        bottomSheetOfEthAccounts(context);
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 8),
                child: GetBuilder<WalletController>(
                  builder: (wC) {
                    return Text(
                      '\$ ' + wC.activeAccountUSDBalance.toString(),
                      style: _textTheme.headline5!.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                          },
                          icon: Icon(CupertinoIcons.arrow_swap, size: 30),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Tokens',
                          style: _textTheme.headline6!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
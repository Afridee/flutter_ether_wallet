import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/functions/importAccount.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:ether_wallet_flutter_app/widgets/EthAddressQRCode.dart';
import 'package:ether_wallet_flutter_app/widgets/snackbar.dart';
import 'package:ionicons/ionicons.dart';
import '../../widgets/EthAccountBottomSheet.dart';
import 'package:ether_wallet_flutter_app/utils/custom_shape_clipper.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class hmPageTopPart extends StatelessWidget {
  hmPageTopPart({
    Key? key,
    required TextTheme textTheme,
  })  : _textTheme = textTheme,
        super(key: key);

  final TextTheme _textTheme;
  final WalletController walletController = Get.put(WalletController());

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
          height: (MediaQuery.of(context).size.width * 0.8).toDouble(),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: GetBuilder<WalletController>(
                  builder: (wC) {
                    return Row(
                      children: [
                        Text(
                          "0x" +
                              wC.activeAccount.substring(0, 5) +
                              "...." +
                              wC.activeAccount.substring(
                                  wC.activeAccount.length - 5,
                                  wC.activeAccount.length),
                          style: _textTheme.headline5!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            FlutterClipboard.copy("0x" + wC.activeAccount)
                                .then((value) => {
                                      snackBar(
                                          context: context,
                                          text: "Eth address copied",
                                          trailingIcon: Icon(Icons.copy,
                                              color: Colors.white),
                                          bgColor: kPrimaryColor,
                                          textColor: Colors.white,
                                          duration: 2)
                                    });
                          },
                          icon: Icon(Icons.copy),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            EthAddressQRCode(context, wC.activeAccount);
                          },
                          icon: Icon(Icons.share),
                          color: Colors.white,
                        )
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<WalletController>(builder: (wC) {
                      return Text(
                        wC.activeAccountEthBalance + ' ETH',
                        style: _textTheme.headline5!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    }),
                    IconButton(
                      iconSize: 80,
                      icon: Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        bottomSheetOfEthAccounts(context);
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: GetBuilder<WalletController>(
                  builder: (wC) {
                    return Text(
                      '\$ ' + wC.activeAccountUSDBalance.toString(),
                      style: _textTheme.headline6!.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              Align(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Tokens',
                          style: _textTheme.headline6!.copyWith(color: Colors.white, fontSize: 22),
                        ),
                        Icon(Icons.arrow_downward_rounded, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

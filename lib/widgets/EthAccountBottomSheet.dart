import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bottomSheetOfEthAccounts(BuildContext context){
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-400,
          color: Colors.green,
          child: GetBuilder<WalletController>(
            builder: (wC){
              return ListView.builder(
                  itemCount: wC.ethAccounts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        wC.setUpEthAccount(ethAccount: wC.ethAccounts[index].address);
                      },
                      leading: Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.white,
                        size: 50,
                      ),
                      title: Text("0x" + wC.ethAccounts[index].address),
                    );
                  });
            },
          ),
        );
      });
}
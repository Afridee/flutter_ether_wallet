import 'package:ether_wallet_flutter_app/Screens/CreateEthAccount.dart';
import 'package:ether_wallet_flutter_app/Screens/ImportEthAccount.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bottomSheetOfEthAccounts(BuildContext context){
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  color: kPrimaryColor,
                ),
                child: GetBuilder<WalletController>(
                  builder: (wC){
                    return ListView.builder(
                        itemCount: wC.ethAccounts.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: (){
                                    wC.setUpEthAccount(ethAccount: wC.ethAccounts[index].address);
                                    Navigator.of(context).pop();
                                  },
                                  leading: Icon(
                                    CupertinoIcons.profile_circled,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  title: Text("0x" + wC.ethAccounts[index].address,
                                      style: TextStyle(
                                        color: Colors.white
                                      ),),
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              )
                            ],
                          );
                        });
                  },
                ),
              ),
            ),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              color: kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text("Create new", style: TextStyle(
                      color: kPrimaryColor
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new CreateEthAccountScreen()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text("Import", style: TextStyle(
                        color: kPrimaryColor
                    ),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new ImportEthAccountScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
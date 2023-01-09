import 'package:favorite/methods/methods.dart';
import 'package:favorite/methods/sqflitemethod.dart';
import 'package:favorite/models/mockmodels.dart';
import 'package:favorite/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<Food?> likedburger = [];
  @override
  void initState() {
    super.initState();
    getDataApi();
  }

  getDataApi() async {
    var response = await Methods().get('/likes');
    setState(
      () {
        likedburger = response;
        context.read<Utils>().getalllike(response);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Food?> myLikes = context.watch<Utils>().likeList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Account'),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(CupertinoIcons.gear),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myLikes.length,
                  itemBuilder: ((context, i) {
                    return Container(
                      height: 120,
                      child: Text(myLikes[i]!.name),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

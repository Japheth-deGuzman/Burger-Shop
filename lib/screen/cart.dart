import 'package:favorite/models/mockmodels.dart';
import 'package:favorite/models/models.dart';
import 'package:favorite/screen/paying.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  @override
  Widget build(BuildContext context) {
    List<Food?> myCart = context.watch<Utils>().cartList;
    List<Food?> myCheck = context.watch<Utils>().checkedlist;
    double? sum = context.watch<Utils>().sumall;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Shopping Cart'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              myCart.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Container(),
                        ),
                        const Text('No List'),
                      ],
                    )
                  : Container(
                      margin: const EdgeInsets.all(20),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myCart.length,
                        itemBuilder: (context, i) {
                          final String? name = myCart[i]!.name;
                          final String? networking = myCart[i]!.img![0].sm;
                          double price =
                              myCart[i]!.price * 3 * myCart[i]!.quantity;
                          bool? isChecked = myCart[i]!.cart;
                          int quantity = myCart[i]!.quantity;

                          // k = isChecked;
                          String fprice = price.toStringAsFixed(2);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      networking!,
                                      height: 110,
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Text(
                                            name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          '₱ $fprice',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (myCart[i]!
                                                                .quantity ==
                                                            1) {
                                                        } else {
                                                          context
                                                              .read<Utils>()
                                                              .removequantity(
                                                                  i);
                                                        }
                                                        double sum = 0;
                                                        for (var i in myCheck) {
                                                          sum +=
                                                              (i!.price * 3) *
                                                                  i.quantity;
                                                        }
                                                        context
                                                            .read<Utils>()
                                                            .getsum(sum);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            right: BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ),
                                                        width: 30,
                                                        child: Icon(
                                                          CupertinoIcons.minus,
                                                          color: quantity == 1
                                                              ? Colors.grey
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 40,
                                                      child: Center(
                                                        child: Text(
                                                          '$quantity',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (myCart[i]!
                                                                .quantity ==
                                                            50) {
                                                        } else {
                                                          context
                                                              .read<Utils>()
                                                              .addquantity(i);
                                                        }
                                                        double sum = 0;
                                                        for (var i in myCheck) {
                                                          sum +=
                                                              (i!.price * 3) *
                                                                  i.quantity;
                                                        }
                                                        context
                                                            .read<Utils>()
                                                            .getsum(sum);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            left: BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ),
                                                        width: 30,
                                                        child: Icon(
                                                          CupertinoIcons.plus,
                                                          color: quantity == 50
                                                              ? Colors.grey
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (newbool) {
                                    setState(() {
                                      myCart[i]!.cart = newbool;
                                    });
                                    if (myCart[i]!.cart == true) {
                                      context
                                          .read<Utils>()
                                          .addtocheck(myCart[i]!);
                                    } else {
                                      context
                                          .read<Utils>()
                                          .removetocheck(myCart[i]!);
                                    }
                                    double sum = 0;
                                    for (var i in myCheck) {
                                      sum += (i!.price * 3) * i.quantity;
                                    }
                                    context.read<Utils>().getsum(sum);
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      )),
            ],
          ),
        ),
      )),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Total: ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '₱ ${sum!.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  if (myCheck.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Paying(),
                      ),
                    );
                  }
                },
                child: Container(
                  height: double.infinity,
                  width: 120,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Check Out: ${myCheck.length}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

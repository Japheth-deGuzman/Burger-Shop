import 'package:badges/badges.dart';
import 'package:favorite/models/mockmodels.dart';
import 'package:favorite/screen/buynow.dart';
import 'package:favorite/screen/cart.dart';
import 'package:favorite/screen/paying.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:favorite/models/models.dart';
import 'package:provider/provider.dart';

class BurgerDetails extends StatefulWidget {
  final Food? food;
  const BurgerDetails({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<BurgerDetails> createState() => _BurgerDetailsState();
}

class _BurgerDetailsState extends State<BurgerDetails> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    List<Food?> myCart = context.watch<Utils>().cartList;
    List<Food?> myFav = context.watch<Utils>().likeList;
    final Food? burger = widget.food;
    String image = burger!.img![1].lg ?? '';
    String name = burger.name;
    double pricenum = burger.price * 3;
    String pricestr = pricenum.toStringAsFixed(2);
    String description = burger.desc ?? '';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Burger Details'),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 20),
            style: IconButton.styleFrom(),
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => const CartList(),
                ),
              )
                  .then((value) {
                for (var element in myCart) {
                  element!.cart = false;
                  element.quantity = 1;
                }
                context.read<Utils>().getsum(0);
                context.read<Utils>().removeall();
              });
            },
            icon: Badge(
              badgeColor: Colors.orange,
              borderSide: const BorderSide(color: Colors.white),
              badgeContent: Text(
                '${myCart.length}',
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              showBadge: myCart.isEmpty ? false : true,
              child: const Icon(
                CupertinoIcons.cart,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    image,
                    // fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        width: double.infinity,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        width: double.infinity,
                        child: Text(
                          '₱ $pricestr',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          description,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Container(
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                              mainAxisExtent: 250,
                            ),
                            itemCount: burger.ingredients!.length,
                            itemBuilder: (context, i) {
                              String ingredintimg = burger.ingredients![i].img!;
                              String inggredientname =
                                  burger.ingredients![i].name!;
                              return Container(
                                // padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                // height: 50,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: SizedBox(
                                          height: 110,
                                          child: Image.network(
                                            ingredintimg,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12),
                                              )),

                                          height: 100,
                                          // margin: const EdgeInsets.only(
                                          //     left: 20, right: 20, top: 10),
                                          child: Center(
                                            child: Text(
                                              inggredientname,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (!myFav.contains(burger)) {
                    context.read<Utils>().addtofav(burger);
                  } else {
                    context.read<Utils>().removetofav(burger);
                  }
                },
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * .23,
                  color: Colors.white,
                  child: !myFav.contains(burger)
                      ? const Icon(CupertinoIcons.heart)
                      : const Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.red,
                        ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: VerticalDivider(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!myCart.contains(burger)) {
                    context.read<Utils>().addtocart(burger);
                  } else {
                    context.read<Utils>().removetocart(burger);
                  }
                },
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * .23,
                  color: Colors.white,
                  child: !myCart.contains(burger)
                      ? const Icon(CupertinoIcons.cart)
                      : const Icon(
                          CupertinoIcons.cart_fill,
                          color: Colors.red,
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  bottomsheet(context, burger);
                },
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * .5,
                  color: Colors.red,
                  child: const Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
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

  Future<dynamic> bottomsheet(BuildContext context, Food burger) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: ((context, setState) {
          String name = burger.name;
          String image = burger.img![0].sm ?? '';
          double price = burger.price * 3;
          String finalprice = price.toStringAsFixed(2);
          return Container(
            color: Colors.white,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    height: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          image,
                        ),
                        Column(
                          children: [
                            Expanded(child: Container()),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                '₱ $finalprice',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(CupertinoIcons.xmark),
                              ),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text('Quantity'),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      right: BorderSide(color: Colors.black)),
                                ),
                                width: 40,
                                child: Icon(
                                  CupertinoIcons.minus,
                                  color: quantity == 1
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Center(
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity < 50) {
                                    quantity++;
                                  }
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(color: Colors.black)),
                                ),
                                width: 40,
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
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => BuyNow(
                            image: image,
                            name: name,
                            price: finalprice,
                            quantity: quantity,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      width: double.infinity,
                      color: Colors.red,
                      child: const Center(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
      },
    );
  }
}

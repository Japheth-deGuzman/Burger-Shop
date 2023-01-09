import 'package:badges/badges.dart';
import 'package:favorite/methods/methods.dart';
import 'package:favorite/methods/sqflitemethod.dart';
import 'package:favorite/models/mockmodels.dart';
import 'package:favorite/models/models.dart';
import 'package:favorite/screen/cart.dart';
import 'package:favorite/screen/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Food?> burger = [];
  List<Food?> likedburger = [];
  List<BurgerCart> cart = [];

  @override
  void initState() {
    super.initState();
    getDataAPI();
  }

  getDataAPI() async {
    var responsefood = await Methods().get('/foods');
    setState(
      () {
        burger = responsefood;
        context.read<Utils>().getall(responsefood);
      },
    );
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
    List<Food?> myCart = context.watch<Utils>().cartList;
    List<Food?> food = context.watch<Utils>().foodList;
    List<Food?> myLikes = context.watch<Utils>().likeList;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'Burger Shop',
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(CupertinoIcons.search),
            ),
          ),
          GestureDetector(
            onTap: () {
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
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              child: Badge(
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
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    mainAxisExtent: 290,
                  ),
                  itemCount: food.length,
                  itemBuilder: (context, i) {
                    final String name = food[i]!.name;
                    final String? networking = food[i]!.img![0].sm;
                    double price = food[i]!.price * 3;
                    String fprice = price.toStringAsFixed(2);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BurgerDetails(
                                  food: burger[i]!,
                                )));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          // height: 150,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  networking!,
                                  height: 150,
                                  width: double.infinity,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                child: Container(
                                  color: Colors.orange[100],
                                  width: double.infinity,
                                  height: 120,
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          name,
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
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (!myLikes.contains(food[i])) {
                                                context
                                                    .read<Utils>()
                                                    .addtofav(food[i]!);
                                              } else {
                                                context
                                                    .read<Utils>()
                                                    .removetofav(food[i]!);
                                              }
                                            },
                                            child: !myLikes.contains(food[i])
                                                ? const Icon(
                                                    CupertinoIcons.heart)
                                                : const Icon(
                                                    CupertinoIcons.heart_fill,
                                                    color: Colors.red,
                                                  ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (!myCart.contains(food[i])) {
                                                  context
                                                      .read<Utils>()
                                                      .addtocart(food[i]!);
                                                } else {
                                                  context
                                                      .read<Utils>()
                                                      .removetocart(food[i]!);
                                                }
                                              },
                                              child: !myCart.contains(burger[i])
                                                  ? const Icon(
                                                      CupertinoIcons.cart)
                                                  : const Icon(
                                                      CupertinoIcons.cart_fill,
                                                      color: Colors.red,
                                                    ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    List<Food?> myList = context.watch<Utils>().foodList;
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
      IconButton(
        onPressed: () {
          String name = query;
          for (var i in myList) {
            if (name == i!.name) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => BurgerDetails(
                    food: i,
                  ),
                ),
              );
            }
          }
        },
        icon: const Icon(Icons.search),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Food?> myList = context.watch<Utils>().foodList;
    List<String?> foodname =
        List.generate(myList.length, (index) => myList[index]!.name);

    List<String> matchQuery = [];
    for (String? fruit in foodname) {
      if (fruit!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, i) {
        String result = matchQuery[i];
        return ListTile(
          onTap: () {
            query = result;
            // Food? selectedfood;
            // if (foodname[i] == query) {
            //   selectedfood = myList[i];
            // }
            // // if()
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (context) => BurgerDetails(
            //           food: selectedfood!,
            //         )));
          },
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Food?> myList = context.watch<Utils>().foodList;
    List<String?> foodname =
        List.generate(myList.length, (index) => myList[index]!.name);

    List<String> matchQuery = [];
    for (String? fruit in foodname) {
      if (fruit!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, i) {
        String result = matchQuery[i];
        return ListTile(
          onTap: () {
            query = result;
          },
          title: Text(result),
        );
      },
    );
  }
}

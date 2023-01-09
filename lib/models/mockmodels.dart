import 'package:favorite/methods/methods.dart';
import 'package:favorite/models/models.dart';
import 'package:favorite/screen/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Utils with ChangeNotifier {
  final List<Food?> cart = [];
  List<Food?> get cartList => cart;
  void addtocart(Food food) {
    cartList.add(food);
    notifyListeners();
  }

  List<Food?> foodall = [];
  List<Food?> get foodList => foodall;
  void getall(List<Food?> food) {
    foodall.addAll(food);
    notifyListeners();
  }

  void addquantity(int i) {
    cartList[i]!.quantity++;
    notifyListeners();
  }

  void removequantity(int i) {
    cartList[i]!.quantity--;
    notifyListeners();
  }

  void removetocart(Food food) {
    cartList.remove(food);
    notifyListeners();
  }

  final List<Food?> foodlike = [];
  List<Food?> get likeList => foodlike;
  void getalllike(List<Food?> food) {
    foodlike.addAll(food);
    notifyListeners();
  }

  // final List<Food?> fav = [];
  // List<Food?> get favList => fav;
  void addtofav(Food food) {
    foodlike.add(food);
    notifyListeners();
  }

  void removetofav(Food food) {
    foodlike.remove(food);
    notifyListeners();
  }

  final List<Food?> checkFood = [];
  List<Food?> get checkedlist => checkFood;
  void addtocheck(Food food) {
    checkedlist.add(food);
    notifyListeners();
  }

  void removeall() {
    checkedlist.clear();
  }

  void removetocheck(Food food) {
    checkedlist.remove(food);
    notifyListeners();
  }

  double sum = 0;
  double? get sumall => sum;
  void getsum(double sumA) {
    sum = sumA;
  }
}

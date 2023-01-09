// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<Food?> foodFromJson(String str) =>
    List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
 
class Food {
  Food({
    required this.burger_id,
    required this.name,
    this.img,
    this.desc,
    this.ingredients,
    required this.price,
    this.veg,
    this.cart,
    required this.quantity,
  });

  final int burger_id;
  final String name;
  List<Imgs>? img;
  String? desc;
  List<Ingredient>? ingredients;
  double price;
  bool? veg;
  bool? cart;
  int quantity;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
      burger_id: json["burger_id"] ?? '',
      name: json["name"],
      img: List<Imgs>.from(json["images"].map((x) => Imgs.fromJson(x))),
      desc: json["desc"] ?? '',
      ingredients: List<Ingredient>.from(
          json["ingredients"].map((x) => Ingredient.fromJson(x))),
      price: json["price"].toDouble() ?? '',
      veg: json["veg"] ?? '',
      cart: json["cart"] ?? false,
      quantity: 1);

  Map<String, dynamic> toJson() => {
        "burger_id": burger_id,
        "name": name,
        "images":
            img != null ? List<dynamic>.from(img!.map((x) => x.toJson())) : [],
        "desc": desc ?? '',
        "ingredients": ingredients != null
            ? List<dynamic>.from(ingredients!.map((x) => x.toJson()))
            : [],
        "price": price,
        "veg": veg ?? '',
        "cart": cart ?? '',
        "quantity": 1,
      };
}

class Imgs {
  Imgs({
    this.sm,
    this.lg,
  });

  String? sm;
  String? lg;

  factory Imgs.fromJson(Map<String, dynamic> json) => Imgs(
        sm: json["sm"],
        lg: json["lg"],
      );

  Map<String, dynamic> toJson() => {
        "sm": sm ?? '',
        "lg": lg ?? '',
      };
}

class Ingredient {
  Ingredient({
    this.id,
    this.name,
    this.img,
  });

  int? id;
  String? name;
  String? img;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "name": name ?? '',
        "img": img ?? '',
      };
}

class FoodName {
  FoodName({
    this.name,
  });
  String? name;
}

class BurgerCart {
  BurgerCart({
    this.name,
    this.id,
  });
  final String? name;
  final int? id;
  factory BurgerCart.fromMap(Map<String, dynamic> json) =>
      BurgerCart(id: json['id'], name: json['name']);
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}

class BurgerFav {
  BurgerFav({
    required this.name,
    this.id,
  });
  final String? name;
  final int? id;
  factory BurgerFav.fromMap(Map<String, dynamic> json) =>
      BurgerFav(id: json['id'], name: json['name']);
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}

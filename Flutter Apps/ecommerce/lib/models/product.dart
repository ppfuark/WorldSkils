enum Gender {male, female, unisex}

class Product {
  late String name;
  late String brand;
  late String size;
  late Gender gender;
  late double price;
  late int quantity;
  String image;

  Product({
    required this.brand,
    required this.name,
    required this.size,
    required this.quantity,
    required this.price,
    this.image = "https://www.svgrepo.com/show/36558/sell-product.svg",
    this.gender = Gender.unisex
  });
}
enum Gender {male, female, unisex}

class Product {
  late String name;
  late String brand;
  late String size;
  late Gender gender;
  late double price;
  late int quantity;

  Product({
    required this.brand,
    required this.name,
    required this.size,
    required this.quantity,
    required this.price,
    this.gender = Gender.unisex
  });
}
enum Gender { male, female, unisex }

class Product {
  final String name;
  final String brand;
  final String size;
  final Gender gender;
  final double price;
  int stock;
  final String image;

  Product({
    required this.brand,
    required this.name,
    required this.size,
    required this.stock,
    required this.price,
    this.image = "https://www.svgrepo.com/show/36558/sell-product.svg",
    this.gender = Gender.unisex,
  });

  bool hasStock(int quantity) {
    return stock >= quantity;
  }

  void decreaseStock(int quantity) {
    if (hasStock(quantity)) {
      stock -= quantity;
    }
  }

  void increaseStock(int quantity) {
    stock += quantity;
  }
}
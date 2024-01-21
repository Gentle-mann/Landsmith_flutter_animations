class Product {
  final String title, imageUrl;

  Product({required this.title, required this.imageUrl});
  static final products =
      Product(title: 'Sneakers', imageUrl: 'assets/images/sneakers.jpg');
}

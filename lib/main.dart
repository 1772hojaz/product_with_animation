import 'package:flutter/material.dart';
import 'package:product_with_animation/theme.dart';
import 'package:get/get.dart';
import 'package:product_with_animation/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Product Catalogue",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: Produc(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Produc extends StatefulWidget {
  const Produc({super.key});

  @override
  State<Produc> createState() => _ProducState();
}

class _ProducState extends State<Produc> {
  // Product list
  final List<Product> products = [
    Product(
      name: "Blue Shirt",
      imageUrl:
          "https://demo.wpstartersites.com/cordero-demo/wp-content/uploads/sites/12/2020/06/mens-tee-blue.jpg",
      price: 20,
    ),
    Product(
      name: "Shirt",
      imageUrl:
          "https://th.bing.com/th/id/R.9169b89e6c3fd7d73a756d9553ad015e?rik=BXekelNt%2fQGk1w&riu=http%3a%2f%2fimage.sportsmansguide.com%2fadimgs%2fl%2f2%2f228743_ts.jpg&ehk=WDr1ncSnbH5zeOHiI%2faKTOup%2bDbGUieb4BBTu2AvVPc%3d&risl=&pid=ImgRaw&r=0",
      price: 20,
    ),
    Product(
      name: "COOFANDY Men's Casual Dress Shirt",
      imageUrl:
          "https://m.media-amazon.com/images/I/71I-cik1CyL._AC_UL1500_.jpg",
      price: 20,
    ),
    Product(
      name: "Plaid Flannel Mens Shirt",
      imageUrl:
          "https://th.bing.com/th/id/OIP.u7hZ_9zihfxfOR-TwoWN8gAAAA?rs=1&pid=ImgDetMain",
      price: 20,
    ),
  ];

  bool isLightTheme = true;

  void toggleTheme() {
    setState(() {
      isLightTheme = !isLightTheme;
      // Getting theme mode using GETx
      Get.changeThemeMode(isLightTheme ? ThemeMode.light : ThemeMode.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product catalogue"),
        actions: [
          IconButton(
            icon: Icon(isLightTheme ? Icons.dark_mode : Icons.light_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in grid
          childAspectRatio: 0.75, // Aspect ratio of each item
          crossAxisSpacing: 10, // Space between columns
          mainAxisSpacing: 10, // Space between rows
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTap() {
    setState(() {
      _scale = 1.1; // Scale up for bounce effect
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _scale = 1.0; // Scale back to original size
      });
    });

    // Showing a dialog with the product's name
    Future.delayed(const Duration(seconds: 2), () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Product Selected'),
            content: Text(widget.product.name),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Transform.scale(
        scale: _scale,
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

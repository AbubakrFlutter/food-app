import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview_plus/device_preview_plus.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, 
      builder: (context) => const FoodOrderingApp(),
    ),
  );
}

class FoodOrderingApp extends StatelessWidget {
  const FoodOrderingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, 
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder, 
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Poppins',
      ),
      home: const SearchRecipesScreen(),
    );
  }
}

class FoodItem {
  final String name;
  final double price;
  final double? originalPrice;
  final String emoji;
  final int rating;
  final Color cardColor;

  FoodItem({
    required this.name,
    required this.price,
    this.originalPrice,
    required this.emoji,
    this.rating = 4,
    required this.cardColor,
  });
}

class SearchRecipesScreen extends StatelessWidget {
  const SearchRecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recommendedItems = [
      FoodItem(
        name: 'Hamburger',
        price: 21,
        emoji: '🍔',
        cardColor: const Color(0xFFFFE5CC),
      ),
      FoodItem(
        name: 'Chips',
        price: 15,
        emoji: '🍟',
        cardColor: const Color(0xFFD4E7FF),
      ),
      FoodItem(
        name: 'Donut',
        price: 8,
        emoji: '🍩',
        cardColor: const Color(0xFFD4F5E9),
      ),
    ];

    final featuredItems = [
      FoodItem(
        name: 'Delicious hot dog',
        price: 6,
        originalPrice: 10,
        emoji: '🌭',
        rating: 4,
        cardColor: const Color(0xFFFFE5E5),
      ),
      FoodItem(
        name: 'Cheese pizza',
        price: 12,
        originalPrice: 15,
        emoji: '🍕',
        rating: 5,
        cardColor: const Color(0xFFFFE5E5),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.menu, size: 24),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      shape: BoxShape.circle,
                    ),
                    child: const Text('🎓', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'SEARCH FOR\nRECIPES',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[400]),
                    const SizedBox(width: 10),
                    Text('Search', style: TextStyle(color: Colors.grey[400])),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Recommended Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recommended',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 160,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: recommendedItems.length,
                itemBuilder: (context, index) {
                  final item = recommendedItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(item: item),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: item.cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.emoji,
                            style: const TextStyle(fontSize: 48),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${item.price.toInt()}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'FEATURED',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    'COMBOS',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    'FAVORITES',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Featured Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: featuredItems.length,
                itemBuilder: (context, index) {
                  final item = featuredItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: item.cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              item.emoji,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(
                                  5,
                                  (i) => Icon(
                                    Icons.star,
                                    size: 14,
                                    color: i < item.rating
                                        ? Colors.orange
                                        : Colors.grey[300],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '\$${item.price.toInt()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (item.originalPrice != null)
                                    Text(
                                      '\$${item.originalPrice!.toInt()}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[400],
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF8A65),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Detail Screen
class ProductDetailScreen extends StatefulWidget {
  final FoodItem item;

  const ProductDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 2;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final featuredItems = [
      FoodItem(
        name: 'Sweet cheese',
        price: 11,
        emoji: '🧀',
        cardColor: const Color(0xFFFFE5FF),
      ),
      FoodItem(
        name: 'Fried egg',
        price: 8,
        emoji: '🌮',
        cardColor: const Color(0xFFFFE5CC),
      ),
      FoodItem(
        name: 'Sweet popcorn',
        price: 6,
        emoji: '🍿',
        cardColor: const Color(0xFFFFE5E5),
      ),
      FoodItem(
        name: 'Dessert',
        price: 9,
        emoji: '🍰',
        cardColor: const Color(0xFFD4F5E9),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.menu, size: 24),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'SUPER\nBEEF BURGER',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Product Image
            Center(
              child: Container(
                width: 200,
                height: 200,
                child: const Text('🍔', style: TextStyle(fontSize: 150)),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isFavorite ? Colors.pink[50] : Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: () => setState(() => isFavorite = !isFavorite),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.pink : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.timer_outlined,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Price and Add to Cart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    '\$42',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange[300]!),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (quantity > 1) setState(() => quantity--);
                          },
                          child: const Text(
                            '-',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => quantity++),
                          child: const Text(
                            '+',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A65),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Featured Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'FEATURED',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            // Featured Items Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: featuredItems.length,
                itemBuilder: (context, index) {
                  final item = featuredItems[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: item.cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              item.emoji,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${item.price.toInt()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

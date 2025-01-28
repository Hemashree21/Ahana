import 'dart:convert';
import 'package:ahana/components/basePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ahana/pages/productDetails.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String sortOption = "Low to High";
  String searchQuery = "";
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      List<String> imagePaths = [
        'lib/assets/RagiLadoo.png',
        'lib/assets/Garlic_pickle.png',
        'lib/assets/immunity_powder.png',
        'lib/assets/Dry_fruit_chikki.png',
        'lib/assets/fenugreek_powder.png',
        'lib/assets/sesame_ladoo.webp',
      ];

      List<String> productNames = [
        'Ragi Ladoo',
        'Garlic Pickle',
        'Immunity Powder',
        'Dry Fruit Chikki',
        'Fenugreek Powder',
        'Sesame Ladoo',
      ];

      setState(() {
        products = List.generate(imagePaths.length, (index) {
          return {
            'name': productNames[index],
            'price': (index + 1) * 300,
            'rating': (4.0 + (index % 2) * 0.2).toStringAsFixed(1),
            'userRating': 4 - (index % 2),
            'reviews': 10 + index * 2,
            'weight': '${(index + 1) * 500}g',
            'image': imagePaths[index],
          };
        });
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error loading products: $e");
    }
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (searchQuery.isEmpty) {
      return products;
    } else {
      return products
          .where((product) =>
          product['name'].toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }


  void sortProducts(String option) {
    setState(() {
      if (option == "High to Low") {
        products.sort((a, b) => b['price'].compareTo(a['price']));
      } else if (option == "Low to High") {
        products.sort((a, b) => a['price'].compareTo(b['price']));
      }
      sortOption = option;
    });
  }

  void navigateToProductPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BasePage(
          activeSection: 'shopping',
          body: ProductPage(),  // ProductPage should not wrap itself in Scaffold
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEFE7CA),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for products',
                  hintStyle: const TextStyle(
                    color: Color(0xFF630A00),
                    fontSize: 16,
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.search, color: Color(0xFF630A00)),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color(0xFF630A00),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color(0xFF630A00),
                      width: 2.0,
                    ),
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF630A00),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sort by',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF630A00),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => sortProducts("High to Low"),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: sortOption == "High to Low"
                                ? const Color(0xFF630A00)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: const Color(0xFF630A00),
                            ),
                          ),
                          child: Text(
                            "High to Low",
                            style: TextStyle(
                              color: sortOption == "High to Low"
                                  ? Colors.white
                                  : const Color(0xFF630A00),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => sortProducts("Low to High"),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: sortOption == "Low to High"
                                ? const Color(0xFF630A00)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: const Color(0xFF630A00),
                            ),
                          ),
                          child: Text(
                            "Low to High",
                            style: TextStyle(
                              color: sortOption == "Low to High"
                                  ? Colors.white
                                  : const Color(0xFF630A00),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () => navigateToProductPage(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              product['image'] ?? '',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 19.75,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF031E3A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹ ${product['price']}',
                                  style: const TextStyle(
                                    fontSize: 19.75,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF031E3A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex <
                                          (product['userRating'] ??
                                              0)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: const Color(0xFF630A00),
                                      size: 16,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '(${product['reviews']} Reviews)',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF031E3A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}

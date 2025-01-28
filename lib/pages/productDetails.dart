import 'package:flutter/material.dart';
import 'package:ahana/components/basePage.dart';

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;

  String getProductDescription(String productName) {
    // Add descriptions for each product
    Map<String, String> descriptions = {
      'Ragi Ladoo': "Ragi Laddu, a delightful blend of health and taste, nurtures your well-being in every bite...",
      'Garlic Pickle': "A spicy and tangy pickle made with fresh garlic and traditional spices...",
      'Immunity Powder': "A powerful blend of natural herbs that boost your immune system...",
      'Dry Fruit Chikki': "A nutritious mix of nuts and jaggery, perfect for a healthy snack...",
      'Fenugreek Powder': "Pure ground fenugreek seeds with numerous health benefits...",
      'Sesame Ladoo': "Traditional sweet made with roasted sesame seeds and jaggery..."
    };

    return descriptions[productName] ?? "Product description not available.";
  }

  Map<String, List<String>> getProductIngredients(String productName) {
    Map<String, List<String>> ingredients = {
      'Ragi Ladoo': [
        "Organic Ragi Flour: Rich in calcium, iron, protein, and fiber",
        "Dates: Natural sweetness and vital minerals",
        "Pure Ghee: Essential fats for taste and strength"
      ],
      'Garlic Pickle': [
        "Fresh Garlic: Rich in antioxidants",
        "Traditional Spices: For authentic flavor",
        "Natural Oil: For preservation"
      ],
      'Immunity Powder': [
        "Organic Ragi Flour: Rich in calcium, iron, protein, and fiber",
        "Dates: Natural sweetness and vital minerals",
        "Pure Ghee: Essential fats for taste and strength"
      ],
      'Dry Fruit Chikki': [
        "Fresh Garlic: Rich in antioxidants",
        "Traditional Spices: For authentic flavor",
        "Natural Oil: For preservation"
      ],
      'Fenugreek Powder': [
        "Organic Ragi Flour: Rich in calcium, iron, protein, and fiber",
        "Dates: Natural sweetness and vital minerals",
        "Pure Ghee: Essential fats for taste and strength"
      ],
      'Sesame Laddoo': [
        "Fresh Garlic: Rich in antioxidants",
        "Traditional Spices: For authentic flavor",
        "Natural Oil: For preservation"
      ],
    };

    return {
      'ingredients': ingredients[productName] ?? ["Ingredients information not available"]
    };
  }

  Map<String, List<String>> getHealthBenefits(String productName) {
    Map<String, List<String>> benefits = {
      'Ragi Ladoo': [
        "Digestive Support",
        "Weight Management",
        "Bone Health",
        "Blood Sugar Regulation",
        "Cognitive Enhancement"
      ],
      'Garlic Pickle': [
        "Boosts Immunity",
        "Aids Digestion",
        "Anti-inflammatory Properties",
        "Heart Health"
      ],
      'Immunnity Powder': [
        "Digestive Support",
        "Weight Management",
        "Bone Health",
        "Blood Sugar Regulation",
        "Cognitive Enhancement"
      ],
      'Dry Fruit Chikki': [
        "Boosts Immunity",
        "Aids Digestion",
        "Anti-inflammatory Properties",
        "Heart Health"
      ],
      'Fenugreek Powder': [
        "Digestive Support",
        "Weight Management",
        "Bone Health",
        "Blood Sugar Regulation",
        "Cognitive Enhancement"
      ],
      'Sesame Laddoo': [
        "Boosts Immunity",
        "Aids Digestion",
        "Anti-inflammatory Properties",
        "Heart Health"
      ],
      // Add benefits for other products...
    };

    return {
      'benefits': benefits[productName] ?? ["Health benefits information not available"]
    };
  }

  @override
  Widget build(BuildContext context) {
    final productIngredients = getProductIngredients(widget.product['name']);
    final healthBenefits = getHealthBenefits(widget.product['name']);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: PageView(
              children: [
                Image.asset(widget.product['image'], fit: BoxFit.cover),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹ ${widget.product['price']}",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Availability: In Stock",
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              ...List.generate(5, (starIndex) {
                return Icon(
                  starIndex < (widget.product['userRating'] ?? 0)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.orange,
                  size: 20,
                );
              }),
              const SizedBox(width: 8),
              Text(
                "(${widget.product['reviews']} Reviews)",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Text(
                      "$quantity",
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          const SectionHeading("Product Description"),
          Text(
            getProductDescription(widget.product['name']),
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),

          const SectionHeading("Ingredients"),
          BulletPoints(productIngredients['ingredients']!),
          const SizedBox(height: 16),

          const SectionHeading("Health Benefits"),
          BulletPoints(healthBenefits['benefits']!),
          const SizedBox(height: 32),

          const SectionHeading("Customer Reviews"),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.brown[300]!, width: 2.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('lib/assets/profile.png'),
                            radius: 20,
                          ),
                          SizedBox(width: 16),
                          Text(
                            "Riya",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Absolutely delicious and nutritious! These laddus are the perfect healthy snack.",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),

          const SectionHeading("Related Products"),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 3 / 5,
            ),
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          widget.product['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.product['name'],
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text("₹ ${widget.product['price']}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8), // Added padding at bottom
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;

  const SectionHeading(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BulletPoints extends StatelessWidget {
  final List<String> points;

  const BulletPoints(this.points, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points
          .map((point) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            const Icon(Icons.check, size: 20, color: Colors.brown),
            const SizedBox(width: 8),
            Expanded(child: Text(point)),
          ],
        ),
      ))
          .toList(),
    );
  }
}
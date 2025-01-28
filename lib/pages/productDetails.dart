import 'package:flutter/material.dart';
import 'package:ahana/components/basePage.dart'; // Assuming BasePage is defined in this file

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1; // For controlling the quantity of items.

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel
            AspectRatio(
              aspectRatio: 16 / 9,
              child: PageView(
                children: [
                  Image.asset('lib/assets/RagiLadoo.png', fit: BoxFit.cover),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Title, price, and stock status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Ragi Laddu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "₹ 1100",
                  style: TextStyle(
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
              children: const [
                Icon(Icons.star, color: Colors.orange, size: 20),
                Icon(Icons.star, color: Colors.orange, size: 20),
                Icon(Icons.star, color: Colors.orange, size: 20),
                Icon(Icons.star, color: Colors.orange, size: 20),
                Icon(Icons.star_half, color: Colors.orange, size: 20),
                SizedBox(width: 8),
                Text(
                  "(10 Reviews)",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Quantity Selector and Add to Cart Button
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

            // Product Description
            const SectionHeading("Product Description"),
            const Text(
              "Ragi Laddu, a delightful blend of health and taste, nurtures your well-being in every bite. Enriched with fiber, protein, calcium, and phosphorus, these laddus promote digestion, weight loss, bone strength, and blood sugar regulation.",
            ),
            const SizedBox(height: 16),

            // Ingredients Section
            const SectionHeading("Ingredients"),
            const BulletPoints([
              "Organic Ragi Flour: Rich in calcium, iron, protein, and fiber.",
              "Dates: Natural sweetness and vital minerals.",
              "Pure Ghee: Essential fats for taste and strength.",
            ]),
            const SizedBox(height: 16),

            // Health Benefits
            const SectionHeading("Health Benefits"),
            const BulletPoints([
              "Digestive Support",
              "Weight Management",
              "Bone Health",
              "Blood Sugar Regulation",
              "Cognitive Enhancement",
            ]),
            const SizedBox(height: 32),

            // Customer Reviews Section
            const SectionHeading("Customer Reviews"),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Number of reviews
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.brown[50],
                      border: Border.all(color: Colors.brown[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                              AssetImage('lib/assets/profile.png'), // Reviewer photo
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

            // Related Products
            const SectionHeading("Related Products"),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2, // Number of related products
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'lib/assets/RagiLadoo.png', // Placeholder image
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text("Ragi Laddu", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text("₹ 1100", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                );
              },
            ),
          ],
        ),
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
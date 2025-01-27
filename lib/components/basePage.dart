import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Widget body; // Declare the body as a field

  const BasePage({super.key, required this.body}); // Accept body as a required parameter

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    // Get the current route name
    String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    return Scaffold(
      backgroundColor: Color(0xFFEFE7CA),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFE7CA),
        elevation: 0,
        leading: Icon(Icons.account_circle, color: Color(0xFF630A00)),
        title: Text(
          'ahana',
          style: TextStyle(
            fontFamily: 'Cursive',
            color: Color(0xFF630A00),
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.shopping_cart, color: Color(0xFF630A00)),
        ],
      ),
      body: widget.body, // Use the passed body here
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF630A00),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomIcon(context, 'lib/assets/consultation.png', '/consultation', currentRoute),
              _buildBottomIcon(context, 'lib/assets/shopping.png', '/shopping', currentRoute),
              _buildBottomIcon(context, 'lib/assets/home.png', '/', currentRoute),
              _buildBottomIcon(context, 'lib/assets/period_tracker.png', '/period_tracker', currentRoute),
              _buildBottomIcon(context, 'lib/assets/community.png', '/community', currentRoute),
              _buildBottomIcon(context, 'lib/assets/articles.png', '/articles', currentRoute),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomIcon(BuildContext context, String assetPath, String routeName, String currentRoute) {
    bool isSelected = currentRoute == routeName;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName); // Navigate using named route
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Color(0xFFEFE7CA) : Colors.transparent, // Highlight the selected icon
        ),
        padding: EdgeInsets.all(6), // Add padding for a circle effect
        child: Image.asset(
          assetPath,
          width: 32,
          height: 32,
          color: isSelected ? Color(0xFF630A00) : Colors.white, // Change color when selected
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BasePage extends StatefulWidget {
  final Widget body;

  const BasePage({super.key, required this.body});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    // Get the current route name
    String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    return Scaffold(
      backgroundColor: const Color(0xFFEFE7CA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFE7CA),
        elevation: 0,
        leading: const Icon(Icons.account_circle, color: Color(0xFF630A00)),
        title: const Text(
          'ahana',
          style: TextStyle(
            fontFamily: 'LeagueScript',
            fontWeight: FontWeight.w500,
            color: Color(0xFF630A00),
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.shopping_cart, color: Color(0xFF630A00)),
        ],
      ),
      body: widget.body,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF630A00),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomIcon(context, 'lib/assets/consultation.png', '/consultation', currentRoute),
              _buildBottomIcon(context, 'lib/assets/shopping.png', '/shopping', currentRoute),
              _buildBottomIcon(context, 'lib/assets/home.png', '/home', currentRoute),
              _buildBottomIcon(context, 'lib/assets/period_tracker.png', '/periodtracker', currentRoute),
              _buildBottomIcon(context, 'lib/assets/community.png', '/community', currentRoute),
              _buildBottomIcon(context, 'lib/assets/articles.png', '/articles', currentRoute),
            ],
          ),
        ),
      ),
    );
  }

  /// Normalize the route to handle subroutes accurately
  String _getParentRoute(String route) {
    // Define parent routes for subroutes
    if (route.startsWith('/shopping')) {
      return '/shopping';
    }
    // Add similar handling for other routes if needed
    return route; // Default case
  }

  Widget _buildBottomIcon(BuildContext context, String assetPath, String routeName, String currentRoute) {
    // Get the parent route of the current route
    String parentRoute = _getParentRoute(currentRoute);

    // Highlight the icon if the parent route matches the target route
    bool isSelected = parentRoute == routeName;

    return GestureDetector(
      onTap: () {
        if (parentRoute != routeName) {
          // Use GoRouter to navigate
          context.go(routeName);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFFEFE7CA) : Colors.transparent, // Highlight the selected icon
        ),
        padding: const EdgeInsets.all(6), // Add padding for a circle effect
        child: Image.asset(
          assetPath,
          width: 32,
          height: 32,
          color: isSelected ? const Color(0xFF630A00) : Colors.white, // Change color when selected
        ),
      ),
    );
  }
}

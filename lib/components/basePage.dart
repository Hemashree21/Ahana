import 'package:ahana/pages/articles.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Widget body;
  final String activeSection;

  const BasePage({
    super.key,
    required this.body,
    this.activeSection = 'home',
  });

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late String _activeSection;

  @override
  void initState() {
    super.initState();
    _activeSection = widget.activeSection;
  }

  void _handleNavigation(BuildContext context, String routeName, String section) {
    setState(() {
      _activeSection = section;
    });
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFE7CA),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFE7CA),
        elevation: 0,
        leading: Icon(Icons.account_circle, color: Color(0xFF630A00)),
        title: Text(
          'ahana',
          style: TextStyle(
            fontFamily: 'LeagueScript',
            color: Color(0xFF630A00),
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart, color: Color(0xFF630A00)),
          ),
        ],
      ),
      body: SafeArea(  // Wrap the body with SafeArea
        child: widget.body,
      ),
      bottomNavigationBar: Container(  // Removed the extra Padding widget
        margin: EdgeInsets.all(12),  // Changed padding to margin
        decoration: BoxDecoration(
          color: Color(0xFF630A00),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomIcon(context, 'lib/assets/consultation.png', '/consultation', 'consultation'),
            _buildBottomIcon(context, 'lib/assets/shopping.png', '/shopping', 'shopping'),
            _buildBottomIcon(context, 'lib/assets/home.png', '/', 'home'),
            _buildBottomIcon(context, 'lib/assets/period_tracker.png', '/period_tracker', 'period_tracker'),
            _buildBottomIcon(context, 'lib/assets/community.png', '/community', 'community'),
            _buildBottomIcon(context, 'lib/assets/articles.png', '/articles', 'articles'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomIcon(BuildContext context, String assetPath, String routeName, String section) {
    bool isSelected = _activeSection == section;
    return GestureDetector(
      onTap: () {
        // For Articles page
        if (routeName == '/articles') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BasePage(
                activeSection: 'articles',  // Set activeSection to 'articles'
                body: ArticlePage(),  // Your Articles page widget
              ),
            ),
          );
        } else {
          // Handle other navigation cases
          _handleNavigation(context, routeName, section);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Color(0xFFEFE7CA) : Colors.transparent,
        ),
        padding: EdgeInsets.all(6),
        child: Image.asset(
          assetPath,
          width: 32,
          height: 32,
          color: isSelected ? Color(0xFF630A00) : Colors.white,
        ),
      ),
    );
  }
}
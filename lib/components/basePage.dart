import 'package:ahana/pages/articles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  // Sign User Out
  void signUserOut(BuildContext context) async {
    try {
      // Sign out from Google and Firebase
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      // Show a success dialog after signing out
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Signed Out'),
          content: const Text('You have been signed out successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
                // Navigate to /auth page
                Navigator.pushReplacementNamed(context, '/auth');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Show an error dialog if something goes wrong
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while signing out.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }


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
            fontWeight: FontWeight.w800,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 8), // Adjust padding to align left
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: Icon(Icons.shopping_cart, color: Color(0xFF630A00)),
                ),
                SizedBox(width: 16), // Space between cart and logout
                GestureDetector(
                  onTap: () {
                    signUserOut(context);
                  },
                  child: Icon(Icons.logout, color: Color(0xFF630A00)),
                ),
              ],
            ),
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
            _buildBottomIcon(context, 'lib/assets/period_tracker.png', '/periodtracker', 'period_tracker'),
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

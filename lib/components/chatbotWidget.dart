// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class ChatbotWidget extends StatefulWidget {
//   const ChatbotWidget({Key? key}) : super(key: key);
//
//   @override
//   State<ChatbotWidget> createState() => _ChatbotWidgetState();
// }
//
// class _ChatbotWidgetState extends State<ChatbotWidget> {
//   late final WebViewController _controller;
//   bool _isLoading = true;
//   bool _isExpanded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..loadHtmlString('''
//         <!DOCTYPE html>
//         <html>
//         <head>
//           <meta name="viewport" content="width=device-width, initial-scale=1.0">
//           <style>
//             body { margin: 5vh; padding: 5vh; background: transparent; }
//             .webchat { height: 80%; width: 80%; }
//           </style>
//         </head>
//         <body>
//           <script src="https://cdn.botpress.cloud/webchat/v2.2/inject.js"></script>
//           <script src="https://files.bpcontent.cloud/2025/02/03/17/20250203175504-BVV8F5FM.js"></script>
//           <script>
//             window.botpress.init({
//               "botId": "d3aea06d-0f04-4701-bec3-b457caf79902",
//               "configuration": {
//                 "website": {},
//                 "email": {},
//                 "phone": {},
//                 "termsOfService": {},
//                 "privacyPolicy": {},
//                 "color": "#3B82F6",
//                 "variant": "solid",
//                 "themeMode": "light",
//                 "fontFamily": "inter",
//                 "radius": 1
//               },
//               "clientId": "cfb8683e-69a6-4d97-acd3-10a5e8f52e16"
//             });
//           </script>
//         </body>
//         </html>
//       ''')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) {
//             setState(() {
//               _isLoading = false;
//             });
//           },
//         ),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         if (_isExpanded)
//           Container(
//             width: 400,
//             height: 600,
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Stack(
//                 children: [
//                   WebViewWidget(controller: _controller),
//                   if (_isLoading)
//                     const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _isExpanded = !_isExpanded;
//             });
//           },
//           backgroundColor: const Color(0xFF630A00),
//           child: Icon(
//             _isExpanded ? Icons.close : Icons.chat_bubble,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class ChatbotWidget extends StatelessWidget {
  const ChatbotWidget({Key? key}) : super(key: key);

  void _showChatDialog(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ahana',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF630A00),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                          color: const Color(0xFF630A00),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Chat content area
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF630A00),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Loading...',
                              style: TextStyle(
                                color: Color(0xFF630A00),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showChatDialog(context),
      backgroundColor: const Color(0xFF630A00),
      child: const Icon(
        Icons.chat_bubble,
        color: Colors.white,
      ),
    );
  }
}
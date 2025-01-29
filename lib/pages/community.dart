import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final TextEditingController _postController = TextEditingController();
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'Aarav Sharma',
      'location': 'Bangalore, India',
      'content': '"The whole secret of existence lies in the pursuit of meaning, purpose, and connection..."',
      'likes': 120,
      'comments': 45,
      'liked': false,
    },
    {
      'username': 'Emily Davis',
      'location': 'New York, USA',
      'content': '"Self-discovery is the key to personal growth and fulfillment..."',
      'likes': 98,
      'comments': 30,
      'liked': false,
    },
  ];

  void _addPost() {
    if (_postController.text.isNotEmpty) {
      setState(() {
        posts.insert(0, {
          'username': 'You',
          'location': 'Your Location',
          'content': _postController.text,
          'likes': 0,
          'comments': 0,
          'liked': false,
        });
      });
      _postController.clear();
    }
  }

  void _toggleLike(int index) {
    setState(() {
      if (posts[index]['liked']) {
        posts[index]['likes']--;
      } else {
        posts[index]['likes']++;
      }
      posts[index]['liked'] = !posts[index]['liked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFEFE7CA), // Background color
        appBar: AppBar(
          title: const Text('Community', style: TextStyle(color: Color(0xFF630A00), fontWeight: FontWeight.bold, fontSize: 22)),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container( // Entire page background color
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _postController,
                        decoration: InputDecoration(
                          hintText: "Write your post here",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _addPost,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                      child: const Text('Publish', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFAAAAAA).withOpacity(0.6), // Light grey with opacity
                            Color(0xFFAAAAAA).withOpacity(0.6), // Same light grey with opacity
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.brown,
                                child: Text(post['username'][0], style: TextStyle(color: Colors.black)),
                              ),
                              title: Text(post['username'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(post['location']),
                            ),
                            Text(post['content'], style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        post['liked'] ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => _toggleLike(index),
                                    ),
                                    Text('${post['likes']}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.comment, color: Colors.blue),
                                      onPressed: () {},
                                    ),
                                    Text('${post['comments']}'),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.share, color: Colors.green),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
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
      'username': 'Hemashree',
      'location': 'Karnataka, India',
      'content': '"The whole secret of existence lies in the pursuit of meaning, purpose, and connection..."',
      'likes': 120,
      'comments': [],
      'liked': false,
      'showCommentField': false,
      'shared': false,
    },
    {
      'username': 'Anshika',
      'location': 'Uttar Pradesh, India',
      'content': '"Self-discovery is the key to personal growth and fulfillment..."',
      'likes': 98,
      'comments': [],
      'liked': false,
      'showCommentField': false,
      'shared': false,
    },
    {
      'username': 'Nithya',
      'location': 'Tamil Nadu, India',
      'content': '"Every moment is a fresh beginning..."',
      'likes': 76,
      'comments': [],
      'liked': false,
      'showCommentField': false,
      'shared': false,
    },
  ];

  void _addPost() {
    if (_postController.text.isNotEmpty) {
      setState(() {
        posts.add({
          'username': 'You',
          'location': 'Bangalore, India',
          'content': _postController.text,
          'likes': 0,
          'comments': [],
          'liked': false,
          'showCommentField': false,
          'shared': false,
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

  void _addComment(int index, String comment) {
    if (comment.isNotEmpty) {
      setState(() {
        posts[index]['comments'].add(comment);
        posts[index]['showCommentField'] = false;
      });
    }
  }

  void _toggleCommentField(int index) {
    setState(() {
      posts[index]['showCommentField'] = !posts[index]['showCommentField'];
    });
  }

  void _deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });
  }

  void _sharePost(int index) {
    setState(() {
      posts.add({
        'username': 'You (Shared)',
        'location': 'Bangalore, Karnataka',
        'content': 'Shared: ${posts[index]['content']}',
        'likes': 0,
        'comments': [],
        'liked': false,
        'showCommentField': false,
        'shared': true,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post shared successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFEFE7CA),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    'Community',
                    style: TextStyle(
                      color: Color(0xFF630A00), // Title color
                      fontSize: 25,              // Font size
                      fontWeight: FontWeight.bold, // Font weight
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  reverse: false,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF630A00),
                          width: 2.5, // Border width
                        ),
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
                                child: Text(post['username'][0],
                                    style: const TextStyle(color: Colors.black)),
                              ),
                              title: Text(post['username'],
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(post['location']),
                              trailing: post['username'].startsWith('You')
                                  ? IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deletePost(index),
                              )
                                  : null,
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
                                    const SizedBox(width: 16),
                                    IconButton(
                                      icon: const Icon(Icons.comment, color: Colors.blue),
                                      onPressed: () => _toggleCommentField(index),
                                    ),
                                    Text('${post['comments'].length}'),
                                    const SizedBox(width: 16),
                                    if (!post['shared'])
                                      IconButton(
                                        icon: const Icon(Icons.share, color: Colors.green),
                                        onPressed: () => _sharePost(index),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            if (post['showCommentField'])
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintText: 'Write a comment...',
                                          border: OutlineInputBorder(),
                                        ),
                                        onSubmitted: (value) => _addComment(index, value),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (post['comments'].isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Comments:',
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    ...post['comments'].map((comment) => Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                      child: Text('- $comment'),
                                    )).toList(),
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
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFEFE7CA),  // Matches background color
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _postController,
                        decoration: InputDecoration(
                          hintText: "Write your post here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.brown),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.brown),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.brown),
                          ),
                          fillColor: Color(0xFFEFE7CA),  // Matches background color
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _addPost,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF640000),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Post', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
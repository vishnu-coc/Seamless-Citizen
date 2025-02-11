import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Define a sample list of posts with a like count
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'user1',
      'profilePic': 'assets/a.png',
      'postPic': 'assets/image-3.webp',
      'likeCount': 0,
      'comment':
          '#primeminister #india #narendramodi #bjp #modi #imrankhan #covid #pm #news #politics #indian #pmmodi #primeministerofindia #delhi #amitshah #modiji #pakistan #pti #congress '
    },
    {
      'username': 'user2',
      'profilePic': 'assets/a.png',
      'postPic': 'assets/indian2.jpg',
      'likeCount': 0,
      'comment':
          ' #indianarmy #india #army #indianairforce #indiannavy #indian #jaihind #bsf #instagram #love #crpf #indianarmylovers #armylife #commando'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(post['profilePic']!),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post['username']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Post Image centered
              Center(
                child: GestureDetector(
                  onDoubleTap: () {
                    debugPrint("Image double-tapped"); // Debug statement
                    // Handle double-tap to like
                    setState(() {
                      post['likeCount'] = (post['likeCount'] ?? 0) + 1;
                    });
                  },
                  child: Image.asset(post['postPic']!),
                ),
              ),
              // Actions
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        setState(() {
                          // Ensure likeCount is not null before incrementing
                          post['likeCount'] = (post['likeCount'] ?? 0) + 1;
                        });
                      },
                    ),
                    Text('${post['likeCount']} likes'),
                  ],
                ),
              ),
              // Caption
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  post['comment']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}

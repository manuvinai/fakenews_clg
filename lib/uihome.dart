import 'package:fakenews/view_my_post.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blueAccent,
        hintColor: Colors.orange,
        bottomAppBarColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(),
    UsersPage(),
    CreatePostPage(),
    FriendsPage(),
    ProfilePage(),
    FriendRequestPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialNet'),
        actions: [
          // Accept Friend Request Button
          IconButton(
            icon: Icon(Icons.person_add_alt_1),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendRequestPage()),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.menu),
            onSelected: (value) {
              if (value == 'complaints') {
                _showComplaintsDialog(context);
              } else if (value == 'feedback') {
                _showFeedbackDialog(context);
              } else if (value == 'logout') {
                _showLogoutDialog(context);
              } else if (value == 'view_my_posts') {
                _navigateToMyPostsPage(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'complaints',
                child: Row(
                  children: [
                    Icon(Icons.report, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Complaints'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'feedback',
                child: Row(
                  children: [
                    Icon(Icons.feedback, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Feedback'),
                  ],
                ),
              ),
              // New "View My Posts" item
              PopupMenuItem<String>(
                value: 'view_my_posts',
                child: Row(
                  children: [
                    Icon(Icons.post_add, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('View My Posts'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'View Users'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Create Post'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'View Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
    );
  }

  void _showComplaintsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Complaints'),
          content: Text('You can submit your complaints here.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Feedback'),
          content: Text('You can submit your feedback here.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Logout'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Navigate to My Posts page
  void _navigateToMyPostsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyPostsPage()),
    );
  }
}


class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search for friends...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        // Example Post Section (Replace with real data)
        PostCard(
          username: 'User1',
          content: 'Check out my new post! Loving the weather today.',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        PostCard(
          username: 'User2',
          content: 'Had an amazing weekend with friends!',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        PostCard(
          username: 'User3',
          content: 'Exploring new places, so much to see!',
          imageUrl: 'https://via.placeholder.com/150',
        ),
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String content;
  final String imageUrl;

  PostCard({required this.username, required this.content, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                SizedBox(width: 10),
                Text(
                  username,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(content),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up_alt_outlined)),
                IconButton(onPressed: () {}, icon: Icon(Icons.comment_outlined)),
                IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Users Page'),
    );
  }
}

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Create Post Page'),
    );
  }
}

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Friends Page'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}

class FriendRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Friend Requests'),
    );
  }
}

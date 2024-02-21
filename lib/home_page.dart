import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);


  final List<String> choreographers = [
    'Dharmik Samani',
    'Shezhaan khan',
    'Himanshu Dulani',
    // Add more choreographers here
  ];

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border), // Heart icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LikedSongsPage(), // Navigate to the Liked Songs page
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    user: User(
                      username: 'username', // Replace with actual username
                      email: 'email', // Replace with actual email
                      number: 'number', // Replace with actual number
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),

            ListTile(
              title: Text('Tutorial'),
              onTap: () {
                // Navigate to the Tutorial page
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Songs'),
              onTap: () {
                // Navigate to the Songs page
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Choreographers'),
              onTap: () {
                // Navigate to the Choreographers page
                Navigator.pop(context);
              },
            ),
            // Add more menu items here
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: choreographers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(choreographers[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChoreographerPage(
                    choreographer: choreographers[index],
                    videoPath: 'C:/Users/Admin/StudioProjects/untitled1/assets', // Replace with the actual path
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class User {
  final String username;
  final String email;
  final String number;

  User({
    required this.username,
    required this.email,
    required this.number,
  });
}

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({Key? key, required this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius:   50,
                // You can replace this with an actual image if you have one
                backgroundImage: AssetImage('assets/images/default_profile.png'),
              ),
              SizedBox(height:   15), // Space between picture and username
              Text(user.username), // Replace with actual username
              SizedBox(height:   15), // Space between username and email
              Text(user.email), // Replace with actual email
              SizedBox(height:   15), // Space between email and number
              Text(user.number), // Replace with actual number
              SizedBox(height:   15), // Space between number and videos watched
              Text('Videos Watched:   0'), // Replace with actual videos watched count
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Handle logout logic here
                },
                child: Text('Log Out', style: TextStyle(fontSize:   12)),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ChoreographerPage extends StatefulWidget {
  var choreographer;

  var videoPath;

   ChoreographerPage({Key? key, required this.choreographer, required this.videoPath}) : super(key: key);

  @override
  State<ChoreographerPage> createState() => _ChoreographerPageState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}

class _ChoreographerPageState extends State<ChoreographerPage> {

  get index => null;
  late final String choreographer;
  late final String videoPath; // Path to the video file
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset((widget.videoPath))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.choreographer),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );

  }
}
class LikedSongsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Videos'),
      ),
      body: Center(
        child: Text('Videos you have liked'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';





class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);


  final List<String> choreographers = [
    'Dharmik Samani',
    'Shezhaan khan',
    'Himanshu Dulani',
    // Add more choreographers here
  ];

  final String title;
  final TextEditingController _searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search choreographers",
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            // Implement search logic here
            // For example, you could filter the choreographers list based on the user's input
            // This is a simplified example and does not actually filter the list
            choreographers.where((choreographer) => choreographer.toLowerCase().contains(value.toLowerCase()));
          },
        ),
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
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share('Check out this amazing choreography!');
            },
          ),

        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu', style : TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ),
              decoration: BoxDecoration(
                color: Colors.pink,
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
      body:
      Center(
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
                onPressed: () async {
                  // Show confirmation dialog
                  final bool confirm = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Logout'),
                        content: Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirm) {
                    // Handle logout logic here
                    signOut(context);
                  }
                },
                child: Text('Log Out', style: TextStyle(fontSize:  12)),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> signOut(BuildContext context) async {
    // Navigate to login screen or home screen after logout
    //Navigator.pushReplacementNamed(context, '/login'); // Adjust the route as necessary
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
class ChoreographerPage extends StatefulWidget {
  var choreographer;
  var videoPath;

  ChoreographerPage({Key? key, required this.choreographer, required this.videoPath}) : super(key: key);

  @override
  State<ChoreographerPage> createState() => _ChoreographerPageState();
}

class _ChoreographerPageState extends State<ChoreographerPage> {
  late final String choreographer;
  late final String videoPath; // Path to the video file
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/dmk.mp4');
    _controller = VideoPlayerController.asset('assets/Hmd.mp4');
    _controller = VideoPlayerController.asset('assets/Shk.mp4')

      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      }).catchError((error) {
        // Handle the error
        print("Error initializing video player: $error");
      });
    child: FittedBox(
      fit: BoxFit.cover, // Use BoxFit.cover to ensure the video covers the available space without distorting its aspect ratio
      child: SizedBox(
        width: double.infinity, // Ensure the FittedBox takes the full width of its parent
        height: double.infinity, // Ensure the FittedBox takes the full height of its parent
        child: VideoPlayer(_controller),
      ),
    );

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : const CircularProgressIndicator(),
            SizedBox(height:  10), // Space between video player and rating bar
            RatingBar.builder(
              initialRating:  3,
              minRating:  1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount:  5,
              itemPadding: EdgeInsets.symmetric(horizontal:  4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                // Handle rating update
                print("Rating: $rating");
              },
            ),
          ],
        ),
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
class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Slidable Example'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              title: Text('Item $index'),
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Archive',
                color: Colors.blue,
                icon: Icons.archive,
                onTap: () => print('Archive'),
              ),
              IconSlideAction(
                caption: 'Share',
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () => print('Share'),
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'More',
                color: Colors.black45,
                icon: Icons.more_horiz,
                onTap: () => print('More'),
              ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => print('Delete'),
              ),
            ],
          );
        },
      ),
    );
  }
}
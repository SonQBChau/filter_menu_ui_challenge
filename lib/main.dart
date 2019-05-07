import 'package:flutter/material.dart';
import 'package:filter_menu_ui_challenge/task_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildTimeline(),
          buildClippedHero(),
          buildHeader(),
          buildProfileRow(),
          buildMainBody(),

        ],
      ),
    );
  }

  Container buildMainBody() {
    final tasks = TaskList();
    return Container(
          padding: EdgeInsets.only(top: 256),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My Task',
                      style: TextStyle(fontSize: 34),
                    ),
                    Text(
                      'FEBRUARY 8, 2019',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              tasks.buildTasksList(),
            ],
          ),
        );
  }

  Container buildProfileRow() {
    return Container(
      padding: new EdgeInsets.only(left: 16.0, top: 256 / 2.5),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: AssetImage('images/avatar.jpg'),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Ryan Barnes',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Product Designer',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white54,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            'Timeline',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          )),
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white54,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  ClipPath buildClippedHero() {
    return ClipPath(
        clipper: DiagonalClipper(),
        child: Image.asset(
          'images/birds.jpg',
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.srcOver,
          color: Color.fromARGB(120, 20, 10, 40),
        ));
  }
}

Widget _buildTimeline() {
  return Positioned(
    top: 0.0,
    bottom: 0.0,
    left: 32.0,
    child: new Container(
      width: 1.0,
      color: Colors.grey[300],
    ),
  );
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 60.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

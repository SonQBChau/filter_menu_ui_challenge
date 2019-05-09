import 'package:filter_menu_ui_challenge/animated_fab.dart';
import 'package:filter_menu_ui_challenge/circle_wheel_scroll_view.dart';
import 'package:filter_menu_ui_challenge/list_model.dart';
import 'package:filter_menu_ui_challenge/numbers_list.dart';
import 'package:filter_menu_ui_challenge/radial_list.dart';
import 'package:filter_menu_ui_challenge/task_row.dart';
import 'package:flutter/material.dart';
import 'package:filter_menu_ui_challenge/task_list.dart';

/*
https://github.com/MarcinusX/flutter_ui_challenge_filter_menu
*/

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
//  RadialListViewModel radialList;

//  MyHomePage({
//    @required this.radialList
//  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel listModel;
  bool showOnlyCompleted = false;
  final double _imageHeight = 256;

  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, tasks);
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: new AnimatedList(
        initialItemCount: tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget _buildFab() {
    return new Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        right: MediaQuery.of(context).size.width * 0.25,
        child: new AnimatedFab(
          onClick: _changeFilterState,
        ));
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }

  Widget _buildItem(int i) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 40,
          color: Colors.blue[100 * ((i % 8) + 1)],
          child: Center(
            child:
            Text(i.toString(),),
          ),
        ),
      ),
    );
  }


  Widget _buildItemIcon(Color color, IconData ico) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 40,
          color: color,
          child: Center(
            child:
            Icon(ico, color: Colors.white),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildTimeline(),
            buildClippedHero(),
            buildHeader(),
            buildProfileRow(),
            buildMainBody(),
//          _buildFab(),

            buildCircleMenu(),




          ],
        ),


//        bottomNavigationBar: AnimatedFab(
//          onClick: _changeFilterState,
//        ),
      ),
    );
  }

  Container buildMainBody() {
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
          _buildTasksList(),
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

  buildCircleMenu() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.85,
      right: MediaQuery.of(context).size.width * 0.15,
      child: Center(
        child: Container(
          height: 100,
          width: 260,
          decoration: BoxDecoration(color:Colors.yellow),
          child: CircleListScrollView(
            physics: CircleFixedExtentScrollPhysics(),
            axis: Axis.horizontal,
            itemExtent: 40,
//            children: List.generate(10, _buildItem),
            children: buildListIcons(),
            radius: MediaQuery.of(context).size.width * 0.25,
          ),
        ),
      ),
    );
  }

  List <Widget> buildListIcons() {
    List<Widget> iconList = [];

    iconList.add(_buildItemIcon(Colors.red, Icons.camera));
    iconList.add(_buildItemIcon(Colors.red, Icons.category));
    iconList.add(_buildItemIcon(Colors.red, Icons.more_horiz));
    iconList.add(_buildItemIcon(Colors.red, Icons.menu));
    iconList.add(_buildItemIcon(Colors.red, Icons.favorite));
    iconList.add(_buildItemIcon(Colors.red, Icons.beenhere));
    iconList.add(_buildItemIcon(Colors.red, Icons.notifications));
    iconList.add(_buildItemIcon(Colors.red, Icons.group));

    return iconList;
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

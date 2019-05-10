import 'dart:math' as math;

import 'package:filter_menu_ui_challenge/circle_wheel_scroll_view.dart';
import 'package:flutter/material.dart';

class AnimatedCircle extends StatefulWidget {
  final VoidCallback onClick;

  const AnimatedCircle({Key key, this.onClick}) : super(key: key);

  @override
  _AnimatedCircleState createState() => new _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  final double expandedSize = 180.0;
//  final double expandedSize = 500.0;
  final double hiddenSize = 20.0;


  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: expandedSize,
      height: expandedSize,
      child: new AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return new Stack(
            alignment: Alignment.center,
            children: <Widget>[
//              _buildExpandedBackground(),
//              _buildOption(Icons.check_circle, 0.0),
//              _buildOption(Icons.flash_on, -math.pi / 3),
//              _buildOption(Icons.access_time, -2 * math.pi / 3),
//              _buildOption(Icons.category, math.pi),
              _buildCircle(),
              _buildFabCore(),




            ],
          );
        },
      ),
    );
  }

  Widget _buildOption(IconData icon, double angle) {
    if (_animationController.isDismissed) {
      return Container();
    }
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: new IconButton(
            onPressed: _onIconClick,
            icon: new Transform.rotate(
              angle: -angle,
              child: new Icon(
                icon,
                color: Colors.white,
              ),
            ),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedBackground() {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return new Container(
      height: size,
      width: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  Widget _buildFabCore() {
    double scaleFactor = 2 * (_animationController.value - 0.5).abs();
    return new FloatingActionButton(
      onPressed: _onFabTap,
      child: new Transform(
        alignment: Alignment.center,
        transform: new Matrix4.identity()..scale(1.0, scaleFactor),
        child: new Icon(
          _animationController.value > 0.5 ? Icons.close : Icons.filter_list,
          color: Colors.white,
          size: 26.0,
        ),
      ),
      backgroundColor: _colorAnimation.value,
    );
  }

  open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  _onFabTap() {
    if (_animationController.isDismissed) {
      open();
    } else {
      close();
    }
  }

  _onIconClick() {
    widget.onClick();
    close();
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

  _buildCircle() {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * _animationController.value ;

    return Center(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color:Colors.yellow),
        child: CircleListScrollView(
          physics: CircleFixedExtentScrollPhysics(),
          axis: Axis.horizontal,
          itemExtent: 40,
//            children: List.generate(10, _buildItem),
          children: buildListIcons(),
          radius: MediaQuery.of(context).size.width * 0.20,
        ),
      ),
    );
  }
}

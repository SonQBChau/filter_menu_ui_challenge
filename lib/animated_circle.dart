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
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  Animation<Offset> _positionAnimation;

  final double expandedSize = 180.0;
  final double expandedWidthSize = 300.0;
  final double expandedHeightSize = 180.0;
//  final double hiddenSize = 20.0;
  final double hiddenSize = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_animationController);
    _positionAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: expandedWidthSize,
      height: expandedHeightSize,
      child: new AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildCircle(),
              Positioned(
                bottom:0,
                child:_buildFabCore(),
              ),
            ],
          );
        },
      ),
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
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 50,
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
//    double size =
//        hiddenSize + (expandedSize - hiddenSize) * _animationController.value ;
    double widthSize = expandedWidthSize * _animationController.value;
    double heightSize = expandedHeightSize * _animationController.value;
    double itemSize = 1+ 40 * _animationController.value;
    double radiusSize = 1+ MediaQuery.of(context).size.width * 0.25 * _animationController.value;



//    return Center(
//      child: Container(
////        height: heightSize,
////        width: widthSize,
//        decoration: BoxDecoration(color:Colors.yellow),
//        child: CircleListScrollView(
//          physics: CircleFixedExtentScrollPhysics(),
//          axis: Axis.horizontal,
//          itemExtent: itemSize,
//          children: buildListIcons(),
//          radius: radiusSize,
//        ),
//      ),
//    );

  return Center(
    child: SlideTransition(
        position: _positionAnimation,
        child: Container(
        decoration: BoxDecoration(color:Colors.yellow),
        child: CircleListScrollView(
          physics: CircleFixedExtentScrollPhysics(),
          axis: Axis.horizontal,
          itemExtent: 50,
          children: buildListIcons(),
          radius: MediaQuery.of(context).size.width * 0.35,
        ),
        ),
    ),
  );
  }
}

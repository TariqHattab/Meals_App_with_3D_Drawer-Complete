import 'package:flutter/material.dart';

import 'package:meals_app_2/screens/filters_screen/filters_screen.dart';
import 'package:meals_app_2/screens/tap_bar_screen/tap_bar_screen.dart';
import 'dart:math' as math;
import 'package:meals_app_2/main_drawer.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  double width = WidgetsBinding.instance.window.physicalSize.width /
      WidgetsBinding.instance.window.devicePixelRatio;
  static const Duration toggleDuration = Duration(milliseconds: 250);
  double maxSlide;
  double minDragStartEdge;
  double maxDragStartEdge;
  int index = 0;

  AnimationController _animationController;

  bool _canBeDragged = false;

  var myDrawer;
  var myChild;

  @override
  void initState() {
    super.initState();
    myDrawer = MainDrawer(setIndex: setIndex);
    myChild = [
      TapBarScreen(
        toggle: toggle,
      ),
      FiltersScreen(
        setIndex: setIndex,
      )
    ];
    _animationController = AnimationController(
      vsync: this,
      duration: _CustomDrawerState.toggleDuration,
    );
  }

  void toggle() {
    _animationController.isCompleted ? close() : open();
  }

  void setIndex([int i = 0, bool isOpen = false]) {
    setState(() {
      index = i;
    });
    isOpen ? open() : close();
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragOpenFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = isDragOpenFromLeft || isDragOpenFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    maxSlide = (width * .834).roundToDouble();
    minDragStartEdge = (width * .167).roundToDouble();
    maxDragStartEdge = maxSlide - (width * .045).roundToDouble();

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _animationController,
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 700), child: myChild[index]),
        builder: (context, ch) {
          var animValue = _animationController.value;

          return Stack(
            children: [
              Container(
                color: Colors.pink[200],
              ),
              Transform.translate(
                offset: Offset(maxSlide * (animValue - 1), 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(math.pi / 2 * (1 - animValue)),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: _animationController.isCompleted ? close : null,
                      child: myDrawer),
                ),
              ),
              Transform.translate(
                offset: Offset(maxSlide * animValue, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-math.pi * animValue / 2),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: _animationController.isCompleted ? close : null,
                      child: ch),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:meals_app_2/screens/filters_screen/filters_screen.dart';
import 'package:meals_app_2/screens/tap_bar_screen/tap_bar_screen.dart';

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
    print('init $width - $maxSlide - $minDragStartEdge - $maxDragStartEdge');
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    maxSlide = (width * .625).roundToDouble();
    minDragStartEdge = (width * .167).roundToDouble();
    maxDragStartEdge = maxSlide - (width * .045).roundToDouble();
    //print('build $width - $maxSlide - $minDragStartEdge - $maxDragStartEdge');

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _animationController,
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 700), child: myChild[index]),
        builder: (context, ch) {
          print(
              'animatedbuild $width - $maxSlide - $minDragStartEdge - $maxDragStartEdge');
          var animValue = _animationController.value;
          double slide = maxSlide * animValue;
          double scale = 1 - (animValue * .3);
          return Stack(
            children: [
              myDrawer,
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale, scale),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: _animationController.isCompleted ? close : null,
                    child: ch),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  final Function setIndex;

  const MainDrawer({Key key, this.setIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.only(left: 15, top: 15),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            )),
        ListTile(
          leading: Icon(Icons.restaurant, size: 30),
          title: Text('Categories', style: TextStyle(fontSize: 20)),
          onTap: () {
            // Navigator.of(context).pushReplacementNamed('/');
            setIndex(0);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, size: 30),
          title: Text('Filters', style: TextStyle(fontSize: 20)),
          onTap: () {
            // Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            setIndex(1);
          },
        ),
      ]),
    );
  }
}

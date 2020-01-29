import 'dart:ui';
import 'package:bryant/providers/gyroscope_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bryant extends StatefulWidget {
  @override
  _BryantState createState() => _BryantState();
}

class _BryantState extends State<Bryant> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double _manX;
  double _manY;
  double _offsetX;
  double _offsetY;
  double _gyroX;
  double _gyroY;

  @override
  void initState() {
    super.initState();
    _manX = 0.0;
    _manY = 0.0;
    _offsetX = 0.0;
    _offsetY = 0.0;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            if (_controller.isCompleted) {
              setState(() {
                _offsetX = _gyroX - _manX;
                _offsetY = _gyroY - _manY;
                _manX = _gyroX;
                _manY = _gyroY;
              });
              _controller.reset();
              _controller.forward();
            }
          });
    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var gProvider = Provider.of<GyroScopeProvider>(context);
    _gyroX = gProvider.x;
    _gyroY = gProvider.y;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // wall
          Container(child: Wall()),

          // Text:24
          Align(
            alignment: Alignment(-0.65, -0.1),
            child: Text(
              '24',
              style: TextStyle(
                fontSize: 150,
                fontFamily: 'Bangers',
                color: Colors.yellowAccent,
              ),
            ),
          ),

          // Text:Brynt
          Align(
            alignment: Alignment(-0.55, 0.09),
            child: Text(
              'bryant',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Bangers',
                color: Colors.blueGrey[600],
              ),
            ),
          ),

          // IMG:shadow
          Align(
            alignment: Alignment(
                -(_manX + ((_offsetX * _animation.value) * 0.5) + 0.05),
                (_manY + ((_offsetY * _animation.value)) * 0.5) + 0.15),
            child: IMGShadow(),
          ),

          // IMG:bryant
          Align(
            alignment: Alignment(_manX + (_offsetX * _animation.value),
                -(_manY + (_offsetY * _animation.value))),
            child: IMG(),
          ),
        ],
      ),
    );
  }
}

class IMG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/bryant.png',
    );
  }
}

class IMGShadow extends StatelessWidget {
  final double opacity;
  IMGShadow({this.opacity = 0.3});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/bryant.png',
      color: Colors.black.withOpacity(opacity),
    );
  }
}

class Wall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Image.asset(
        'assets/images/wall.jpg',
        fit: BoxFit.fill,
        colorBlendMode: BlendMode.multiply,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';

class RateStar extends StatelessWidget {
  final double rate;
  final double min;
  final double max;
  final bool labled;
  final Color lableColor;
  final double size;
  final MainAxisAlignment mainAxisAlignment;

  RateStar(
    this.rate, {
    this.min = 0.0,
    this.max = 10.0,
    this.labled = true,
    this.lableColor = Colors.grey,
    this.size = 14,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildContainer());
  }

  Container _buildContainer() {
    return Container(
      child: Row(
        mainAxisAlignment: this.mainAxisAlignment,
        children: _build5Stars(),
      ),
    );
  }

  List<Widget> _build5Stars() {
    return <Widget>[
      _buildStar(1),
      _buildStar(2),
      _buildStar(3),
      _buildStar(4),
      _buildStar(5),
      Text(
        labled ? rate.toString() : "",
        style: TextStyle(
          color: this.lableColor,
          fontSize: this.size,
        ),
      ),
    ];
  }

  Widget _buildStar(int index) {
    double range = (max - min) / 5;
    double top = range * index.toDouble();
    double bottom = range * (index.toDouble() - 1);
    return Icon(
      rate >= top ? Icons.star : rate > bottom ? Icons.star_half : Icons.star_border,
      size: size,
      color: rate >= top
          ? ThemeBloc.colors['orange']
          : rate > bottom ? ThemeBloc.colors['orangeAccent'] : ThemeBloc.colors['black'],
    );
  }
}

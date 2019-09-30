import 'package:flutter/material.dart';

class RateStar extends StatelessWidget {
  final double _size = 14;
  final double _rate;
  RateStar(this._rate);

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildContainer());
  }

  Container _buildContainer() {
    return Container(
      child: Row(
        children: _buildStars(),
      ),
    );
  }

  List<Widget> _buildStars() {
    return <Widget>[
      Icon(
        _rate >= 2
            ? Icons.star
            : _rate > 0 ? Icons.star_half : Icons.star_border,
        size: _size,
        color: _rate >= 2
            ? Colors.orange
            : _rate > 0 ? Colors.orangeAccent : Colors.black,
      ),
      Icon(
        _rate >= 4
            ? Icons.star
            : _rate > 2 ? Icons.star_half : Icons.star_border,
        size: _size,
        color: _rate >= 4
            ? Colors.orange
            : _rate > 2 ? Colors.orangeAccent : Colors.black,
      ),
      Icon(
        _rate >= 6
            ? Icons.star
            : _rate > 4 ? Icons.star_half : Icons.star_border,
        size: _size,
        color: _rate >= 6
            ? Colors.orange
            : _rate > 4 ? Colors.orangeAccent : Colors.black,
      ),
      Icon(
        _rate >= 8
            ? Icons.star
            : _rate > 6 ? Icons.star_half : Icons.star_border,
        size: _size,
        color: _rate >= 8
            ? Colors.orange
            : _rate > 6 ? Colors.orangeAccent : Colors.black,
      ),
      Icon(
        _rate >= 10
            ? Icons.star
            : _rate > 8 ? Icons.star_half : Icons.star_border,
        size: _size,
        color: _rate >= 10
            ? Colors.orange
            : _rate > 8 ? Colors.orangeAccent : Colors.black,
      ),
      Text(_rate.toString()),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MaxLinesText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle style;
  final TextStyle unfoldTextStyle;
  final Color unfoldArrowColor;
  MaxLinesText({
    Key key,
    @required this.text,
    this.maxLines = 4,
    this.style,
    this.unfoldTextStyle,
    this.unfoldArrowColor,
  }) : super(key: key);

  _MaxLinesTextState createState() => _MaxLinesTextState();
}

class _MaxLinesTextState extends State<MaxLinesText> {
  var _isFolded = true;
  @override
  Widget build(BuildContext context) {
    return _buildText(this.widget.text);
  }

  Widget _buildText(String text) {
    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(text: text);
      final tp = TextPainter(
        text: span,
        maxLines: this.widget.maxLines,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: size.maxWidth);
      if (tp.didExceedMaxLines) {
        return Column(
          children: _buildChildren(text),
        );
      } else {
        return Text(
          text,
          style: this.widget.style,
        );
      }
    });
  }

  List<Widget> _buildChildren(text) {
    List<Widget> list = [];
    list.add(Text(
      text,
      maxLines: this._isFolded ? this.widget.maxLines : 10000,
      overflow: TextOverflow.ellipsis,
      style: this.widget.style,
    ));
    if (this._isFolded) {
      list.add(GestureDetector(
        onTap: () {
          if (mounted)
            setState(() {
              this._isFolded = false;
            });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              LabelConstant.MOVIE_UNFOLD,
              style: this.widget.unfoldTextStyle,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: this.widget.unfoldArrowColor,
            ),
          ],
        ),
      ));
    }
    return list;
  }
}

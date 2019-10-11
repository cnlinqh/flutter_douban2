import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieCategoryFilterBar extends StatefulWidget {
  MovieCategoryFilterBar({Key key}) : super(key: key);

  _MovieCategoryFilterBarState createState() => _MovieCategoryFilterBarState();
}

class _MovieCategoryFilterBarState extends State<MovieCategoryFilterBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          showBottomSheet(
            context: context,
            builder: (_) => Stack(
              children: <Widget>[
                _buildBottomSheetContent(),
                Positioned(
                  top: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                  right: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          );
        },
        child: Text("筛选..."),
      ),
    );
  }

  Widget _buildBottomSheetContent() {
    return Container(
      height: ScreenUtil.screenHeight,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print("ClickMe");
              },
              child: Text(
                "影片信息",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

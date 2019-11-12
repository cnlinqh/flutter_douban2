import 'package:flutter/material.dart';
import 'package:flutter_douban2/model/mine_settings_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:flutter_douban2/util/repository.dart';

class MinePage extends StatefulWidget {
  MinePage({
    Key key,
    String title,
  }) : super(key: key);

  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('设置'),
      actions: <Widget>[
        Consumer<MineSettingsModel>(
          builder: (context, settings, widget) {
            return IconButton(
              icon: Icon(Icons.restore),
              onPressed: () {
                settings.restore();
                final snackBar = new SnackBar(content: new Text('Settings are restored!'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
            );
          },
        )
      ],
    );
  }

  Widget _buildBody() {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Container(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
                  child: Text(
                    '相册设置:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ),
                Consumer<MineSettingsModel>(
                  builder: (context, settings, child) {
                    return Row(
                      children: <Widget>[
                        Text('竖屏浏览列数:'),
                        Slider(
                          value: settings.photoColumnsNumPortait.toDouble(),
                          label: '${settings.photoColumnsNumPortait}',
                          min: 1.0,
                          max: 10.0,
                          divisions: 9,
                          onChanged: (value) {
                            settings.setPhotoColumnsNumPortait(value.toInt());
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ),
                Consumer<MineSettingsModel>(
                  builder: (context, settings, child) {
                    return Row(
                      children: <Widget>[
                        Text('横屏浏览列数:'),
                        Slider(
                          value: settings.photoColumnsNumLandscape.toDouble(),
                          label: '${settings.photoColumnsNumLandscape}',
                          min: 1.0,
                          max: 10.0,
                          divisions: 9,
                          onChanged: (value) {
                            settings.setPhotoColumnsNumLandscape(value.toInt());
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ),
                Consumer<MineSettingsModel>(
                  builder: (context, settings, child) {
                    return Row(
                      children: <Widget>[
                        Text('方格浏览列数:'),
                        Slider(
                          value: settings.photoColumnsNumSquare.toDouble(),
                          label: '${settings.photoColumnsNumSquare}',
                          min: 1.0,
                          max: 10.0,
                          divisions: 9,
                          onChanged: (value) {
                            settings.setPhotoColumnsNumSquare(value.toInt());
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ),
                Consumer<MineSettingsModel>(
                  builder: (context, settings, child) {
                    return Row(
                      children: <Widget>[
                        Text('相册图片大小:'),
                        new Radio(
                          value: 0,
                          groupValue: settings.photoSizeIndex,
                          onChanged: (value) {
                            settings.setPhotoSizeIndex(value);
                          },
                        ),
                        new Text(
                          'S',
                        ),
                        new Radio(
                          value: 1,
                          groupValue: settings.photoSizeIndex,
                          onChanged: (value) {
                            settings.setPhotoSizeIndex(value);
                          },
                        ),
                        new Text(
                          'M',
                        ),
                        new Radio(
                          value: 2,
                          groupValue: settings.photoSizeIndex,
                          onChanged: (value) {
                            settings.setPhotoSizeIndex(value);
                          },
                        ),
                        new Text(
                          'L',
                        ),
                        new Radio(
                          value: 3,
                          groupValue: settings.photoSizeIndex,
                          onChanged: (value) {
                            settings.setPhotoSizeIndex(value);
                          },
                        ),
                        new Text(
                          'XL',
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
                  child: Row(
                    children: <Widget>[
                      Text('缓存设置:', style: TextStyle(fontWeight: FontWeight.bold)),
                      FlatButton(
                        child: Text("清除缓存"),
                        onPressed: () {
                          Repository.clearCache();
                          final snackBar = new SnackBar(content: new Text('Cache is cleared!'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
                Repository.clearCache();
                final snackBar = new SnackBar(content: new Text('Settings are restored and cache is cleared!'));
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
                _buildPhotoHeader(),
                _buildDivider(),
                _buildPhotoColumnsNumPortait(),
                _buildDivider(),
                _buildPhotoColumnsNumLandscape(),
                _buildDivider(),
                _buildPhotoColumnsNumSquare(),
                _buildDivider(),
                _buildPhotoSize(),
                _buildDivider(),
                _buildCacheHeader(),
                _buildDivider(),
                _buildCacheEnabled(),
                _buildDivider(),
                _buildLogEnabled(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return SizedBox(
      height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
    );
  }

  Widget _buildPhotoHeader() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      child: Text(
        '相册设置:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPhotoColumnsNumPortait() {
    return Consumer<MineSettingsModel>(
      builder: (context, settings, child) {
        return Row(
          children: <Widget>[
            Text('竖屏浏览列数:'),
            SizedBox(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ),
            Text('${settings.photoColumnsNumPortait}'),
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
    );
  }

  Widget _buildPhotoColumnsNumLandscape() {
    return Consumer<MineSettingsModel>(
      builder: (context, settings, child) {
        return Row(
          children: <Widget>[
            Text('横屏浏览列数:'),
            SizedBox(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ),
            Text('${settings.photoColumnsNumLandscape}'),
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
    );
  }

  Widget _buildPhotoColumnsNumSquare() {
    return Consumer<MineSettingsModel>(
      builder: (context, settings, child) {
        return Row(
          children: <Widget>[
            Text('方格浏览列数:'),
            SizedBox(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ),
            Text('${settings.photoColumnsNumSquare}'),
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
    );
  }

  Widget _buildPhotoSize() {
    return Consumer<MineSettingsModel>(
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
    );
  }

  Widget _buildCacheHeader() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      child: Row(
        children: <Widget>[
          Text('缓存设置:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          RaisedButton(
            child: Text("清除缓存"),
            onPressed: () {
              Repository.clearCache();
              final snackBar = new SnackBar(content: new Text('Cache is cleared!'));
              Scaffold.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
    );
  }

  Widget _buildCacheEnabled() {
    return Consumer<MineSettingsModel>(
      builder: (context, settings, child) {
        return Row(
          children: <Widget>[
            Text('内存缓存数据:'),
            Checkbox(
              value: settings.cacheDataInMemory,
              onChanged: (value) {
                settings.setCacheDataInMemory(value);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildLogEnabled() {
    return Consumer<MineSettingsModel>(
      builder: (context, settings, child) {
        return Row(
          children: <Widget>[
            Text('日志输出:        '),
            Checkbox(
              value: settings.logEnabled,
              onChanged: (value) {
                settings.setLogEnabled(value);
              },
            )
          ],
        );
      },
    );
  }
}

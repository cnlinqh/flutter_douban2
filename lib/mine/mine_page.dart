import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
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
                _buildDivider(),
                _buildThemeHeader(),
                _buildDivider(),
                _buildPrimarySwatchList(),
                _buildDivider(),
                _buildBrightness(),
                _buildDivider(),
                _colorDisplayBox("突出颜色", "highlightColor", Theme.of(context).highlightColor),
                _buildDivider(),
                _colorDisplayBox("提示颜色", "hintColor", Theme.of(context).hintColor),
                _buildDivider(),
                _colorDisplayBox("文本选择手柄颜色", "textSelectionHandleColor", Theme.of(context).textSelectionHandleColor),
                _buildDivider(),
                _colorDisplayBox("文字选择颜色", "textSelectionColor", Theme.of(context).textSelectionColor),
                _buildDivider(),
                _colorDisplayBox("背景颜色", "backgroundColor", Theme.of(context).backgroundColor),
                _buildDivider(),
                _colorDisplayBox("强调颜色", "accentColor", Theme.of(context).accentColor),
                _buildDivider(),
                _colorDisplayBox("画布颜色", "canvasColor", Theme.of(context).canvasColor),
                _buildDivider(),
                _colorDisplayBox("卡片颜色", "cardColor", Theme.of(context).cardColor),
                _buildDivider(),
                _colorDisplayBox("按钮颜色", "buttonColor", Theme.of(context).buttonColor),
                _buildDivider(),
                _colorDisplayBox("对话框背景颜色", "dialogBackgroundColor", Theme.of(context).dialogBackgroundColor),
                _buildDivider(),
                _colorDisplayBox("禁用颜色", "disabledColor", Theme.of(context).disabledColor),
                _buildDivider(),
                _colorDisplayBox("分频器颜色", "dividerColor", Theme.of(context).dividerColor),
                _buildDivider(),
                _colorDisplayBox("错误颜色", "errorColor", Theme.of(context).errorColor),
                _buildDivider(),
                _colorDisplayBox("指示灯颜色", "indicatorColor", Theme.of(context).indicatorColor),
                _buildDivider(),
                _colorDisplayBox("原色", "primaryColor", Theme.of(context).primaryColor),
                _buildDivider(),
                _colorDisplayBox("脚手架背景颜色", "scaffoldBackgroundColor", Theme.of(context).scaffoldBackgroundColor),
                _buildDivider(),
                _colorDisplayBox("次标头颜色", "secondaryHeaderColor", Theme.of(context).secondaryHeaderColor),
                _buildDivider(),
                _colorDisplayBox("选择行颜色", "selectedRowColor", Theme.of(context).selectedRowColor),
                _buildDivider(),
                _colorDisplayBox("飞溅颜色", "splashColor", Theme.of(context).splashColor),
                _buildDivider(),
                _colorDisplayBox("未选择的控件颜色", "unselectedWidgetColor", Theme.of(context).unselectedWidgetColor),
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
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).disabledColor,
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
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).disabledColor,
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
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).disabledColor,
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
              activeColor: Theme.of(context).primaryColor,
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
              activeColor: Theme.of(context).primaryColor,
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
              activeColor: Theme.of(context).primaryColor,
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
              activeColor: Theme.of(context).primaryColor,
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
              activeColor: Theme.of(context).primaryColor,
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
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                settings.setLogEnabled(value);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildThemeHeader() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      child: Text(
        '主题颜色:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPrimarySwatchList() {
    return Wrap(
      spacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      runSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      alignment: WrapAlignment.start,
      children: _buildColorList(),
    );
  }

  List<Widget> _buildColorList() {
    List<Widget> children = [];
    for (int i = 0; i < ThemeBloc.primarySwatchList.length; i++) {
      children.add(
        GestureDetector(
          onTap: () {
            BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(primarySwatchIndex: i));
          },
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Container(
                width: kToolbarHeight - 20,
                height: kToolbarHeight - 20,
                decoration: BoxDecoration(
                  color: ThemeBloc.primarySwatchList[i],
                  borderRadius: BorderRadius.all(
                    Radius.circular(state.primarySwatchIndex == i ? kToolbarHeight : 7),
                  ),
                  border: Border.all(),
                ),
              );
            },
          ),
        ),
      );
    }

    return children;
  }

  Widget _buildBrightness() {
    return Consumer<MineSettingsModel>(
      builder: (context, settings, child) {
        return Row(
          children: <Widget>[
            Text('暗黑主题:        '),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Checkbox(
                  value: state.brightnessIndex == 1,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(brightnessIndex: value == false ? 0 : 1));
                  },
                );
              },
            )
          ],
        );
      },
    );
  }

  Widget _colorDisplayBox(String explanation, String name, Color color) {
    return Row(
      children: <Widget>[
        new Text("$explanation\n$name\n${color.toString()}\t\t"),
        new Container(
          width: kToolbarHeight - 20,
          height: kToolbarHeight - 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(kToolbarHeight)),
            border: Border.all(),
          ),
        ),
      ],
    );
  }
}

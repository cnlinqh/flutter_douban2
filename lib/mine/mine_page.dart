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
                _buildPrimaryHeader(),
                _buildDivider(),
                _buildPrimarySwatchList(),
                _buildDivider(),
                _buildSecondHeader(),
                _buildDivider(),
                _buildAccentColorList(),
                _buildDivider(),
                _buildBrightness(),
                _buildDivider(),
                _colorDisplayBox("colorScheme.primary", Theme.of(context).colorScheme.primary),
                _buildDivider(),
                _colorDisplayBox("colorScheme.onPrimary", Theme.of(context).colorScheme.onPrimary),
                _buildDivider(),
                _colorDisplayBox("colorScheme.primaryVariant", Theme.of(context).colorScheme.primaryVariant),
                _buildDivider(),
                _colorDisplayBox("colorScheme.secondary", Theme.of(context).colorScheme.secondary),
                _buildDivider(),
                _colorDisplayBox("colorScheme.onSecondary", Theme.of(context).colorScheme.onSecondary),
                _buildDivider(),
                _colorDisplayBox("colorScheme.secondaryVariant", Theme.of(context).colorScheme.secondaryVariant),
                _buildDivider(),
                _colorDisplayBox("colorScheme.surface", Theme.of(context).colorScheme.surface),
                _buildDivider(),
                _colorDisplayBox("colorScheme.onSurface", Theme.of(context).colorScheme.onSurface),
                _buildDivider(),
                _colorDisplayBox("colorScheme.background", Theme.of(context).colorScheme.background),
                _buildDivider(),
                _colorDisplayBox("colorScheme.onBackground", Theme.of(context).colorScheme.onBackground),
                _buildDivider(),
                _colorDisplayBox("primarycolorScheme.errorColor", Theme.of(context).colorScheme.error),
                _buildDivider(),
                _colorDisplayBox("colorScheme.onError", Theme.of(context).colorScheme.onError),
                _buildDivider(),
                _colorDisplayBox("primaryColor", Theme.of(context).primaryColor),
                _buildDivider(),
                _colorDisplayBox("primaryColorLight", Theme.of(context).primaryColorLight),
                _buildDivider(),
                _colorDisplayBox("primaryColorDark", Theme.of(context).primaryColorDark),
                _buildDivider(),
                _colorDisplayBox("canvasColor", Theme.of(context).canvasColor),
                _buildDivider(),
                _colorDisplayBox("accentColor", Theme.of(context).accentColor),
                _buildDivider(),
                _colorDisplayBox("scaffoldBackgroundColor", Theme.of(context).scaffoldBackgroundColor),
                _buildDivider(),
                _colorDisplayBox("bottomAppBarColor", Theme.of(context).bottomAppBarColor),
                _buildDivider(),
                _colorDisplayBox("cardColor", Theme.of(context).cardColor),
                _buildDivider(),
                _colorDisplayBox("dividerColor", Theme.of(context).dividerColor),
                _buildDivider(),
                _colorDisplayBox("focusColor", Theme.of(context).focusColor),
                _buildDivider(),
                _colorDisplayBox("hoverColor", Theme.of(context).hoverColor),
                _buildDivider(),
                _colorDisplayBox("splashColor", Theme.of(context).splashColor),
                _buildDivider(),
                _colorDisplayBox("selectedRowColor", Theme.of(context).selectedRowColor),
                _buildDivider(),
                _colorDisplayBox("unselectedWidgetColor", Theme.of(context).unselectedWidgetColor),
                _buildDivider(),
                _colorDisplayBox("disabledColor", Theme.of(context).disabledColor),
                _buildDivider(),
                _colorDisplayBox("buttonColor", Theme.of(context).buttonColor),
                _buildDivider(),
                _colorDisplayBox("secondaryHeaderColor", Theme.of(context).secondaryHeaderColor),
                _buildDivider(),
                _colorDisplayBox("textSelectionColor", Theme.of(context).textSelectionColor),
                _buildDivider(),
                _colorDisplayBox("cursorColor", Theme.of(context).cursorColor),
                _buildDivider(),
                _colorDisplayBox("textSelectionHandleColor", Theme.of(context).textSelectionHandleColor),
                _buildDivider(),
                _colorDisplayBox("backgroundColor", Theme.of(context).backgroundColor),
                _buildDivider(),
                _colorDisplayBox("dialogBackgroundColor", Theme.of(context).dialogBackgroundColor),
                _buildDivider(),
                _colorDisplayBox("indicatorColor", Theme.of(context).indicatorColor),
                _buildDivider(),
                _colorDisplayBox("hintColor", Theme.of(context).hintColor),
                _buildDivider(),
                _colorDisplayBox("errorColor", Theme.of(context).errorColor),
                _buildDivider(),
                _colorDisplayBox("toggleableActiveColor", Theme.of(context).toggleableActiveColor),
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
              activeColor: Theme.of(context).toggleableActiveColor,
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
              activeColor: Theme.of(context).toggleableActiveColor,
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
              activeColor: Theme.of(context).toggleableActiveColor,
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
              activeColor: Theme.of(context).toggleableActiveColor,
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
              activeColor: Theme.of(context).toggleableActiveColor,
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
              activeColor: Theme.of(context).toggleableActiveColor,
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
              activeColor: Theme.of(context).toggleableActiveColor,
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
              activeColor: Theme.of(context).toggleableActiveColor,
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
              activeColor: Theme.of(context).toggleableActiveColor,
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

  Widget _buildPrimaryHeader() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      child: Text('第一颜色:'),
    );
  }

  Widget _buildSecondHeader() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      child: Text('第二颜色:'),
    );
  }

  Widget _buildPrimarySwatchList() {
    return Wrap(
      spacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      runSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      alignment: WrapAlignment.start,
      children: _buildColorList(true, ThemeBloc.primarySwatchList),
    );
  }

  Widget _buildAccentColorList() {
    return Wrap(
      spacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      runSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      alignment: WrapAlignment.start,
      children: _buildColorList(false, ThemeBloc.accentColorList),
    );
  }

  List<Widget> _buildColorList(bool isPrimary, List list) {
    List<Widget> children = [];

    for (int i = 0; i < list.length; i++) {
      children.add(
        GestureDetector(
          onTap: () {
            if (isPrimary) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(primarySwatchIndex: i));
            } else {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(accentColorIndex: i));
            }
          },
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Container(
                width: kToolbarHeight - 20,
                height: kToolbarHeight - 20,
                decoration: BoxDecoration(
                  color: list[i],
                  borderRadius: BorderRadius.all(
                    isPrimary
                        ? Radius.circular(state.primarySwatchIndex == i ? kToolbarHeight : 7)
                        : Radius.circular(state.accentColorIndex == i ? kToolbarHeight : 7),
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
                  activeColor: Theme.of(context).toggleableActiveColor,
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

  Widget _colorDisplayBox(String name, Color color) {
    return Row(
      children: <Widget>[
        new Text("$name\n(0x${color.value.toRadixString(16).padLeft(8, '0')})\t\t"),
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

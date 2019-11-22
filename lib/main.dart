import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_douban2/blocs/simple_bloc_delegate.dart';
import 'package:flutter_douban2/blocs/theme/theme_bloc.dart';
import 'package:flutter_douban2/blocs/theme/theme_state.dart';
import 'package:flutter_douban2/home/home_page.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:flutter_douban2/model/mine_settings_model.dart';
import 'package:flutter_douban2/model/tv_list_model.dart';
import 'package:provider/provider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
// import 'package:flutter/services.dart';

void main() {
  //force portrait as orientations
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          builder: (context) => SearchBloc(),
        ),
        BlocProvider<ThemeBloc>(
          builder: (context) => ThemeBloc(),
        )
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (context) => CelePhotosInfo(),
          ),
          ChangeNotifierProvider(
            builder: (context) => TVListModel(),
          ),
          ChangeNotifierProvider(
            builder: (context) => MineSettingsModel(),
          ),
        ],
        child: DoubanApp(),
      ),
    ),
  );
}

class DoubanApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Douban2',
          debugShowCheckedModeBanner: false,
          theme: themeState.themeData,
          home: HomePage(),
        );
      },
    );
  }
}

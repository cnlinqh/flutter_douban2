import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:provider/provider.dart';
import 'package:flutter_douban2/model/tv_list_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_subject_simple.dart';

class TVListView extends StatefulWidget {
  final tag;
  TVListView(this.tag, {Key key}) : super(key: key);

  _TVListViewState createState() => _TVListViewState();
}

class _TVListViewState extends State<TVListView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<TVListModel>(context, listen: false).init(this.widget.tag);
  }

  //AutomaticKeepAliveClientMixin.wantKeepAlive to keep view state during tab index change
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildView();
  }

  Widget _buildView() {
    return Consumer<TVListModel>(
      builder: (context, model, widget) {
        if (model.mode == 'ListView') {
          return ListView.builder(
            itemCount: model.tvs(this.widget.tag).length,
            itemBuilder: (context, index) {
              if (model.loading(this.widget.tag, index)) {
                model.more(this.widget.tag);
                return Container();
              } else {
                return MovieSubjectGeneral(
                  model.tvs(this.widget.tag)[index]['id'],
                  section: this.widget.tag,
                  isNew: model.tvs(this.widget.tag)[index]['is_new'],
                );
              }
            },
          );
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 3 : 6,
              childAspectRatio: 0.6,
              crossAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
              mainAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
            ),
            itemCount: model.tvs(this.widget.tag).length,
            itemBuilder: (context, index) {
              if (model.loading(this.widget.tag, index)) {
                model.more(this.widget.tag);
                return Container();
              } else {
                return MovieSubjectSimple(
                  model.tvs(this.widget.tag)[index]['id'],
                  section: this.widget.tag,
                  isNew: model.tvs(this.widget.tag)[index]['is_new'],
                );
              }
            },
          );
        }
      },
    );
  }
}

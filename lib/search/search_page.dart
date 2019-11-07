import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key key,
    String title,
  }) : super(key: key);
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List results = [];
  bool isLoading = false;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildAction(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Card(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: controller,
                    onChanged: onSearchTextChange,
                    decoration: InputDecoration(
                      hintText: '搜索电影电视剧',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.clear();
                          results.clear();
                          if (mounted) setState(() {});
                        },
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: onPressSearch,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return isLoading
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : Center(
            child: ListView.separated(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Container(
                  child: MovieSubjectGeneral(
                    results[index]['id'],
                    section: '搜索电影电视剧',
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 0,
              ),
            ),
          );
  }

  Widget _buildAction() {
    return FloatingActionButton(
      child: Icon(Icons.search),
      onPressed: onPressSearch,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSearchTextChange(String text) {}

  void onPressSearch() {
    if (isLoading) {
      return;
    }
    if (controller.text.trim() == '') {
      return;
    }
    results.clear();
    isLoading = true;
    if (mounted) setState(() {});
    this._search(controller.text);
  }

  void _search(String text) async {
    results = await ClientAPI.getInstance().search(text);
    isLoading = false;
    if (mounted) setState(() {});
  }
}

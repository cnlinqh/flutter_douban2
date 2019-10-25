import 'package:flutter/material.dart';
import 'package:flutter_douban2/celebrity/cele_section_general.dart';
import 'package:flutter_douban2/celebrity/cele_section_summary.dart';
import 'package:flutter_douban2/celebrity/cele_section_works.dart';
import 'package:flutter_douban2/celebrity/cele_section_photos.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/client_api.dart';

class CeleDetailsPage extends StatefulWidget {
  final celeId;
  CeleDetailsPage(this.celeId, {Key key}) : super(key: key);

  _CeleDetailsPageState createState() => _CeleDetailsPageState();
}

class _CeleDetailsPageState extends State<CeleDetailsPage> {
  var _cele;
  @override
  void initState() {
    super.initState();
    _getCelebrityDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(LabelConstant.CELE_DETAILS_TITLE),
    );
  }

  Widget _buildBody() {
    if (_cele == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    return Container(
      color: Colors.blueGrey,
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: RefreshIndicator(
        onRefresh: this._getCelebrityDetails,
        child: ListView(
          children: [
            CeleSectionGeneral(this._cele),
            CeleSectionSummary(this._cele),
            CeleSectionWorks(this._cele),
            CeleSectionPhotos(this._cele),
          ],
        ),
      ),
    );
  }

  Future<void> _getCelebrityDetails() async {
    this._cele = await ClientAPI.getInstance().getCelebrityDetails(this.widget.celeId);
    if (mounted) this.setState(() {});
  }
}

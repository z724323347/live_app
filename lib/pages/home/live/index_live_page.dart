import 'package:dev_util/dev_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/pages/home/live/live_page.dart';

class IndexLivePage extends StatefulWidget {
  @override
  _IndexLivePageState createState() => _IndexLivePageState();
}

class _IndexLivePageState extends State<IndexLivePage> {
  List liveList = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    List<dynamic> response = await HttpMockRequest.get(action: 'live');

    setState(() {
      liveList = response;
    });
    print('liveList  ${liveList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      child: ListView(
        children: <Widget>[
          Wrap(
              spacing: ScreenUtil().setWidth(20),
              runSpacing: ScreenUtil().setWidth(20),
              children: liveList.map((l) {
                return GestureDetector(
                  onTap: () {
                    DevUtils().toast(l['room']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LivePage(
                          title: l['room'],
                          liveUrl: l['m3u8'],
                        ),
                      ),
                    );
                  },
                  child: buildLiveItem(l),
                );
              }).toList()),
        ],
      ),
    );
  }

  Widget buildLiveItem(l) {
    return Container(
      width: ScreenUtil().setWidth(340),
      height: ScreenUtil().setWidth(340),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().setWidth(10))),
        image:
            DecorationImage(image: NetworkImage(l['image']), fit: BoxFit.fill),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                '直播TAG',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setWidth(24)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              child: Text(
                '${l['des'] ?? ''}',
                style: TextStyle(
                    color: Colors.orange, fontSize: ScreenUtil().setWidth(24)),
              ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setWidth(50),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setWidth(50))),
                      image: DecorationImage(
                          image: NetworkImage(l['image']), fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${l['room']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setWidth(24)),
                    ),
                  ),
                  Row(children: <Widget>[
                    Icon(
                      Icons.report_problem,
                      color: Colors.white,
                      size: 12,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 10),
                      child: Text(
                        '0',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setWidth(24)),
                      ),
                    ),
                  ])
                ]),
          ]),
    );
  }
}

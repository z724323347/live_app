import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/pages/home/video/video_page.dart';
import 'package:liveapp/widgets/data/less_data.dart';

class IndexVideoPage extends StatefulWidget {
  @override
  _IndexVideoPageState createState() => _IndexVideoPageState();
}

class _IndexVideoPageState extends State<IndexVideoPage> {
  List videoList = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    List<dynamic> response = await HttpMockRequest.get(action: 'video');
    setState(() {
      videoList = response;
    });
    print('liveList  ${videoList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return videoList.isEmpty
        ? LessData()
        : Container(
            color: Colors.grey.shade200,
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            child: ListView(children: <Widget>[
              Wrap(
                spacing: ScreenUtil().setWidth(20),
                runSpacing: ScreenUtil().setWidth(20),
                children: videoList.map((v) {
                  return GestureDetector(
                    onTap: () {
                      // CommonFun().toast(message: '${v['m3u8']}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPage(
                            title: v['room'],
                            playUrl: v['m3u8'],
                            videoList: videoList,
                          ),
                        ),
                      );
                    },
                    child: buildVideoItem(v),
                  );
                }).toList(),
              ),
            ]),
          );
  }

  Widget buildVideoItem(v) {
    return Container(
      width: ScreenUtil().setWidth(340),
      height: ScreenUtil().setWidth(460),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().setWidth(10))),
        image:
            DecorationImage(image: NetworkImage(v['image']), fit: BoxFit.fill),
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
                '${v['des']}',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setWidth(24)),
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
                          image: NetworkImage(v['image']), fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${v['room']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setWidth(24)),
                    ),
                  ),
                  Row(children: <Widget>[
                    Icon(
                      Icons.video_call,
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

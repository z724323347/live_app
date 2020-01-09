import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_lottieview/lottie_controller.dart';
import 'package:flutter_lottieview/lottie_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  LottieController ctrl = LottieController(id: 99);
  LottieController _controller = LottieController(id: 55);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OutlineButton(
                    child: Text('play()'), onPressed: () => ctrl.play()),
                OutlineButton(
                    child: Text('pause()'), onPressed: () => ctrl.pause()),
                OutlineButton(
                    child: Text('resume()'), onPressed: () => ctrl.resume()),
                OutlineButton(
                    child: Text('reverse(true)'),
                    onPressed: () => ctrl.reverse(true)),
                // OutlineButton(
                //     child: Text('playStatus()'),
                //     onPressed: ()  {
                //      _controller.playStatus;
                //      print('----_controller.playStatus    ${_controller.playStatus}');
                //     }),
              ],
            ),
            GestureDetector(
              onTap: () {
                ctrl.pause();
              },
              onHorizontalDragStart: (d){
                Offset dragStart = d.globalPosition;
                print('dragStart ----  $dragStart');
              },
              onHorizontalDragUpdate: (details){
                final newPosition = details.globalPosition;
                final dx = newPosition.dx;
                final slidePercent = (dx / 300).abs().clamp(0.0, 1.0);
                print('slidePercent ---  $slidePercent');
                ctrl.setProgress(slidePercent);
              },
              child: Container(
                width: 300,
                height: 300,
                color: Colors.blue,
                child: IgnorePointer(
                  ignoring: true,
                  child: FLottieView.loadUrl(
                    controller: ctrl,
                    url:
                        "https://assets1.lottiefiles.com/packages/lf20_oIrlXF.json",
                    autoPlay: true,
                    loop: true,
                    reverse: true,
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 300,
              child: FLottieView.loadFile(
                controller: _controller,
                filePath: "assets/story.json",
                autoPlay: true,
                loop: true,
                reverse: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OutlineButton(
                    child: Text('play()'), onPressed: () => _controller.play()),
                OutlineButton(
                    child: Text('pause()'),
                    onPressed: () => _controller.pause()),
                OutlineButton(
                    child: Text('stop()'), onPressed: () => _controller.stop()),
                OutlineButton(
                    child: Text('setSpeed(0.2)'),
                    onPressed: () => _controller.setSpeed(0.2)),
                // OutlineButton(
                //     child: Text('playStatus()'),
                //     onPressed: ()  {
                //      _controller.playStatus;
                //      print('----_controller.playStatus    ${_controller.playStatus}');
                //     }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

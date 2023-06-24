import 'dart:convert';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewVideo();
  }

  final Media videoPlayer1 = Media.asset('assets/mmm.mp4');

  List<Media> videoPlayer = [];
  List<Player> player = [];
  List<String> link = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: Material(
          child: isVideoLoad
              ? Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Video(
                        player: Player(id: 0)
                          ..open(Media.network(
                              'http://clips.vorwaerts-gmbh.de/VfE.ogv')),
                        fit: BoxFit.fill,
                        height: 261,
                        width: 464,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Video(
                        player: Player(id: 1)
                          ..open(Media.network(
                              'https://thepaciellogroup.github.io/AT-browser-tests/video/ElephantsDream.mp4')),
                        fit: BoxFit.fill,
                        height: 261,
                        width: 464,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Video(
                        player: Player(id: 2)
                          ..open(Media.network(
                              'http://clips.vorwaerts-gmbh.de/VfE.ogv')),
                        fit: BoxFit.fill,
                        height: 261,
                        width: 464,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Video(
                        player: Player(id: 2)
                          ..open(Media.network(
                              'http://clips.vorwaerts-gmbh.de/VfE.ogv')),
                        fit: BoxFit.fill,
                        height: 261,
                        width: 464,
                      ),
                    ),
                  ],
                )
              : Center(child: CupertinoActivityIndicator())),
    );
  }

  bool isVideoLoad = false;

  Future<void> viewVideo() async {
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/Training_Video/view_video.php');
    var response = await http.get(url);
    Map json = jsonDecode(response.body);
    for (int i = 0; i < json['response'].length; i++) {
      videoPlayer.add(Media.network(json['response'][i]['video']));
      link.add(json['response'][i]['video']);
    }
    setState(() {
      isVideoLoad = true;
    });
  }
}

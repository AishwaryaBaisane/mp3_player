import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_player/Like_page/like_page.dart';
import 'package:provider/provider.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

import '../../mx_provider/getxController.dart';
import '../../mx_provider/provider.dart';
import '../../utils/global.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider1 = Get.put(GetController());

    // );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Provider.of<MusicProvider>(context).songModal == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<MusicProvider>(
                builder: (context, provider, child) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(
                        provider.result!.image[2].url,
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.3,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                              const Text(
                                'Song Page',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              IconButton(
                                onPressed: () {
                                  provider1.likeData1(provider.result!);
                                  // provider1.likeList.add(provider.result);
                                  print(provider1.likeList);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      animation: ProxyAnimation(),
                                      padding: const EdgeInsets.all(15),
                                      shape: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white60),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15))),
                                      content: const Text(
                                        "Add to your favorite List ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      backgroundColor: Colors.white30,
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.2,
                        ),
                        Container(
                          height: height * 0.38,
                          width: width * 0.7,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  provider.result!.image[2].url,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 360,
                                child: Text('${provider.result!.name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                              Text(
                                  '${provider.result!.artists.primary[0].name}!',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        (provider.duration == null)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  Column(
                                    children: [
                                      StreamBuilder(
                                        stream: provider.getCurrentPosition(),
                                        builder: (context, snapshot) => Slider(
                                          activeColor: Colors.white,
                                          inactiveColor: Colors.grey,
                                          max: provider.duration!.inSeconds
                                              .toDouble(),
                                          value: snapshot.data!.inSeconds
                                              .toDouble(),
                                          onChanged: (value) {
                                            provider.jumpSong(Duration(
                                                seconds: value.toInt()));
                                          },
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: provider.getCurrentPosition(),
                                        builder: (context, snapshot) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.inSeconds
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                '${provider.duration!.inMinutes.toString()} : 00',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.share,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            final data = provider
                                                .songModal!
                                                .data
                                                .results[provider.nextSong - 1];
                                            provider.setSong1(data);
                                            await provider.setMusic(
                                                data.downloadUrl[1].url);
                                            provider.player.play();
                                            provider.isPlaying = true;
                                            provider.nextSong =
                                                provider.nextSong - 1;
                                          },
                                          icon: Icon(
                                            Icons.skip_previous_rounded,
                                            size: 45,
                                            color: Colors.white,
                                          )),
                                      IconButton(
                                        onPressed: () async {
                                          await provider.playSong();
                                        },
                                        icon: Icon(
                                          provider.isPlaying != true
                                              ? Icons.play_circle_outline_sharp
                                              : Icons.pause_circle,
                                          color: Colors.white,
                                          size: 60,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          final data = provider.songModal!.data
                                              .results[provider.nextSong + 1];
                                          provider.setSong1(data);
                                          await provider.setMusic(
                                              data.downloadUrl[1].url);
                                          provider.player.play();
                                          provider.isPlaying = true;
                                          provider.nextSong =
                                              provider.nextSong + 1;
                                          // await provider.previousSong();
                                          // Navigator.of(context).pushNamed('/song');
                                        },
                                        icon: Icon(
                                          Icons.skip_next_rounded,
                                          size: 45,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.watch_later_outlined,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}


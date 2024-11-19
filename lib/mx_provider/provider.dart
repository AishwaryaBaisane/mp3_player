import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mx_player/Api_service/api_service.dart';
import 'package:mx_player/Modal_class/modal_class.dart';
import 'package:mx_player/utils/global.dart';

class MusicProvider extends ChangeNotifier {
  SongModal? songModal;
  SongModal? songModal1;
  Result? result;
  Result? result1;
  AudioPlayer player = AudioPlayer();
  Duration? duration;
  bool isPlaying = false;
  int currentIndex = 0;
  int nextSong = 0;

  Future<void> getSongs() async {
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSong();
    songModal = SongModal.fromJson(json);
    notifyListeners();
  }

  Future<void> getSongs1() async {
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSong1();
    songModal1 = SongModal.fromJson(json);
    notifyListeners();
  }

  void setSong1(Result song) {
    result = song;
    notifyListeners();
  }

  Future<void> setMusic(String url) async {
    duration = await player.setUrl(url);
    notifyListeners();
  }

  // Future<void> getSongs2() async {
  //   ApiService apiService = ApiService();
  //   Map<String, dynamic> json = await apiService.fetchSong2();
  //   songModal2 = SongModal.fromJson(json);
  //   notifyListeners();
  // }

  void selectSong(Result selectedSong) {
    result = selectedSong;
    notifyListeners();
  }

  // void searchSong(String value) {
  //   for (int i = 0; i < songModal!.data.results.length; i++) {
  //     print(songModal!.data.results[i].name);
  //     if (songModal!.data.results[i].name == value.toString()) {
  //       print(value.toString());
  //       print(
  //           '------------------------------------------------------------------------------------------------------>');
  //       selectSong(result!);
  //       setSong(result!.downloadUrl[0].url);
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> setSong(String url) async {
    duration = await player.setUrl(url);
    notifyListeners();
  }

  Future<void> playSong() async {
    if (isPlaying) {
      isPlaying = false;
      await player.pause();
      notifyListeners();
    } else {
      isPlaying = true;
      await player.play();
      notifyListeners();
    }
    notifyListeners();
  }

  Stream<Duration> getCurrentPosition() {
    return player.positionStream;
  }

  Future<void> jumpSong(Duration position) async {
    await player.seek(position);
    notifyListeners();
  }

  MusicProvider() {
    getSongs();
    getSongs1();
    // getSongs2();
  }
}

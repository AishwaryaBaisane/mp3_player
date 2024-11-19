import 'package:flutter/cupertino.dart';
import 'package:mx_player/Modal_class/modal_class.dart';
import 'package:mx_player/search/Search_api.dart';

class SearchProvider extends ChangeNotifier
{
  String search='';
  String recentSearch='';
  List<Result> listOfSearch=[];

  SongModal? searchModel;
  SongModal? searchSongModel;
  Future<void> getData()
  async {
    SearchApiService apiService=SearchApiService();
    Map<String,dynamic> json= await apiService.fetchData(search);
    searchModel=SongModal.fromJson(json);
    notifyListeners();
  }
  Future<void> fetchData()
  async {
    SearchApiService apiService=SearchApiService();
    Map<String,dynamic> json=await apiService.fetchData(recentSearch);
    searchSongModel=SongModal.fromJson(json);
    notifyListeners();
  }

  void removeData(int index)
  {
    listOfSearch.removeAt(index);
    notifyListeners();
  }

  void searchSong(String songs)
  {
    search=songs;
    notifyListeners();
  }
  void playSong(String songs)
  {
    recentSearch=songs;
    notifyListeners();
  }
  SearchProvider()
  {
    getData();
  }
}
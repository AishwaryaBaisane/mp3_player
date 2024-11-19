import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Screen/Song_Page/song_page.dart';
import '../mx_provider/getxController.dart';
import '../mx_provider/provider.dart';
import '../search/search_provider.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    var songProvider = Provider.of<MusicProvider>(context);
    var provider1 = Get.put(GetController());
    final data = provider1.likeList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite songs'),
      ),
      body: Obx(
        () => (provider1.likeList.isEmpty)
            ? const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Explore And \n Select your Favorite Songs ',
                ),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      provider.listOfSearch.add(data[index]);
                      songProvider.setSong1(data[index]);
                      await songProvider
                          .setMusic(data[index].downloadUrl[1].url);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SongPage(),
                      ));
                      provider.searchSong('');
                      provider.getData();
                    },
                    leading: Image.network(data[index].image[2].url),
                    title: Text(
                      data[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    subtitle: Text(
                      'Singer - ${data[index].artists.primary[0].name}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              data[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                              'Are you sure you want to remove this song!',
                              style: TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    provider1.deleteData(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        animation: ProxyAnimation(),
                                        padding: const EdgeInsets.all(15),
                                        shape: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.white60),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15))),
                                        content: const Text(
                                          "Removed from Favorite List",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        action: SnackBarAction(
                                            label: 'Undo',
                                            textColor: const Color(0xff6156e1),
                                            onPressed: () {}),
                                        backgroundColor: Colors.white30,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete')),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        // color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

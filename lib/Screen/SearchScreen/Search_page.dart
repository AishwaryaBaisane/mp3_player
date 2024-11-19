import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_player/Screen/Song_Page/song_page.dart';
import 'package:mx_player/search/search_provider.dart';
import 'package:provider/provider.dart';
import '../../mx_provider/getxController.dart';
import '../../mx_provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    var songProvider = Provider.of<MusicProvider>(context);
    var provider1 = Get.put(GetController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: AssetImage('assets/img/girl.jpg')),
          ),
          title: const Text(
            'Search heare....',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        // backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: txtSearch,
                style: const TextStyle(),
                onChanged: (value) {
                  provider.searchSong(value);
                  provider.getData();
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    // color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        provider.searchSong('');
                        provider.getData();
                        txtSearch.clear();
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        // color: Colors.white,
                      )),
                  hintText: 'What do you want to listen ?',
                  // hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                        width: 1.5,
                        color: (theme1.value) ? Colors.black : Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            Consumer<SearchProvider>(
              builder: (context, provider, child) => (provider.searchModel ==
                          null ||
                      provider.search == '' && provider.listOfSearch.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              buildContainer('Arijit'),
                              buildContainer('Jubin Nutiyal'),
                              buildContainer('Neha Kakkar'),
                            ],
                          ),
                          Row(
                            children: [
                              buildContainer('Alka Yagnik'),
                              buildContainer('Udit Narayan'),
                              buildContainer('Shreya')
                            ],
                          ),
                          Row(
                            children: [
                              buildContainer('Lata Mangeshkar'),
                              buildContainer('Asha Bhosle'),
                            ],
                          )
                        ],
                      ),
                    )
                  : (provider.search != '')
                      ? Expanded(
                          child: ListView.builder(
                          itemCount: provider.searchModel!.data.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = provider.searchModel!.data.results;
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ListTile(
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
                                  txtSearch.clear();
                                },
                                leading: Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          data[index].image[2].url),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  data[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                subtitle: Text(
                                  'Singer - ${data[index].artists.primary[0].name}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          },
                        ))
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'Recent Searches :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 600,
                                    child: ListView.builder(
                                      itemCount: provider.listOfSearch.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: ListTile(
                                          onTap: () async {
                                            final data =
                                                provider.listOfSearch[index];
                                            songProvider.setSong1(data);
                                            await songProvider.setMusic(
                                                data.downloadUrl[1].url);
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => SongPage(),
                                            ));
                                          },
                                          leading: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              image: DecorationImage(
                                                image: NetworkImage(provider
                                                    .listOfSearch[index]
                                                    .image[2]
                                                    .url),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            provider.listOfSearch[index].name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          ),
                                          subtitle: Text(
                                            'Singer - ${provider.listOfSearch[index].artists.primary[0].name}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                provider.removeData(index);
                                              },
                                              icon: const Icon(
                                                Icons.cancel_outlined,
                                                // color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SingleChildScrollView(
                                  //   child: Column(
                                  //     children: List.generate(
                                  //       provider.listOfSearch.length,
                                  //       (index) =>
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String sinGar) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white24,
              blurRadius: 5.0,
              offset: Offset(1.5, 1.5),
            ),
          ],
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Row(
            children: [
              Text(
                sinGar,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.search,
                color: Colors.lightBlue,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

var txtSearch = TextEditingController();

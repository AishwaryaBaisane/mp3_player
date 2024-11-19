import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_player/Like_page/like_page.dart';
import 'package:mx_player/Modal_class/modal_class.dart';

import 'package:mx_player/Screen/SearchScreen/Search_page.dart';
import 'package:mx_player/utils/global.dart';
import 'package:provider/provider.dart';

import '../../mx_provider/getxController.dart';
import '../../mx_provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<MusicProvider>(context);
    var provider1 = Get.put(GetController());

    return Scaffold(
      appBar: AppBar(
        shadowColor: (theme1.value) ? Colors.black : Colors.white,
        surfaceTintColor: (theme1.value) ? Colors.black : Colors.white,
        leading: Obx(
          () => IconButton(
              onPressed: () {
                provider1.theme();
              },
              icon: (!theme1.value)
                  ? Icon(Icons.motion_photos_on)
                  : Icon(Icons.sunny)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LikePage(),
                ));
              },
              icon: Icon(Icons.favorite))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 65,
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: 135,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Hi There,',
                          style: GoogleFonts.roboto(
                            fontSize: 26,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Welcome to Your Mp3 Player',
                          style: GoogleFonts.roboto(
                            fontSize: 18.5,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            forceMaterialTransparency: true,
            elevation: 0,
            stretch: true,
            toolbarHeight: 85,
            title: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                child: AnimatedContainer(
                  width: 300,
                  height: 52.0,
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: (!theme1.value) ? Colors.white24 : Colors.white24,
                    // color: Provider.of<ThemeProvider>(context,listen: true).isDarkMode ? Colors.grey[900] : Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2.0,
                        offset: Offset(1.5, 1.5),
                      ),
                    ],
                  ),
                  child: Obx(
                    () => TextField(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ));
                      },
                     cursorColor:  Colors.transparent ,
                      controller: txtSearch,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          color: Colors.blueGrey,
                        ),
                        filled: true,
                        fillColor:
                            (!theme1.value) ? Colors.black38 : Colors.white,
                        hintText: 'Search Song...',
                        hintStyle:
                            const TextStyle(color: Colors.blueGrey, fontSize: 18),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: (theme1.value)
                                  ? Colors.white12
                                  : Colors.white12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: (!theme1.value)
                                  ? Colors.white24
                                  : Colors.white24),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Charts',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 8.0, bottom: 8.0),
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.4,
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(ImgList3[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New Released',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                          ),
                         const  Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: ImgList4.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 8.0, bottom: 8.0),
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.4,
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(ImgList4[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trending Songs',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                provider.songModal1?.data.results.length ?? 0,
                            //   provider.songModal?.data.results.length ?? 0,
                            // ),
                            itemBuilder: (context, index) {
                              Result result =
                                  provider.songModal!.data.results[index];

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      provider.selectSong(result);
                                      provider
                                          .setSong(result.downloadUrl[0].url);
                                      provider.nextSong = index;
                                      Navigator.of(context).pushNamed('/song');
                                    },
                                    child: Container(
                                      height: height * 0.2,
                                      width: width * 0.4,
                                      margin: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            result.image[2].url,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          result.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Playlists',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    Provider.of<MusicProvider>(context).songModal == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Consumer<MusicProvider>(
                            builder: (context, provider, child) => SizedBox(
                              height: height * 0.7,
                              child: ListView.builder(
                                itemCount:
                                    provider.songModal1?.data.results.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  Result result =
                                      provider.songModal!.data.results[index];
                                  Result result1 =
                                      provider.songModal1!.data.results[index];
                                  // Result result2 =
                                  //     provider.songModal2!.data.results[index];
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading:
                                            Image.network(result1.image[2].url),
                                        title: Text(result1.name),
                                        subtitle: Text(
                                            result1.artists.primary[0].name),
                                        trailing: IconButton(
                                          onPressed: () {
                                            provider.selectSong(result1);
                                            provider.setSong(
                                                result1.downloadUrl[0].url);
                                            provider.nextSong = index;
                                            Navigator.of(context)
                                                .pushNamed('/song');
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended Artist',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: ImgList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 8.0, bottom: 8.0),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImgList[index]),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: ImgList2.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 8.0, bottom: 8.0),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImgList2[index]),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'All Type Song',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                          ),
                          const  Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: ImgList5.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 8.0, bottom: 8.0),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImgList5[index]),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

List ImgList = [
  'assets/img/arijit.jpg',
  'assets/img/neha.jpg',
  'assets/img/arman.jpg',
  'assets/img/shreya.jpg',
];

List  ImgList2 = [
  'assets/img/jubin.jpg',
  'assets/img/sonu.jpg',
  'assets/img/alka.jpg',
  'assets/img/kishor.jpg',
  'assets/img/kumar.jpg',
  'assets/img/latadi.jpg',
];
List ImgList3 = [
  'assets/img/image.jpg',
  'assets/img/image2.jpg',
  'assets/img/image3.jpg',
  'assets/img/image4.jpg',
  'assets/img/image5.jpg',
];
List ImgList4 = [
  'assets/img/image8.jpg',
  'assets/img/image10.jpg',
  'assets/img/image11.jpg',
  'assets/img/image12.jpg',
  'assets/img/image15.jpg',
  'assets/img/image16.jpg',
  'assets/img/image17.jpg',
  'assets/img/image18.jpg',
];

List ImgList5 = [
  'assets/img/bts.jpg',
  'assets/img/r6.jpg',
  'assets/img/70s.jpg',
  'assets/img/80s.jpg',
  'assets/img/90s1.jpg',
  'assets/img/r4.jpg',
];

TextEditingController txtSearch = TextEditingController();

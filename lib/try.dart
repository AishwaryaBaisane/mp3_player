//
// class SongModal {
//   Data? data;
//
//   SongModal({required this.data});
//
//   factory SongModal.fromJson(Map m1) {
//     return SongModal(data: Data.fromJson(m1['data']));
//   }
// }
//
// class Data {
//   List<ResultData>? results;
//
//   Data({required this.results});
//
//   factory Data.fromJson(Map m1) {
//     return Data(
//         results: (m1['results'] as List)
//             .map(
//               (e) => ResultData.fromJson(e),
//             )
//             .toList());
//   }
// }
//
// class ResultData {
//   String? id, name, label, url;
//   int? duration;
//   Album? album;
//   Artists? artists;
//
//   ResultData({
//     required this.id,
//     required this.name,
//     required this.label,
//     required this.url,
//     required this.duration,
//     required this.album,
//     required this.artists,
//   });
//
//   factory ResultData.fromJson(Map m1) {
//     return ResultData(
//         id: m1['id'],
//         name: m1['name'],
//         label: m1['label'],
//         url: m1['url'],
//         duration: m1['duration'],
//         album: Album.fromJson(m1['album']),
//         artists: Artists.fromJson(m1['album']));
//   }
// }
//
// class Artists {
//   List<Primary>? primary;
//
//   Artists({required this.primary});
//
//   factory Artists.fromJson(Map m1) {
//     //  (m1['hits'] as List).map((e) => Hit.fromMap(e),).toList());
//     return Artists(
//         primary: (m1['primary'] as List)
//             .map(
//               (e) => Primary.fromJson(e),
//             )
//             .toList());
//   }
// }
//
// class Primary {
//   String? id, name, url;
//   List<Img>? image;
//
//   Primary(
//       {required this.id,
//       required this.name,
//       required this.url,
//       required this.image});
//
//   factory Primary.fromJson(Map m1) {
//     return Primary(
//         id: m1['id'],
//         name: m1['name'],
//         url: m1['url'],
//         image: (m1['image'] as List)
//             .map(
//               (e) => Img.fromJson(e),
//             )
//             .toList());
//   }
// }
//
// class Img {
//   String? url;
//
//   Img({required this.url});
//
//   factory Img.fromJson(Map m1) {
//     return Img(url: m1['url']);
//   }
// }
//
// class Album {
//   String? id, name, url;
//
//   Album({required this.id, required this.name, required this.url});
//
//   factory Album.fromJson(Map m1) {
//     return Album(id: m1['id'], name: m1['name'], url: m1['url']);
//   }
// }

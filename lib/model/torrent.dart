import 'dart:convert';

class Torrent {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final int seeds;
  final int peers;
  final String size;
  final int size_bytes;
  final String date_uploaded;
  final int date_uploaded_unix;

  Torrent(this.url, this.hash, this.quality, this.type, this.seeds, this.peers,
      this.size, this.size_bytes, this.date_uploaded, this.date_uploaded_unix);

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'hash': hash,
      'quality': quality,
      'type': type,
      'seeds': seeds,
      'peers': peers,
      'size': size,
      'size_bytes': size_bytes,
      'date_uploaded': date_uploaded,
      'date_uploaded_unix': date_uploaded_unix,
    };
  }

  static Torrent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Torrent(
      map['url'],
      map['hash'],
      map['quality'],
      map['type'],
      map['seeds'],
      map['peers'],
      map['size'],
      map['size_bytes'],
      map['date_uploaded'],
      map['date_uploaded_unix'],
    );
  }

  String toJson() => json.encode(toMap());

  static Torrent fromJson(String source) => fromMap(json.decode(source));
}

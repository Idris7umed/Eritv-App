class Channel {
  final String id;
  final String name;
  final String url;
  final String? logo;
  final String? group;

  Channel({
    required this.id,
    required this.name,
    required this.url,
    this.logo,
    this.group,
  });

  factory Channel.fromM3U(String extinf, String url) {
    // Parse EXTINF line: #EXTINF:-1 tvg-id="..." tvg-logo="...",Channel Name
    final idMatch = RegExp(r'tvg-id="([^"]*)"').firstMatch(extinf);
    final logoMatch = RegExp(r'tvg-logo="([^"]*)"').firstMatch(extinf);
    final groupMatch = RegExp(r'group-title="([^"]*)"').firstMatch(extinf);
    
    // Get channel name (after the last comma)
    final nameMatch = extinf.split(',');
    final name = nameMatch.length > 1 ? nameMatch.last.trim() : 'Unknown Channel';
    
    return Channel(
      id: idMatch?.group(1) ?? '',
      name: name,
      url: url.trim(),
      logo: logoMatch?.group(1),
      group: groupMatch?.group(1),
    );
  }

  @override
  String toString() {
    return 'Channel{id: $id, name: $name, url: $url}';
  }
}

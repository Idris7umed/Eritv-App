import 'package:http/http.dart' as http;
import '../models/channel.dart';

class M3UParser {
  static const String m3uUrl = 
      'https://raw.githubusercontent.com/Idris7umed/iptv/master/streams/er.m3u';

  Future<List<Channel>> fetchChannels() async {
    try {
      final response = await http.get(Uri.parse(m3uUrl));
      
      if (response.statusCode == 200) {
        return parseM3U(response.body);
      } else {
        throw Exception('Failed to load channels: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching channels: $e');
    }
  }

  List<Channel> parseM3U(String content) {
    final channels = <Channel>[];
    final lines = content.split('\n');
    
    String? currentExtinf;
    
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      
      // Skip empty lines and M3U header
      if (line.isEmpty || line == '#EXTM3U') continue;
      
      // Check if line is an EXTINF directive
      if (line.startsWith('#EXTINF:')) {
        currentExtinf = line;
      } else if (currentExtinf != null && !line.startsWith('#')) {
        // This is a URL line following an EXTINF
        final channel = Channel.fromM3U(currentExtinf, line);
        channels.add(channel);
        currentExtinf = null;
      }
    }
    
    return channels;
  }
}

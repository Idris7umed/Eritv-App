import 'package:flutter_test/flutter_test.dart';
import 'package:eritv_app/services/m3u_parser.dart';
import 'package:eritv_app/models/channel.dart';

void main() {
  group('M3UParser', () {
    test('parses M3U content correctly', () {
      final parser = M3UParser();
      const content = '''#EXTM3U
#EXTINF:-1 tvg-id="ERiTV1.er@SD",ERi-TV 1 (576p)
https://jmc-live.ercdn.net/eritreatv/eritreatv.m3u8''';

      final channels = parser.parseM3U(content);

      expect(channels.length, 1);
      expect(channels[0].name, 'ERi-TV 1 (576p)');
      expect(channels[0].id, 'ERiTV1.er@SD');
      expect(channels[0].url, 'https://jmc-live.ercdn.net/eritreatv/eritreatv.m3u8');
    });

    test('handles empty M3U content', () {
      final parser = M3UParser();
      const content = '#EXTM3U';

      final channels = parser.parseM3U(content);

      expect(channels.length, 0);
    });

    test('handles multiple channels', () {
      final parser = M3UParser();
      const content = '''#EXTM3U
#EXTINF:-1 tvg-id="Channel1",Channel One
http://example.com/stream1.m3u8
#EXTINF:-1 tvg-id="Channel2",Channel Two
http://example.com/stream2.m3u8''';

      final channels = parser.parseM3U(content);

      expect(channels.length, 2);
      expect(channels[0].name, 'Channel One');
      expect(channels[1].name, 'Channel Two');
    });
  });

  group('Channel', () {
    test('creates channel from M3U line', () {
      const extinf = '#EXTINF:-1 tvg-id="test.id" tvg-logo="http://logo.png",Test Channel';
      const url = 'http://stream.m3u8';

      final channel = Channel.fromM3U(extinf, url);

      expect(channel.name, 'Test Channel');
      expect(channel.id, 'test.id');
      expect(channel.url, 'http://stream.m3u8');
      expect(channel.logo, 'http://logo.png');
    });

    test('handles missing attributes', () {
      const extinf = '#EXTINF:-1,Simple Channel';
      const url = 'http://stream.m3u8';

      final channel = Channel.fromM3U(extinf, url);

      expect(channel.name, 'Simple Channel');
      expect(channel.id, '');
      expect(channel.logo, null);
    });
  });
}

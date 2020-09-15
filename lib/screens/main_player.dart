import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import '../items/buttons_item.dart';

class MainPlayer extends StatefulWidget {
  @override
  _MainPlayerState createState() => _MainPlayerState();
}

class _MainPlayerState extends State<MainPlayer> {
  final String audioName = "audio.mp3";
  final String musicName = "Bhavi - Lado a Lado";
  final String imageURL =
      "https://images.genius.com/1f32faeb373ae46312502519dc9bfc84.750x750x1.jpg";

  double volume = 1;
  double currentVolume;

  Duration duration = Duration();
  Duration position = Duration();

  AudioPlayer audioPlayer;
  AudioCache audioCache;
  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.positionHandler = (p) => setState(() {
          position = p;
        });
    audioPlayer.durationHandler = (d) => setState(() {
          duration = d;
        });
  }

  void playMusic(String order) {
    switch (order) {
      case 'play':
        audioCache.play(audioName);
        break;
      case 'stop':
        audioPlayer.stop();
        break;
      case '+':
        if (volume < 1) {
          volume += 0.1;
          audioPlayer.setVolume(volume);
        }
        break;
      case '-':
        if (volume > 0 || volume != 0) {
          volume -= 0.1;
          audioPlayer.setVolume(volume);
        }
        break;
      case 'mute':
        if (volume > 0 || volume != 0) {
          currentVolume = volume;
          volume = 0;
        } else {
          volume = currentVolume;
        }
        audioPlayer.setVolume(volume);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pool Music",
          style: TextStyle(fontSize: 20, color: Colors.blueGrey),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(imageURL),
              ),
              Text(
                musicName,
                style: TextStyle(fontSize: 20, color: Colors.amber),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: audioControls(),
              ),
              Slider(
                value: position.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble(),
                activeColor: Colors.blueGrey,
                onChanged: (double seconds) {
                  setState(() {
                    audioPlayer.seek(
                      Duration(
                        seconds: seconds.toInt(),
                      ),
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> audioControls() {
    return <Widget>[
      ButtonItem(
        icon: Icons.play_arrow,
        color: Colors.black,
        play: () => playMusic('play'),
      ),
      ButtonItem(
        icon: Icons.stop,
        color: Colors.brown,
        play: () => playMusic('stop'),
      ),
      ButtonItem(
        icon: Icons.volume_up,
        color: Colors.deepOrange,
        play: () => playMusic('+'),
      ),
      ButtonItem(
        icon: Icons.volume_down,
        color: Colors.red,
        play: () => playMusic('-'),
      ),
      ButtonItem(
        icon: Icons.volume_mute,
        color: Colors.amber,
        play: () => playMusic('mute'),
      )
    ];
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Downloader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

void _downloadVideo(String url) async {
  var ytExplode = YoutubeExplode();
  var video = await ytExplode.videos.get(url);

  var manifest = await ytExplode.videos.streamsClient.getManifest(video);

  var streamInfo = manifest.audioOnly.first;
  var videoStream = manifest.video.first;

  var audioStream = ytExplode.videos.streamsClient.get(streamInfo);
  var videoFile = await ytExplode.videos.streamsClient.get(videoStream);

  // Implement file saving logic here
}

void _saveVideo(File videoFile, String videoTitle) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final savePath = appDocDir.path + '/$videoTitle.mp4';

  final videoBytes = await videoFile.readAsBytes();
  final File file = File(savePath);

  await file.writeAsBytes(videoBytes);

  // Show a success message or handle errors here
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Downloader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter YouTube URL:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'https://www.youtube.com/watch?v=...',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String videoUrl = 'https://www.youtube.com/watch?v=...'; // Replace with user input
                _downloadVideo(videoUrl);
              },
              child: const Text('Download Video'),
            ),
          ],
        ),
      ),
    );
  }
}
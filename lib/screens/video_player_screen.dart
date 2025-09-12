// lib/screens/video_player_screen.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String videoUrl;

  const VideoPlayerScreen({
    super.key,
    required this.title,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  bool _isInitialized = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        // optionally autoplay
        //_controller.play();
      }).catchError((err) {
        // handle initialization error
        setState(() {
          _isError = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPlayer() {
    if (_isError) {
      return const Center(child: Text('Failed to load video'));
    }
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: 36,
                color: Colors.teal,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                });
              },
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.replay_10, color: Colors.black54),
              onPressed: () {
                final pos = _controller.value.position;
                _controller.seekTo(pos - const Duration(seconds: 10));
              },
            ),
            IconButton(
              icon: const Icon(Icons.forward_10, color: Colors.black54),
              onPressed: () {
                final pos = _controller.value.position;
                _controller.seekTo(pos + const Duration(seconds: 10));
              },
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: _buildPlayer()),
      floatingActionButton: _isInitialized && !_isError
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                });
              },
              child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            )
          : null,
    );
  }
}

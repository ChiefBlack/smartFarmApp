
// import 'package:video_player/video_player.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the VideoPlayerController with your video stream URL or file path
//     _controller = VideoPlayerController.networkUrl(
//         'https://example.com/your_video_stream_url.mp4')
//       ..initialize().then((_) {
//         // Ensure the first frame is shown
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//             : CircularProgressIndicator(), // Show a loading indicator until the video is initialized
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_controller.value.isPlaying) {
//             _controller.pause();
//           } else {
//             _controller.play();
//           }
//           setState(() {});
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // Ensure you dispose of the controller when it's no longer needed
//     _controller.dispose();
//   }
// }

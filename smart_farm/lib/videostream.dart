

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor:const Color.fromRGBO(41, 110, 73, 1),elevation: 5.0,
   
    title:const Center(child: Text("Livestock smartApp",style: TextStyle(fontFamily: "Ariel",fontSize: 25,color: Colors.white),))),
    
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            :const CircularProgressIndicator(), // Show a loading indicator until the video is initialized
      ),
      floatingActionButton:
      
          Icon( Icons.live_tv,size: 203,),
       
     
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

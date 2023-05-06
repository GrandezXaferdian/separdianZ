import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:separdianz/preferences.dart';

class ProfileAvatar extends StatefulWidget {
  final String name;
  final String picpath;
  final double progress;
  final Color barcolor;
  final Function()? delete;

  ProfileAvatar(
      {super.key,
      this.name = "Your progress",
      this.picpath = "assets/nahida.jpg",
      this.progress = 0.0,
      this.barcolor = const Color.fromARGB(255, 176, 255, 217),
      this.delete});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(alignment: AlignmentDirectional.center, children: [
            CircularPercentIndicator(
              backgroundColor: progress_bg,
              progressColor: widget.barcolor,
              percent: widget.progress,
              lineWidth: 3.0,
              radius: 40.0,
              // animateFromLastPercent: true,
              animation: true,
              animationDuration: 1000,
            ),
            GestureDetector(
              onTap: () {
                //Write page nagivation function
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Navigate to ${widget.name}')));
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(widget.picpath),
                radius: 36.0,
              ),
            )
          ]),
        ),
        SizedBox(height: 5.0),
        Text(
          widget.name,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[800], // Dark grey background
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Georgia', // Georgia font for the title
          ),
        ),
      ),
      home: GlowButtonDemo(),
    );
  }
}

class GlowButtonDemo extends StatefulWidget {
  @override
  _GlowButtonDemoState createState() => _GlowButtonDemoState();
}

class _GlowButtonDemoState extends State<GlowButtonDemo> {
  bool isGlowing1 = false;
  bool isGlowing2 = false;
  bool isGlowing3 = false;
  double progress1 = 0;
  double progress2 = 0;
  double progress3 = 0;
  double maxScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WAND',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black, // Black app bar background
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGlowButton("Norma", Colors.pinkAccent, isGlowing1),
              _buildGlowButton("Realix", Colors.amber, isGlowing2),
              _buildGlowButton("Matrix", Colors.lime, isGlowing3),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGrowthButton(Colors.pinkAccent, 1),
              _buildGrowthButton(Colors.amber, 2),
              _buildGrowthButton(Colors.lime, 3),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHarmButton("Harm", () => _updateProgress(1)),
              _buildHarmButton("Harm", () => _updateProgress(2)),
              _buildHarmButton("Harm", () => _updateProgress(3)),
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProgressBarContainer(Colors.pinkAccent, progress1),
              _buildProgressBarContainer(Colors.amber, progress2),
              _buildProgressBarContainer(Colors.lime, progress3),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGlowButton(String label, Color color, bool isGlowing) {
    final buttonColor = isGlowing
        ? color
        : Color.fromARGB(
            color.alpha,
            (color.red * 0.8).round(),
            (color.green * 0.8).round(),
            (color.blue * 0.8).round(),
          );

    return GestureDetector(
      onTap: () {
        setState(() {
          switch (label) {
            case "Norma":
              isGlowing1 = !isGlowing1;
              break;
            case "Realix":
              isGlowing2 = !isGlowing2;
              break;
            case "Matrix":
              isGlowing3 = !isGlowing3;
              break;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isGlowing
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Georgia', // Georgia font for the button text
          ),
        ),
      ),
    );
  }

  Widget _buildGrowthButton(Color color, int buttonIndex) {
    return GestureDetector(
      onTap: () {
        _updateMaxScore();
        _updateProgressBarHeight(buttonIndex);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(
            color.alpha,
            (color.red * 0.8).round(),
            (color.green * 0.8).round(),
            (color.blue * 0.8).round(),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Growth',
          style: TextStyle(
            fontFamily: 'Georgia', // Georgia font for the button text
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHarmButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black, // Change the color to black
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Georgia', // Georgia font for the button text
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBarContainer(Color color, double value) {
    return Container(
      height: 10 + maxScore * 10, // Set the height of the container
      child: Column(
        children: [
          _buildProgressBar(color, value),

          //Flexible(
          //child: _buildProgressBar(color, value),
          //),
        ],
      ),
    );
  }

  void _updateProgress(int buttonIndex) {
    switch (buttonIndex) {
      case 1:
        if (progress1 < maxScore) {
          progress1 += 1;
        } else {
          progress1 = 0;
        }
        break;
      case 2:
        if (progress2 < maxScore) {
          progress2 += 1;
        } else {
          progress2 = 0;
        }
        break;
      case 3:
        if (progress3 < maxScore) {
          progress3 += 1;
        } else {
          progress3 = 0;
        }
        break;
    }
    setState(() {});
  }

  Widget _buildProgressBar(Color color, double value) {
    return Container(
      width: maxScore * 10, // Set the height to be three times taller
      height: 20,
      child: VerticalProgressIndicator(color, value, maxScore),
    );
  }

  void _updateProgressBarHeight(int buttonIndex) {
    setState(() {
      switch (buttonIndex) {
        case 1:
          progress1;
          break;
        case 2:
          progress2;
          break;
        case 3:
          progress3;
          break;
      }
    });
  }

  void _updateMaxScore() {
    setState(() {
      if (maxScore < 10) {
        maxScore += 1;
      } else {
        maxScore = 0;
      }
    });
  }
}

class VerticalProgressIndicator extends StatelessWidget {
  final Color color;
  final double value;
  final double maxScore;

  VerticalProgressIndicator(this.color, this.value, this.maxScore);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.5708, // Rotate 90 degrees (in radians)
      child: LinearProgressIndicator(
        backgroundColor:
            color, // Set background color to the same as the score color
        value: maxScore > 0 ? value / maxScore : 0,
        //value: maxScore > 3 ? value / maxScore : 3,
        valueColor: AlwaysStoppedAnimation<Color>(
            Colors.black), // Set indicator color to black
      ),
    );
  }
}

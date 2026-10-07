import 'package:flutter/material.dart';

class MatchProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String age;
  final String height;
  final String occupation;
  final String location;
  final String isVerified;

  const MatchProfileCard({
    required this.imagePath,
    required this.name,
    required this.age,
    required this.height,
    required this.occupation,
    required this.location,
    required this.isVerified,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Image Container
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              // image: DecorationImage(
              //   image: imagePath != ""
              //       ? NetworkImage(imagePath)
              //       : const AssetImage("images/img.png") as ImageProvider,
              //   fit: BoxFit.cover,
              // ),
              image: DecorationImage(
                image: imagePath != ""
                    ? NetworkImage(imagePath)
                    : const AssetImage("images/img.png") as ImageProvider,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter, // <-- keeps top visible
              ),

            ),
          ),
          // Bottom aligned details (without background)
          Positioned(
            bottom: 16, // Bring the text a bit upwards from the bottom
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isVerified == "1")
                      const Icon(Icons.verified, color: Colors.blue, size: 24),
                    const SizedBox(width: 6),
                    Text(
                      '$name, $age',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.black,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$height • $occupation • $location',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nagarathar/description.dart';
import 'package:nagarathar/imageCarousel.dart';
import 'package:url_launcher/url_launcher.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

Future<void> _launchURL(String websiteUrl) async {
  final Uri url = Uri.parse(websiteUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $websiteUrl';
  }
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCarousel(assetLocations: [
            "assets/castle.png",
            "assets/map.png",
            "assets/castle.png"
          ]),
          // Row(
          //   children: [
          //     Container(
          //       height: 50,
          //       child: Stack(
          //         children: List.generate(
          //           4,
          //           (index) {
          //             return Row(
          //               children: [
          //                 SizedBox(
          //                   width: (10 * index).toDouble(),
          //                 ),
          //                 Container(
          //                   height: 50,
          //                   width: 50,
          //                   decoration: BoxDecoration(
          //                     border: Border.all(color: Colors.black, width: 1),
          //                     color: const Color.fromARGB(255, 62, 54, 217),
          //                     borderRadius: BorderRadius.circular(50),
          //                   ),
          //                 ),
          //               ],
          //             );
          //           },
          //         ),
          //       ),
          //     ),
          //     const Text(
          //       "+20 More Going",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 18,
          //         decoration: TextDecoration.none,
          //       ),
          //     )
          //   ],
          // ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Nagarathar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 48,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "12:00 AM - 7:00 PM",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "June 22, 2025",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Someplace,UK My Hotel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                decoration: TextDecoration.none,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "About",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                descriptionBox(
                  ellipsis: true,
                  description:
                      "lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem ",
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        "https://www.google.com/maps/place/Altstetten,+Z%C3%BCrich,+Switzerland/@47.3880368,8.4434407,13884m/data=!3m1!1e3!4m6!3m5!1s0x47900bc0e470d21d:0x1fcd415ee1d510e0!8m2!3d47.3882368!4d8.4830508!16s%2Fm%2F03h4vmb?entry=ttu&g_ep=EgoyMDI1MDEyMi4wIKXMDSoASAFQAw%3D%3D");
                  },
                  child: Image.asset(
                    'assets/map.png',
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

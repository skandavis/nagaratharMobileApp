import 'package:flutter/material.dart';
import 'package:nagarathar/description.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
            "https://media-cdn.tripadvisor.com/media/photo-s/01/5d/28/78/montego-bay.jpg"),
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
              descriptionBox(ellipsis: true, description: "hello"),
            ],
          ),
        ),
      ],
    );
  }
}

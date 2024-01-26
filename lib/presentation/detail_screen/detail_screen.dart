import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('세부 정보'), actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.info_outline),
        ),
      ]),
      body: Column(
        children: [
          Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png'),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black, width: 2.0),
              ),
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Column(
                    children: [
                      Text(
                        'About',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(''),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'STAT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(''),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Evolution',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(''),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ],
                      ),
                      Text(''),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Against',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(''),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

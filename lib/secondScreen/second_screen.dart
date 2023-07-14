import 'package:flutter/material.dart';
import 'package:suitmedia_app/secondScreen/models/username_model.dart';
import 'package:suitmedia_app/thirdScreen/view/third_screen.dart';

import '../thirdScreen/models/service.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserName;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'assets/left_back.png',
              width: 10,
            )),
        title: const Text(
          'Second Screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff04021D),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: Colors.grey,
            height: 0.3,
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 21, top: 13, right: 21, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff04021D),
                  ),
                ),
                Text(
                  args.name!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff04021D),
                  ),
                ),
              ],
            ),
            Center(
                child: args.username == null
                    ? const Text(
                        'Selected User Name',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff04021D),
                        ),
                      )
                    : Text(
                        args.username!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff04021D),
                        ),
                      )),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/third-screen',
                  arguments: UserName(name: args.name),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2B637B),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Choose a User'),
            ),
          ],
        ),
      ),
    );
  }
}

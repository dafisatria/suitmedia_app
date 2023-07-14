import 'package:flutter/material.dart';
import 'package:suitmedia_app/secondScreen/models/username_model.dart';
import 'package:suitmedia_app/secondScreen/second_screen.dart';
import 'package:suitmedia_app/thirdScreen/models/user_model.dart';

import '../models/service.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final MyService service = MyService();
  Future getUser() async {
    try {
      await service.getUser();
      setState(() {});
    } catch (e) {
      Text(e.toString());
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

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
          'Third Screen',
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
        padding: const EdgeInsets.only(left: 21, top: 15, right: 21),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(service.user[index].avatar!),
                  ),
                  title: Text(
                      '${service.user[index].firstName!} ${service.user[index].lastName!}'),
                  subtitle: Text(service.user[index].email!),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/second-screen',
                      arguments: UserName(
                          username:
                              '${service.user[index].firstName!} ${service.user[index].lastName!}',
                          name: args.name));
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: service.user.length),
      ),
    );
  }
}

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
  List<UserModel> data = [];
  int currentPage = 1;
  ScrollController scrollController = ScrollController();
  bool isFetchingData = false;

  Future<void> loadMoreData() async {
    if (!isFetchingData) {
      setState(() {
        isFetchingData = true;
      });
      try {
        final newData = await service.getUser(page: currentPage);
        setState(() {
          data.addAll(newData);
          currentPage++;
          isFetchingData = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          isFetchingData = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    service.getUser(page: currentPage).then((newData) {
      setState(() {
        data.addAll(newData);
        currentPage++;
      });
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          loadMoreData();
        }
      });
    });
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
        padding: const EdgeInsets.only(left: 21, right: 21),
        child: ListView.separated(
          controller: scrollController,
          itemCount: data.length + 1,
          itemBuilder: (context, index) {
            if (index == data.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final item = data[index];
            return InkWell(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.avatar!),
                ),
                title: Text('${item.firstName!} ${item.lastName!}'),
                subtitle: Text(item.email!),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/second-screen',
                    arguments: UserName(
                        username: '${item.firstName!} ${item.lastName!}',
                        name: args.name));
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 25,
          ),
        ),
      ),
    );
  }
}

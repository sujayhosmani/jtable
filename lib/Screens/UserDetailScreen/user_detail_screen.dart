import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jtable/Helpers/signalR_services.dart';
import 'package:jtable/Models/Users.dart';
import 'package:jtable/Screens/Providers/network_provider.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  Users? loggedInUser;

  @override
  void initState() {
    loggedInUser = Provider.of<NetworkProvider>(context, listen: false).users;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ottoman"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black,),
            onPressed: () => {
              _handleRefresh()
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: CachedNetworkImage(height: 75, width: 75, fit: BoxFit.cover, imageUrl:  "https://img.freepik.com/free-icon/user_318-563642.jpg",)
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(loggedInUser?.name ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        Text(loggedInUser?.role ?? ""),
                        Text(loggedInUser?.phone ?? ""),
                      ],
                    )

                  ],
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Logout"),
              dense: true,
              textColor: Colors.red,
              onTap: (){
                print("sdg");
              },
            )
          ],
        ),
      ),
    );
  }

  _handleRefresh() {
    Provider.of<SignalRService>(context, listen: false).initializeConnection(context);
  }
}

class ProfileCircle {
}

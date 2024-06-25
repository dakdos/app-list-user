import 'package:flutter/material.dart';
import '/config/export.dart';
import '/utils/appbar_shite.dart';
import '/utils/image_profile.dart';
import '/viewModels/list_user_view_model.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);
  @override
  ListUserState createState() =>  ListUserState();
}

class ListUserState extends ListUserViewModel  {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contex, constrants) {
      return Scaffold(
        appBar: AppbarWhite(title: 'List User Profile'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (scrollModel!.isLoading) ... [
              Center(
                child: CircularProgressIndicator(color: HexColor('#EA261D')),
              ),
            ] else ... [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 18, right: 18, bottom: 32),
                  controller: scrollController,
                  itemCount: listUser.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == listUser.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Center(
                          child:  Opacity(
                            opacity: scrollModel!.isPerformingRequest ? 1.0 : 0.0,
                            child: CircularProgressIndicator(color:HexColor('#EA261D')),
                          ),
                        ),
                      );
                    } else {
                      return  Container(
                        margin: const EdgeInsets.only(top:12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 12,
                              offset: const Offset(0, 2), 
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: ListTile(
                            leading: ImageProfile(
                              image: listUser[index].avatar,
                            ),
                            title: Text(
                            "${listUser[index].firstName} ${listUser[index].lastName}",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(listUser[index].email,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),  
                      );
                    }
                  },
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import '/config/export.dart';
import '/views/list_user.dart';
import '/models/infiter_scroll_model.dart';
import '/models/user_model.dart';

abstract class ListUserViewModel extends State<ListUser> {

  ScrollController scrollController = ScrollController();
  List<UserModel> listUser = [];
  bool loadAllData = false;
  ScrollModel? scrollModel;

  /// Fetches a list of user models from an API endpoint.
  ///
  /// This method is responsible for fetching a list of user models from an API endpoint. It updates the page number and loading state of the [scrollModel] object, makes the API request, and then parses the response to create a list of [UserModel] instances.
  ///
  /// The method returns the list of fetched user models. If the API request fails or there are no more users to fetch, the method will set the [loadAllData] flag to `true`.
  Future<List<UserModel>> getUser() async {
    List<UserModel> listUser = [];

    if (mounted) {
      setState(() {
        if (scrollModel!.loadSearch == true) {
            scrollModel!.pageNumber++;
        } else {
          scrollModel!.isLoading = true;
          scrollModel!.pageNumber = 1;
        }
      });
    }

    final url = 'users?page=${scrollModel!.pageNumber}';
    final jsonResponse = await CallApi().getDataNoToken(url).timeout(const Duration(seconds: 30));
     
    final jsonBody = await json.decode(jsonResponse.body);
    final user = jsonBody['data'];
    for (var usr in user) {
      UserModel newUser = UserModel(
        usr["id"],
        usr["email"], 
        usr['first_name'],
        usr['last_name'],
        usr['avatar'] ?? '', 
      );
      listUser.add(newUser);
    }

    if (mounted) {
      setState(() {
        scrollModel!.isLoading = false;
      });
    }
    return listUser;
  }

  /// Fetches more data for the list of user models.
  ///
  /// This method is responsible for fetching more user models from the API endpoint. It checks if a request is currently in progress, and if not, it sets the `isPerformingRequest` flag to `true`. It then calls the `getUser()` method to fetch the new user models.
  ///
  /// If the API response contains new user models, they are added to the `listUser` list. If the response is empty, the `_fetchMoreDataIfNearBottom()` method is called to check if the user has scrolled to the bottom of the list.
  ///
  /// If the `loadSearch` flag is `false`, the `listUser` list is cleared before adding the new user models.
  ///
  /// Finally, the `isPerformingRequest` flag is set to `false` to indicate that the request has completed.
  void getMoreData() async {
    if (!scrollModel!.isPerformingRequest) {
      setState(() {
        scrollModel!.isPerformingRequest = true;
      });
      List<UserModel> newEntries = await getUser();

      if (newEntries.toString() != '[]') {
        if (newEntries.isEmpty ) {
          _fetchMoreDataIfNearBottom();
        }
      } else {
        setState(() {
          loadAllData = true;
        });
      }

      if (scrollModel!.loadSearch == false) {
        listUser.clear();
      }
      if (mounted) {
        setState(() {
          listUser.addAll(newEntries);
          scrollModel!.isPerformingRequest = false;
        });
      }
    }
  }

  /// Checks if the user has scrolled to the bottom of the list and fetches more data if needed.
  ///
  /// This method calculates the distance between the current scroll position and the bottom of the list. If the distance is less than 1000 pixels, it calls the `getMoreData()` method to fetch more data for the list.
  void _fetchMoreDataIfNearBottom() {
    double edge = 1000.0;
    double offsetFromBottom = scrollController.position.maxScrollExtent - scrollController.position.pixels;
    if (offsetFromBottom < edge && scrollController.hasClients) {
      getMoreData();
    }
  }

  /// Fetches all the data for the list of user models.
  ///
  /// This method is responsible for fetching all the user models from the API endpoint. It checks if the `loadSearch` flag is `true`, in which case it increments the `pageNumber`. Otherwise, it resets the `pageNumber` to 1. It then sets the `isLoading` flag to `true` and calls the `getMoreData()` method to fetch the new user models.
  void getAllData() {
    if (mounted) {
      setState(() {
        if (scrollModel!.loadSearch == true) {
          scrollModel!.pageNumber++;
        } else {
          scrollModel!.pageNumber = 1;
        }
        scrollModel!.isLoading = true;
        getMoreData();
      });
    }
  }

  @override
  /// Disposes of the scroll controller associated with this view model.
  ///
  /// This method is called when the view model is being disposed of, and ensures that the scroll controller is properly cleaned up to avoid memory leaks.
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override

  /// Initializes the state of the list user view model.
  ///
  /// This method is called when the view model is first created. It sets up the scroll model and controller, and adds a listener to the scroll controller to handle loading more data when the user scrolls to the bottom of the list. It then calls the [getAllData] method to fetch the initial set of user data.

  void initState() {
    super.initState();
    scrollModel = ScrollModel();
    scrollController = ScrollController(initialScrollOffset: 0.0);
    scrollController.addListener(() {
      scrollModel!.loadSearch = true;
      if (scrollModel!.loadSearch == true) {
        getMoreData();
      }
    });
    getAllData();
  }
}

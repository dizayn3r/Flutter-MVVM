import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/data/response/status.dart';
import 'package:flutter_mvvm_demo/res/color.dart';
import 'package:flutter_mvvm_demo/utils/routes/routes_name.dart';
import 'package:flutter_mvvm_demo/utils/utils.dart';
import 'package:flutter_mvvm_demo/view_model/home_view_model.dart';
import 'package:flutter_mvvm_demo/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => userPreference.remove().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => false),
                ),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
          switch (value.moviesList.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            case Status.error:
              return Center(child: Text(value.moviesList.message.toString()));
            case Status.completed:
              return ListView.builder(
                  itemCount: value.moviesList.data!.movies!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          value.moviesList.data!.movies![index].posterurl
                              .toString(),
                          errorBuilder: (context, error, stack) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(value.moviesList.data!.movies![index].title
                            .toString()),
                        subtitle: Text(value
                            .moviesList.data!.movies![index].year
                            .toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.averageRating(value
                                    .moviesList.data!.movies![index].ratings!)
                                .toStringAsFixed(1)),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            default:
              return Center(
                child: Text(""),
              );
          }
          return Container();
        }),
      ),
    );
  }
}

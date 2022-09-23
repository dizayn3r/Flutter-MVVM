

import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_demo/data/response/api_response.dart';
import 'package:flutter_mvvm_demo/models/movies_model.dart';
import 'package:flutter_mvvm_demo/repo/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {

  final _myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response){
    moviesList = response ;
    notifyListeners();
  }


  Future<void> fetchMoviesListApi ()async{

    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value){

      setMoviesList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setMoviesList(ApiResponse.error(error.toString()));

    });
  }


}
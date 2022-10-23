import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/res/color.dart';
import 'package:flutter_mvvm_demo/utils/routes/routes_name.dart';
import 'package:flutter_mvvm_demo/utils/routes/routes.dart';
import 'package:flutter_mvvm_demo/view_model/auth_view_model.dart';
import 'package:flutter_mvvm_demo/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            centerTitle: true,
          ),
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

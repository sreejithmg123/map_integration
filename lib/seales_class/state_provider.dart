import 'package:dependency_injection/seales_class/state.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class StateProvider extends ChangeNotifier {
  AppState state = LoadingState();
  Locale? locale;
  Future<void> getCount() async {
    // updateState(LoadingState());

    await Future.delayed(
      const Duration(seconds: 3),
      () {
        List.generate(100, (index) => null);
        // changeLocale('en');
      },
    );
    updateState(LoadedState());
  }

  changeLocale(BuildContext context, Locale value) async {
    updateState(LoadingState());
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        //Intl.defaultLocale = value;
        //MyApp.setLocale(context, const Locale('ar'));
        locale = value;
        print(locale);
      },
    );
    updateState(LoadedState());
    notifyListeners();
  }

  Dio dio = Dio(); // Create a Dio instance

  Future<void> postData() async {
    // try {
    final response = await dio.post(
      'https://staffservice-caribou.webc.in/api/staff/order/list',
      // data: {'Api-Key': 'UVRCR1UNVSlBWVjlEVDBaR1JVVmZVRkpQUkZWRFZEUlY5QlVFbGZWRTlMUlU0PQDB0RlRnPT0=='}, // Request data
      options: Options(
        headers: {
          'Authorization':
              'Bearer 65290b56cdbf0d76ff0e3094|1hi8yOBoBDZLPjPHNb04tGYAWoFjypmGBYPH2LMp',
          'Api-Key':
              'UVRCR1UNVSlBWVjlEVDBaR1JVVmZVRkpQUkZWRFZEUlY5QlVFbGZWRTlMUlU0PQDB0RlRnPT0=='
        },
      ),
    );

    // Handle the response
    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');
    // } catch (e) {
    //   // Handle errors
    //   print('Error: $e');
    // }
  }

  updateState(AppState value) {
    state = value;
    notifyListeners();
  }
}

import 'package:dependency_injection/locale_provider.dart';
import 'package:dependency_injection/seales_class/state.dart';
import 'package:dependency_injection/seales_class/state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StateScreen extends StatefulWidget {
  const StateScreen({Key? key}) : super(key: key);

  @override
  State<StateScreen> createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  late StateProvider stateProvider;

  @override
  void initState() {
    stateProvider = StateProvider();
    stateProvider.getCount();
    stateProvider.postData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: stateProvider,
      child: Scaffold(
        body: Consumer<StateProvider>(
          builder: (context, provider, child) {
            return _switchView(provider.state, provider);
          },
        ),
      ),
    );
  }

  _switchView(AppState state, StateProvider stateProvider) {
    print('locale ${stateProvider.locale}');
    Widget child = const SizedBox.shrink();
    switch (state) {
      case LoadedState():
        child = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.helloWorld),
              FloatingActionButton(onPressed: () {
                stateProvider.changeLocale(context, const Locale('ar'));
              })
            ],
          ),
        );
        break;
      case LoadingState():
        child = const Center(
          child: CircularProgressIndicator(),
        );
        break;
      case ErrorState():
        break;
    }
    return child;
  }
}

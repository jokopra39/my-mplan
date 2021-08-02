import './bloc_setting.dart';

class MainBlocChart extends BloCSetting {
  final String title = "setState() is powerful";
  int counter1 = 0;
  int counter2 = 0;
  int counterChart = 0;
}

MainBlocChart mainBlocChart; // it is important to not instantiate it at this stage;

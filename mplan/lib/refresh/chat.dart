import 'package:flutter/material.dart';

import 'bloc_setting.dart';
import 'main_bloc _chart.dart';

class CountChart extends BloCSetting {
  int counterChart = 0;
  incrementCounterChart(state) {

    rebuildWidgets(
      setStates: () {
        counterChart++;
      },
      states: [state],
    );

    mainBlocChart?.counterChart++;
  }
}

CountChart countChart;
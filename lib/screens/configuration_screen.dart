import 'package:flutter/material.dart';
import 'package:focus/components/time_slider_card.dart';
import 'package:focus/screens/tempo_screen.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/components/number_selection_card.dart';
import 'package:provider/provider.dart';
import 'package:focus/state/settings.dart';

class ConfigurationScreen extends StatelessWidget {
  static const String id = 'ConfigurationScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Configuration',
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 25,
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NumberSelectionCard(
                  value: Provider.of<Settings>(context).setsCount,
                  title: 'Sets',
                  onChanged: (newValue) {
                    Provider.of<Settings>(context, listen: false).setsCount = newValue;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                NumberSelectionCard(
                  value: Provider.of<Settings>(context).repsCount,
                  title: 'Reps',
                  onChanged: (newValue) {
                    Provider.of<Settings>(context, listen: false).repsCount = newValue;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Consumer<Settings>(
                  builder: (context, settings, child) => TimeSliderCard(
                    value: settings.holdTime,
                    onChanged: (newValue) {
                      if (newValue.ceil() != settings.holdTime) {
                        settings.holdTime = newValue.ceil();
                      }
                    },
                    title: 'Rest Time',
                    min: 5,
                  ),
                ),
                NumberSelectionCard(
                  value: Provider.of<Settings>(context).concentric,
                  title: 'Concentric',
                  onChanged: (newValue) {
                    Provider.of<Settings>(context, listen: false).concentric = newValue;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                NumberSelectionCard(
                  value: Provider.of<Settings>(context).eccentricPause,
                  title: 'Pause',
                  onChanged: (newValue) {
                    Provider.of<Settings>(context, listen: false).eccentricPause = newValue;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                NumberSelectionCard(
                  value: Provider.of<Settings>(context).eccentric,
                  title: 'Eccentric',
                  onChanged: (newValue) {
                    Provider.of<Settings>(context, listen: false).eccentric = newValue;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                NumberSelectionCard(
                  value: Provider.of<Settings>(context).concentricPause,
                  title: 'Pause',
                  onChanged: (newValue) {
                    Provider.of<Settings>(context, listen: false).concentricPause = newValue;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.lightBlueAccent,
                  height: 50.0,
                  onPressed: () {
                    Navigator.pushNamed(context, TempoScreen.id);
                  },
                  child: Text(
                    'GO',
                    style: kTitleTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

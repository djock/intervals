import 'package:flutter/material.dart';
import 'package:focus/new_components/tempo_animation.dart';
import 'package:provider/provider.dart';
import 'package:focus/components/round_container.dart';
import 'package:focus/state/settings.dart';

class TempoCircleController extends ValueNotifier<bool> {
  TempoCircleController({bool animationShouldRun})
      : super(animationShouldRun ?? false);

  tempoState state;

  void stopAnimation() {
    this.value = false;
  }

  void startAnimation() {
    this.value = true;
  }

  void setState(tempoState newState) {
    state = newState;
  }
}

class TempoCircle extends StatefulWidget {
  TempoCircle({
    this.onFinishEccentric,
    this.onFinishConcentric,
    this.child,
    TempoCircleController controller,
  }) : _controller = controller;

  final Function onFinishEccentric;
  final Function onFinishConcentric;
  final Widget child;
  final TempoCircleController _controller;

  @override
  _TempoCircleState createState() => _TempoCircleState();
}

class _TempoCircleState extends State<TempoCircle>
    with SingleTickerProviderStateMixin {
  static const double _baseRadius = 80;

  double _circleRadius = _baseRadius;
  tempoState _tempoState = tempoState.eccentric;

  TempoAnimation _tempoAnimation;

  TempoCircleController _controller;
  Function _listener;

  Settings _settings;

  @override
  void initState() {
    super.initState();
    _controller = widget._controller ?? TempoCircleController();

    _listener = () {
      if (_controller.value) {
        _tempoAnimation.start();
      } else {
        _tempoAnimation.stop();
      }
    };

    _controller.addListener(_listener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _settings = Provider.of<Settings>(context);
    if (_tempoAnimation == null) {
      _tempoAnimation = TempoAnimation(
        vsync: this,
        min: _baseRadius,
        max: _baseRadius * 1.5,
        increaseDuration: _settings.eccentric,
        decreaseDuration: _settings.concentric,

        onFinishConcentric: widget.onFinishConcentric,
        onFinishEccentric: widget.onFinishEccentric,
      );

      _tempoAnimation.addListener(() {
        setState(() {
          _circleRadius = _tempoAnimation.value;
          _tempoState = _tempoAnimation.state;
        });
      });

      _controller.startAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundContainer(
      radius: _circleRadius,
      color: _tempoState == tempoState.eccentric
          ? Colors.lightBlueAccent[200]
          : Colors.redAccent[200],
      child: Center(
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _tempoAnimation.dispose();
    _controller?.stopAnimation();
    _controller?.removeListener(_listener);
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';

class StyledSwitch extends StatefulWidget {
  final void Function(bool isToggled) onToggled;

  const StyledSwitch({Key? key, required this.onToggled}) : super(key: key);

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  bool isToggled = false;
  double size = 24;
  double innerPadding = 0;

  @override
  void initState() {
    innerPadding = size / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isToggled = !isToggled);
        widget.onToggled(!isToggled);
      },
      onPanEnd: (b) {
        setState(() => isToggled = !isToggled);
        widget.onToggled(!isToggled);
      },
      child: AnimatedContainer(
        height: size*0.9,
        width: size * 1.6,
        padding: EdgeInsets.all(innerPadding),
        alignment: isToggled ? Alignment.centerLeft : Alignment.centerRight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          color: isToggled ? AppColors.lightGrey : AppColors.green,
        ),
        child: Container(
          width: size - innerPadding * 2.5,
          height: size - innerPadding * 2.5,
          padding: const EdgeInsets.only(right: 4,left: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(102),
            color: isToggled ? AppColors.whiteColor : AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
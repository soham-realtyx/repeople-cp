
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/helpers.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Widget/CustomAppBar/custom_appbar.dart';


class PickerDialogCustomStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  PickerDialogCustomStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
  });
}

class CountryPickerCustomDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogCustomStyle? style;

  const CountryPickerCustomDialog({
    Key? key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerCustomDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(

        body: WillPopScope(
          onWillPop: () async {
            Get.back();
            return false;
          },
          child: Stack(children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(top:70 ),
              color: AppColors.whiteColor,
              child:
              // Obx(() {
              //   return
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 15, right: 15),
                    child: TextField(
                      cursorColor: widget.style?.searchFieldCursorColor,
                      style: mediumTextStyle(fontSize: 14, txtColor: AppColors.black),
                      decoration: widget.style?.searchFieldInputDecoration ??
                          InputDecoration(
                            hintText: "Select Country",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.black),
                            ),
                            contentPadding: const EdgeInsets.all(2.0),
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.withOpacity(0.8),
                                fontWeight: FontWeight.bold),
                          ),
                      onChanged: (value) {
                        _filteredCountries = isNumeric(value)
                            ? widget.countryList
                            .where((country) => country.dialCode.contains(value))
                            .toList()
                            : widget.countryList
                            .where((country) =>
                            country.name.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                        if (mounted) setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredCountries.length,
                      itemBuilder: (ctx, index) => Column(
                        children: <Widget>[
                          ListTile(
                            leading: Image.asset(
                              'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                              package: 'intl_phone_field',
                              width: 32.w,
                            ),
                            contentPadding: widget.style?.listTilePadding,
                            title: Text(
                              _filteredCountries[index].name,
                              style: widget.style?.countryNameStyle ??
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              '+${_filteredCountries[index].dialCode}',
                              style: widget.style?.countryCodeStyle ??
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              _selectedCountry = _filteredCountries[index];
                              widget.onCountryChanged(_selectedCountry);
                              Navigator.of(context).pop();
                            },
                          ),
                          widget.style?.listTileDivider ?? const Divider(thickness: 1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // }),
            ),
           Positioned(
               top: 0,
               left: 0,right: 0,
               child: CustomDetailsAppBar(
             title: "Select Country Code",
             leadingWidget: [
               InkWell(
                   onTap: () => Get.back(),
                   child: SvgPicture.asset(backArrowSvgIcons,height: 18,/*width: 24,*/)
               ),
               const SizedBox(width: 10,),
               Text(
                 "select country code",
                 style: TextStyle(color: AppColors.greyColor, fontSize: 20,
                     fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),maxLines: 1,
               )
             ],
             trillingWidget: const [],
             height: 70,
             color:  AppColors.appGreyColor,

           ))

          ],)


        ),
      );
}

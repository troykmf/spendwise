import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Appicons {
  final List<Map<String, dynamic>> homeExpensesCategories = [
    {
      'name': 'Gas Filling',
      'icon': FontAwesomeIcons.gasPump,
    },
    {
      'name': 'Grocery',
      'icon': FontAwesomeIcons.cartShopping,
    },
    {
      'name': 'Internet',
      'icon': FontAwesomeIcons.wifi,
    },
    {
      'name': 'Electricity',
      'icon': FontAwesomeIcons.bolt,
    },
    {
      'name': 'Water',
      'icon': FontAwesomeIcons.water,
    },
    {
      'name': 'Rent',
      'icon': FontAwesomeIcons.house,
    },
    {
      'name': 'Entertainment',
      'icon': FontAwesomeIcons.film,
    },
    {
      'name': 'HealthCare',
      'icon': FontAwesomeIcons.suitcaseMedical,
    },
    {
      'name': 'Transportation',
      'icon': FontAwesomeIcons.bus,
    },
    {
      'name': 'Clothing',
      'icon': FontAwesomeIcons.shirt,
    },
    {
      'name': 'Phone Bill',
      'icon': FontAwesomeIcons.phone,
    },
    {
      'name': 'Dining Out',
      'icon': FontAwesomeIcons.utensils,
    },
    {
      'name': 'Insurance',
      'icon': FontAwesomeIcons.shieldHalved,
    },
  ];

  IconData getExpenseCategoryIcons(String categoryName) {
    final category = homeExpensesCategories.firstWhere(
      (category) => category['name'],
      orElse: () => {'icon': FontAwesomeIcons.cartShopping},
    );
    return category['icon'];
  }
}

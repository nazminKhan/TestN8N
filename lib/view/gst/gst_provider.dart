import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GstProvider with ChangeNotifier {
  double _amount = 0;
  double _gstRate = 0;
  double _originalCost = 0;
  double _rateAmount = 0;
  double _csgst = 0;
  double _gstPercentage = 0;
  bool _isAddGst = true;
  List<Map<String, dynamic>> _savedCalculations = [];

  double get amount => _amount;
  double get gstRate => _gstRate;
  double get originalCost => _originalCost;
  double get rateAmount => _rateAmount;
  double get csgst => _csgst;
  double get gstPercentage => _gstPercentage;
  bool get isAddGst => _isAddGst;
  List<Map<String, dynamic>> get savedCalculations => _savedCalculations;

  GstProvider() {
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _amount = prefs.getDouble('amount') ?? 0;
    _gstRate = prefs.getDouble('gstRate') ?? 0;
    _originalCost = prefs.getDouble('originalCost') ?? 0;
    _rateAmount = prefs.getDouble('rateAmount') ?? 0;
    _csgst = prefs.getDouble('csgst') ?? 0;
    _gstPercentage = prefs.getDouble('gstPercentage') ?? 0;
    _isAddGst = prefs.getBool('isAddGst') ?? true;
    _savedCalculations = prefs.getStringList('savedCalculations')?.map((e) => Map<String, dynamic>.from(jsonDecode(e))).toList() ?? [];
    notifyListeners();
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('amount', _amount);
    prefs.setDouble('gstRate', _gstRate);
    prefs.setDouble('originalCost', _originalCost);
    prefs.setDouble('rateAmount', _rateAmount);
    prefs.setDouble('csgst', _csgst);
    prefs.setDouble('gstPercentage', _gstPercentage);
    prefs.setBool('isAddGst', _isAddGst);
    prefs.setStringList('savedCalculations', _savedCalculations.map((e) => jsonEncode(e)).toList());
  }

  void calculateGst(double amount, double gstRate, bool isAddGst) {
    _amount = amount;
    _gstRate = gstRate;
    _isAddGst = isAddGst;

    if (_isAddGst) {
      _originalCost = amount + (amount * gstRate) / 100;
      _rateAmount = (amount * gstRate) / 100;
    } else {
      _originalCost = amount - ((amount / (100 + gstRate)) * gstRate);
      _rateAmount = (amount / (100 + gstRate)) * gstRate;
    }
    _csgst = _rateAmount / 2;
    _gstPercentage = gstRate / 2;

    _saveData();
    notifyListeners();
  }

  void saveCalculation() {
    _savedCalculations.add({
      'amount': _amount,
      'gstRate': _gstRate,
      'originalCost': _originalCost,
      'rateAmount': _rateAmount,
      'csgst': _csgst,
      'gstPercentage': _gstPercentage,
      'isAddGst': _isAddGst,
    });
    _saveData();
    notifyListeners();
  }
}
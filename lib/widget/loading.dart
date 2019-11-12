import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;

  LoadingContainer({this.child, this.isLoading = true});

  Widget _loadingView () {
    return Center(
      child: CircularProgressIndicator()
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading ? child : _loadingView();
  }
}
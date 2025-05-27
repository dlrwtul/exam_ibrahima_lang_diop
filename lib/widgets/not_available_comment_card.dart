import 'package:flutter/material.dart';

class NotAvailableCommentCard extends StatelessWidget {
  const NotAvailableCommentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(
            color: Colors.grey,
            width: 0.25,
          )),
      elevation: 1,
      semanticContainer: true,
      child: ListTile(
        title: Center(child : Text(
          "Ce commantaire n'est plus disponible"
        )),
      ),
    );
  }
}

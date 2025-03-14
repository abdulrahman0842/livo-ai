import 'package:flutter/material.dart';
import 'package:livoai/services/api_service.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final apiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Result")),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: ListView.builder(
                    itemCount: widget.data.entries.length,
                    itemBuilder: (context, index) {
                      String key = widget.data.keys.elementAt(index);
                      String value = widget.data[key].toString();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$key - $value",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: apiController,
                decoration: InputDecoration(hintText: "API ENDPOINT"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  String response = await ApiService()
                      .detectDisease(widget.data,);

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(response),
                        );
                      });
                },
                child: Text("Predict")),
            SizedBox()
          ],
        ),
      )),
    );
  }
}

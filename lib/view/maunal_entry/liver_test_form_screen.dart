import 'package:flutter/material.dart';
import 'package:livoai/utils/utils.dart';
import 'package:livoai/view/maunal_entry/entry_view_model.dart';
import 'package:livoai/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class LiverTestForm extends StatefulWidget {
  const LiverTestForm({super.key});

  @override
  _LiverTestFormState createState() => _LiverTestFormState();
}

class _LiverTestFormState extends State<LiverTestForm> {
  final _formKey = GlobalKey<FormState>();
  int selectedGender = 1;
  final List<FocusNode> _focusNodes = List.generate(9, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(9, (index) => TextEditingController());
  final ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liver Test Form"),
        actions: [
          IconButton(
              onPressed: () {
                Utils().serverIpDialog(context, ipController, false);
              },
              icon: Icon(Icons.change_circle_outlined))
        ],
      ),
      body: Consumer<EntryViewModel>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.error.isNotEmpty) {
            return Center(
              child: Text("ERROR: ${provider.error}"),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Personal Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _controllers[0],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Age", border: OutlineInputBorder()),
                    validator: (value) =>
                        value!.isEmpty ? "Please enter age" : null,
                    focusNode: _focusNodes[0],
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focusNodes[1]);
                    },
                  ),
                  SizedBox(height: 20),
                  Text("Gender",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<int>(
                          title: Text("Male"),
                          value: 1,
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<int>(
                          title: Text("Female"),
                          value: 2,
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Test Parameters",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  ...List.generate(8, (index) {
                    List<String> labels = [
                      "Total Bilirubin",
                      "Direct Bilirubin",
                      "Alkaline Phosphotase",
                      "Alamine Aminotransferase",
                      "Aspartate Aminotransferase",
                      "Total Proteins",
                      "Albumin",
                      "Albumin and Globulin Ratio"
                    ];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: TextFormField(
                        controller: _controllers[index + 1],
                        focusNode: _focusNodes[index + 1],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: labels[index],
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (_) {
                          if (index == _focusNodes.length - 1) return;
                          if (index < _focusNodes.length - 1) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 2]);
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                        },
                        validator: (value) => value!.isEmpty
                            ? "Please enter ${labels[index]}"
                            : null,
                      ),
                    );
                  }),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      label: "Detect",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, int> formData = {
                            "Age": int.tryParse(_controllers[0].text) ?? 0,
                            "Gender": selectedGender,
                            "Total Bilirubin":
                                int.tryParse(_controllers[1].text) ?? 0,
                            "Direct Bilirubin":
                                int.tryParse(_controllers[2].text) ?? 0,
                            "Alkaline Phosphotase":
                                int.tryParse(_controllers[3].text) ?? 0,
                            "Alamine Aminotransferase":
                                int.tryParse(_controllers[4].text) ?? 0,
                            "Aspartate Aminotransferase":
                                int.tryParse(_controllers[5].text) ?? 0,
                            "Total Proteins":
                                int.tryParse(_controllers[6].text) ?? 0,
                            "Albumin": int.tryParse(_controllers[7].text) ?? 0,
                            "Albumin and Globulin Ratio":
                                int.tryParse(_controllers[8].text) ?? 0,
                          };

                          provider.detectDisease(formData);
                          
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Result"),
                                content: Text(provider.result),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:liver_app/view/result_screen.dart';
// import 'package:liver_app/widgets/custom_elevated_button.dart';
// import 'package:provider/provider.dart';

// import '../utils/utils.dart';
// import '../view_model/entry_view_model.dart';

// class LiverTestForm extends StatefulWidget {
//   const LiverTestForm({super.key});

//   @override
//   _LiverTestFormState createState() => _LiverTestFormState();
// }

// class _LiverTestFormState extends State<LiverTestForm> {
//   final _formKey = GlobalKey<FormState>();
//   int selectedGender = 1;
//   final List<FocusNode> _focusNodes = List.generate(9, (index) => FocusNode());
//   final List<TextEditingController> _controllers =
//       List.generate(9, (index) => TextEditingController());
//   final ipController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Liver Test Form"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Utils().serverIpDialog(context, ipController, false);
//               },
//               icon: const Icon(Icons.change_circle_outlined))
//         ],
//       ),
//       body: Consumer<EntryViewModel>(
//         builder: (context, provider, _) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.error.isNotEmpty) {
//             return Center(
//               child: Text("ERROR: ${provider.error}"),
//             );
//           }

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Personal Information",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: _controllers[0],
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                         labelText: "Age", border: OutlineInputBorder()),
//                     validator: (value) =>
//                         value!.isEmpty ? "Please enter age" : null,
//                     focusNode: _focusNodes[0],
//                     onFieldSubmitted: (_) {
//                       FocusScope.of(context).requestFocus(_focusNodes[1]);
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   const Text("Gender",
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: RadioListTile<int>(
//                           title: const Text("Male"),
//                           value: 1,
//                           groupValue: selectedGender,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedGender = value!;
//                             });
//                           },
//                         ),
//                       ),
//                       Expanded(
//                         child: RadioListTile<int>(
//                           title: const Text("Female"),
//                           value: 2,
//                           groupValue: selectedGender,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedGender = value!;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Text("Test Parameters",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 10),
//                   ...List.generate(8, (index) {
//                     List<String> labels = [
//                       "Total Bilirubin",
//                       "Direct Bilirubin",
//                       "Alkaline Phosphotase",
//                       "Alamine Aminotransferase",
//                       "Aspartate Aminotransferase",
//                       "Total Proteins",
//                       "Albumin",
//                       "Albumin and Globulin Ratio"
//                     ];
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 15.0),
//                       child: TextFormField(
//                         controller: _controllers[index + 1],
//                         focusNode: _focusNodes[index + 1],
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: labels[index],
//                           border: const OutlineInputBorder(),
//                         ),
//                         onFieldSubmitted: (_) {
//                           if (index == _focusNodes.length - 1) return;
//                           if (index < _focusNodes.length - 1) {
//                             FocusScope.of(context)
//                                 .requestFocus(_focusNodes[index + 1]);
//                           } else {
//                             FocusScope.of(context).unfocus();
//                           }
//                         },
//                         validator: (value) => value!.isEmpty
//                             ? "Please enter ${labels[index]}"
//                             : null,
//                       ),
//                     );
//                   }),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                             onPressed: () {
//                               for (var item in _controllers) {
//                                 item.clear();
//                               }
//                             },
//                             child: const Text("Clear All")),
//                       ),
//                       Expanded(
//                         child: CustomElevatedButton(
//                           label: "Detect",
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               Map<String, dynamic> formData = {
//                                 "Age":
//                                     double.tryParse(_controllers[0].text) ?? 0,
//                                 "Gender": selectedGender,
//                                 "Total Bilirubin":
//                                     double.tryParse(_controllers[1].text) ?? 0,
//                                 "Direct Bilirubin":
//                                     double.tryParse(_controllers[2].text) ?? 0,
//                                 "Alkaline Phosphotase":
//                                     double.tryParse(_controllers[3].text) ?? 0,
//                                 "Alamine Aminotransferase":
//                                     double.tryParse(_controllers[4].text) ?? 0,
//                                 "Aspartate Aminotransferase":
//                                     double.tryParse(_controllers[5].text) ?? 0,
//                                 "Total Proteins":
//                                     double.tryParse(_controllers[6].text) ?? 0,
//                                 "Albumin":
//                                     double.tryParse(_controllers[7].text) ?? 0,
//                                 "Albumin and Globulin Ratio":
//                                     double.tryParse(_controllers[8].text) ?? 0,
//                               };

//                               provider.detectDisease(formData);
//                               if (provider.result != null) {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => ResultScreen(
//                                               response: provider.result ?? {},
//                                             )));
//                               }
//                               // showDialog(
//                               //   context: context,
//                               //   builder: (context) {
//                               //     return AlertDialog(
//                               //       title: const Text("Result"),
//                               //       content: Text(provider.result),
//                               //       actions: [
//                               //         TextButton(
//                               //           onPressed: () => Navigator.pop(context),
//                               //           child: const Text("OK"),
//                               //         )
//                               //       ],
//                               //     );
//                               //   },
//                               // );
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:liver_app/utils/utils.dart';
import 'package:liver_app/view/result_screen.dart';
import 'package:liver_app/view_model/entry_view_model.dart';
import 'package:liver_app/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class LiverTestFormScreen extends StatefulWidget {
  const LiverTestFormScreen({super.key});

  @override
  State<LiverTestFormScreen> createState() => _LiverTestFormScreenState();
}

class _LiverTestFormScreenState extends State<LiverTestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  int selectedGender = 1;
  final List<FocusNode> _focusNodes = List.generate(9, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(9, (index) => TextEditingController());
  final ipController = TextEditingController();
  // Map<String, dynamic>? response;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    final provider = context.read<EntryViewModel>();
    provider.addListener(() {
      if (provider.result != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(response: provider.result!),
          ),
        );
      }
    });
  }

  void detect(EntryViewModel provider) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> formData = {
        "Age": double.tryParse(_controllers[0].text) ?? 0,
        "Gender": selectedGender,
        "Total Bilirubin": double.tryParse(_controllers[1].text) ?? 0,
        "Direct Bilirubin": double.tryParse(_controllers[2].text) ?? 0,
        "Alkaline Phosphotase": double.tryParse(_controllers[3].text) ?? 0,
        "Alamine Aminotransferase": double.tryParse(_controllers[4].text) ?? 0,
        "Aspartate Aminotransferase":
            double.tryParse(_controllers[5].text) ?? 0,
        "Total Proteins": double.tryParse(_controllers[6].text) ?? 0,
        "Albumin": double.tryParse(_controllers[7].text) ?? 0,
        "Albumin and Globulin Ratio":
            double.tryParse(_controllers[8].text) ?? 0,
      };

      try {
        await context.read<EntryViewModel>().detectDisease(formData);
      } catch (e) {
        Utils.errorSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Consumer<EntryViewModel>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      return Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Personal Information",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _controllers[0],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: "Age",
                                  border: OutlineInputBorder()),
                              validator: (value) =>
                                  value!.isEmpty ? "Please enter age" : null,
                              focusNode: _focusNodes[0],
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[1]);
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text("Gender",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<int>(
                                    title: const Text("Male"),
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
                                    title: const Text("Female"),
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
                            const SizedBox(height: 20),
                            const Text("Test Parameters",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
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
                                    border: const OutlineInputBorder(),
                                  ),
                                  onFieldSubmitted: (_) {
                                    if (index == _focusNodes.length - 1) return;
                                    if (index < _focusNodes.length) {
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
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        for (var item in _controllers) {
                                          item.clear();
                                        }
                                      },
                                      child: const Text("Clear All")),
                                ),
                                Expanded(
                                    child: CustomElevatedButton(
                                        label: "Detect",
                                        onPressed: () {
                                          detect(provider);
                                        })),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

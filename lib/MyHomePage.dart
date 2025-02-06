import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String dropdownvalue = 'Egy';
String dropdownvalue2 = 'Egy';

  var items=[
      'Egy',
      'Doullar',
      'Euro',
      'Qatar',
    
  ];

  var items2=[
      'Egy',
      'Doullar',
      'Euro',
      'Qatar',
    
  ];
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.deepOrange,
    title: Center(child: Text('Currency Converter',style: TextStyle(fontWeight: FontWeight.bold),)),
    ),
    body: Column(children: [
      FormBuilderTextField(
        key: _formKey,                   
        name: "value that Convert",
      decoration: InputDecoration(labelText: 'Value'),
    validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.notZeroNumber(),
]),


    ),

          SizedBox(height: 50),
Text('FROM'),
     DropdownButton(
              
              // Initial Value
              value: dropdownvalue,
              
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
              
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
            Text('TO'),
            DropdownButton(
              
              // Initial Value
              value: dropdownvalue2,
              
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
              
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalue2 = newValue!;
                });
              },
            ),
            Container(width: 90,height: 90,color: Colors.brown,),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){}, child: Text('Covert',style: TextStyle(fontWeight: FontWeight.bold),))

     ],

    
    
    ),
    );
  }
}







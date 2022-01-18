<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Installation

* Add this to your package's pubspec.yaml file:

```
dependencies: 
    json_to_widget
```

* You can install packages from the command line: with Flutter:

```
$ flutter packages get
```

### JsonWidget

```
JsonWidget(
    decorations: decorations,
    form: form,
    onChanged: (dynamic response) {
        this.response = response;
    },
    actionSave: (data) {
        print(data);
    },
    buttonSave: new Container(
        height: 40.0,
        color: Colors.blueAccent,
        child: Center(
            child: Text("Login",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        ),
    ),
),
```

### Attribute
* form (Type String) Your form in String
* onChanged (Type Function)(1 parameter) call the function every time a change in the form is made
* padding (Type Double)
* formMap (Type Map) Your form in Map 
* errorMessages(Type Map) change string for error of required
* validations(Type Map) to add validation (TextInput,Input, Password, Email or TextArea)
* decorations(Type Map) to add decoration (TextInput,Input, Password, Email or TextArea)
* buttonSave(Type Widget) (not RaisedButton problem in onClick)
* actionSave(Type Function) the function is called when you click on the widget buttonSave

### Form
* Create Form String
```
String formString = json.encode({
    'title': 'form example',
    'description':'',
    'autoValidated': true, //default false
    'fields': [
        ...
    ]
});
```

* Create Form Map
```
Map formMap = {
    'title': 'form example',
    'description':'',
    'autoValidated': true, //default false
    'fields': [
        ...
    ]
};
```

### Fields
* All fields has attribute labelHidden(default false)
* Important add key for all field for validation required


### TextInput or Input

### Types?
* Input
* Password
* Email (has default validation)
* TextArea
* TextInput

```
// Example for json string
// to start with a default value you can add the value attribute
  String formString = json.encode({
    'fields': [
        {
             'key': 'inputKey',
             'type': 'Input',
             'label': 'Hi Group',
             'placeholder': "Hi Group flutter",
             'required': true
        },
        {
             'key': 'inputKey',
             'type': 'Input',
             'label': 'Initial Value',
             'value': 'Hello'
             'required': true
        },
    ]
 });
// Example for json Map
// in Map has Attributes validation and decoration

// important to receive 2 parameters in function of Validation
String validationExample(field, value) {
   if (value.isEmpty) {
     return 'Please enter some text';
   }
   return null;
}

Map formMap = {
    'fields': [
        {
                'key': 'inputKey',
                'type': 'Input',
                'label': 'Hi Group',
                'placeholder': "Hi Group flutter",
                'validator': 'digitsOnly',
                'required': true,
                'decoration': InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          border: OutlineInputBorder(),
                ),
                'validation':validationExample
        },
    ]
 };
```

### How can I place validations for my form String?
* In JsonSchema has attributes (validations, decorations)
* Important that each field has to has its unique key

```
Map decorations = {
    'inputKey': InputDecoration(
      labelText: "Enter your email",
      prefixIcon: Icon(Icons.account_box),
      border: OutlineInputBorder(),
    ),
  };
  
Map validations = {
    'inputKey': validationExample,
}

dynamic response;
new JsonWidget(
    decorations: decorations,
    validations: validations,
    form: formString,
    onChanged: (dynamic response) {
        this.response = response;
    },
    actionSave: (data) {
        print(data);
    },
    buttonSave: new Container(
        height: 40.0,
        color: Colors.blueAccent,
        child: Center(
            child: Text("Login",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        ,
    ),
)
```

### Radio
```
String formString = json.encode({
    'fields': [
         {
                'key': 'radiobutton1',
                'type': 'RadioButton',
                'label': 'Radio Button tests',
                'value': 2,
                'items': [
                  {
                    'label': "product 1",
                    'value': 1,
                  },
                  {
                    'label': "product 2",
                    'value': 2,
                  },
                  {
                    'label': "product 3",
                    'value': 3,
                  }
                ]
         },
    ],
 });
```

### Switch
```
String formString = json.encode({
    'fields': [
         {
                 'key': 'switch1',
                 'type': 'Switch',
                 'label': 'Switch test',
                 'value': false,
         },
    ],
 });
```

### Checkbox
```
String formString = json.encode({
    'fields': [
        {
                'key': 'checkbox1',
                'type': 'Checkbox',
                'label': 'Checkbox test',
                'items': [
                  {
                    'label': "product 1",
                    'value': true,
                  },
                  {
                    'label': "product 2",
                    'value': false,
                  },
                  {
                    'label': "product 3",
                    'value': false,
                  }
                ]
        }
    ],
 });
```

### Select (New Field)
```
String formString = json.encode({
    'fields': [
         {
                 'key': 'select1',
                 'type': 'Select',
                 'label': 'Select test',
                 'value':'product 1',
                 'items': [
                   {
                     'label': "product 1",
                     'value': "product 1",
                   },
                   {
                     'label': "product 2",
                     'value': "product 2",
                   },
                   {
                     'label': "product 3",
                     'value': "product 3",
                   }
                 ]
         }
    ],
 });
```

### when text is added to the TextField, add field called response
```
// initial form_send_email
[{"type":"Input","label":"Subject","placeholder":"Subject"},{"type":"TextArea","label":"Message","placeholder":"Content"}]

// add text (hi) in TextField Message, update dynamic response; and add field called response
[{type: Input, label: Subject, placeholder: Subject, value: hello}, {type: TextArea, label: Message, placeholder: Content, value: hi }]
```

### Json to Widget
* Import it Now in your Dart code, you can use
```
import 'package:json_to_widget/json_to_widget.dart';
```

## Usage
* TextField
```
String form = json.encode([
    {
      'type': 'Input',
      'title': 'Hi Group',
      'placeholder': "Hi Group flutter"
    },
    {
      'type': 'Password',
      'title': 'Password',
    },
    {
      'type': 'Email', 
      'title': 'Email test',
      'placeholder': "hola a todos"
    },
    {
      'type': 'TareaText',
      'title': 'TareaText test',
      'placeholder': "hola a todos"
    },
  ]);
```

* Radio
```
String form = json.encode([
    {
      'type': 'RadioButton',
      'title': 'Radio Button tests',
      'value': 2,
      'list': [
        {
          'title': "product 1",
          'value': 1,
        },
        {
          'title': "product 2",
          'value': 2,
        },
        {
          'title': "product 3",
          'value': 3,
        }
      ]
    },
  ]);
```

* Switch
```
String form = json.encode([
    {
      'type': 'Switch',
      'title': 'Switch test',
      'switchValue': false,
    },
  ]);
```

* Checkbox
```
String form = json.encode([
    {
      'type': 'Checkbox',
      'title': 'Checkbox test 2',
      'list': [
        {
          'title': "product 1",
          'value': true,
        },
        {
          'title': "product 2",
          'value': true,
        },
        {
          'title': "product 3",
          'value': false,
        }
      ]
    },
  ]);
```

## Example
```
String form_send_email = json.encode([
    {'type': 'Input', 'title': 'Subject', 'placeholder': "Subject"},
    {'type': 'TareaText', 'title': 'Message', 'placeholder': "Content"},
  ]);
 dynamic response;
 
 @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(widget.title),
       ),
       body: SingleChildScrollView(
         child: Container(
           child: Column(children: <Widget>[
             JsonWidget(
               form: form,
               onChanged: (dynamic response) {
                 this.response = response;
               },
             ),
             RaisedButton(
                 child: new Text('Send'),
                 onPressed: () {
                   print(this.response.toString());
                 })
           ]),
         ),
       ),
     );
   }
```

### When there is a change in the form, the (dynamic response;) is updated,
```
onChanged: (dynamic response) {
                 this.response = response;
               },
```

### when text is added to the TextField, add field called response
```
// initial form_send_email
[{"type":"Input","title":"Subject","placeholder":"Subject"},{"type":"TareaText","title":"Message","placeholder":"Content"}]

// add text (hi) in TextField Message, update dynamic response; and add field called response
[{type: Input, title: Subject, placeholder: Subject}, {type: TareaText, title: Message, placeholder: Content, response: hi }]
```

TODO: Tell users more about the package: where to find more information, how to contribute to the
package, how to file issues, what response they can expect from the package authors, and more.

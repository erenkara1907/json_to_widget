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
$ flutter packages **get**
```

## Usage

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


TODO: Tell users more about the package: where to find more information, how to contribute to the
package, how to file issues, what response they can expect from the package authors, and more.

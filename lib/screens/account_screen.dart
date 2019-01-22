import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/screens/home_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.of(context).pop(HomeScreen());
            },
          )
        ],
      ),
      body: AccountBody(),
    );
  }
}

class AccountBody extends StatefulWidget {
  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  TextEditingController _emailController;
  TextEditingController _nameController;

  String selected;

  String file = 'assets/blank-profile-picture.png';

  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController(text: 'example@mail.com');
    _nameController = new TextEditingController(text: 'Name');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        _getAccountImage(),
        SizedBox(
          height: 80.0,
        ),
        _getEmail(),
        SizedBox(
          height: 10.0,
        ),
        _getName(),
        SizedBox(
          height: 10.0,
        ),
        _getCountry(),
      ],
    );
  }

  Widget _getAccountImage() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _showInputSourceDialog();
            });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 190.0,
              height: 190.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(file),
                  ))),
        ],
      ),
    );
  }

  Widget _showInputSourceDialog() {
    return AlertDialog(
      content: Text('Choose image source'),
      actions: <Widget>[
        FlatButton(
          child: Text("Shoot picure"),
          onPressed: () async {
            Navigator.of(context).pop();
            await _pickImageFromCamera();
          },
        ),
        FlatButton(
          child: Text("Pick from gallery"),
          onPressed: () async {
            Navigator.of(context).pop();
            await _pickImageFromGallery();
          },
        )
      ],
    );
  }

  Future<Null> _pickImageFromCamera() async {
    final fileImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this.file = fileImage.path;
    });
  }

  Future<Null> _pickImageFromGallery() async {
    final fileImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = fileImage.path;
    });
  }

  Widget _getEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: _emailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: true,
          fillColor: Colors.grey[400],
          hintText: 'Email',
        ),
//      validator: validateEmail,
        onSaved: (value) => {},
      ),
    );
  }

  Widget _getName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: _nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: true,
          fillColor: Colors.grey[400],
          hintText: 'Name',
        ),
//      validator: validateEmail,
        onSaved: (value) => {},
      ),
    );
  }

  Widget _getCountry() {
    return FutureBuilder(
        future: _getCountriesDropDownMenueItems(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: snapshot.hasData
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: DropdownButton(
                      value: selected,
                      hint: Text("Select your country"),
                      items: snapshot.data,
                      onChanged: (value) {
                        selected = value;
                        setState(() {});
                      },
                    ))
                : Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          );
        });
  }

  Future<List<DropdownMenuItem<String>>>
      _getCountriesDropDownMenueItems() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/countries.json");
    var jsonData = json.decode(data);

    List<DropdownMenuItem<String>> _dropDownMenueCountryItem = [];
    for (var data in jsonData) {
      _dropDownMenueCountryItem.add(DropdownMenuItem(
        child: Text(data["name"].toString()),
        value: data["code"],
      ));
    }
    return _dropDownMenueCountryItem;
  }
}

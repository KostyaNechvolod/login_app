import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/page/home_screen.dart';


class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.of(context)
                  .pop(MyHomePage());
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
        showAccountImage(),
        SizedBox(
          height: 80.0,
        ),
        showEmail(),
        SizedBox(
          height: 10.0,
        ),
        showName(),
        SizedBox(
          height: 10.0,
        ),
        showCountry(),
      ],
    );
  }

  Widget showAccountImage() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Choose image source'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Shoot picure"),
                    onPressed: () async{
                      Navigator.of(context).pop();
                      await _pickImageFromCamera();
                    },
                  ),
                  FlatButton(
                    child: Text("Pick from gallery"),
                    onPressed: () async{
                      Navigator.of(context).pop();
                      await _pickImageFromGallery();
                    },
                  )
                ],
              );
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
                      image: AssetImage(file)
                  )
              )),
        ],
      ),
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

  Widget showEmail() {
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

  Widget showName() {
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

  Widget showCountry() {
    return FutureBuilder(
        future: listDrop(),
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

  Future<List<DropdownMenuItem<String>>> listDrop() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/countries.json");
    var jsonData = json.decode(data);

    List<DropdownMenuItem<String>> listDrops = [];
    for (var data in jsonData) {
      listDrops.add(DropdownMenuItem(
        child: Text(data["name"].toString()),
        value: data["code"],
      ));
    }
    return listDrops;
  }
}

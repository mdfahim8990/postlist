import 'dart:convert';
import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:postlist/model/employee_model.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  State<PostListPage> createState() => _PostListPageState();
}


class _PostListPageState extends State<PostListPage> {
  final url = "http://118.179.81.91:80/personnel/api/employees/";

  var _postJson = [];
List<EmployeeModel> employeeList = [];
bool  isLoading = false;
  List<EmployeeModel> employees = [];

 Future<void>  fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));

      final jsonData = jsonDecode(response.body) as List;
      if(jsonData.isNotEmpty){
        setState(() {
          _postJson = jsonData;
          isLoading = true;
        });
      }


    }catch(e){
      print("Error :$e");
    }
  }


  Future<void> fetchData() async {
    // Define the API endpoint URL
    String apiUrl = "http://118.179.81.91:80/personnel/api/employees/";

    // Define your Basic Authentication credentials
    String username = "admin";
    String password = "abc12345";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    // Set up the GET request headers with Basic Authentication
    Map<String, String> headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    };

    // Make the GET request
    http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    // Check the status code to see if the request was successful
    if (response.statusCode == 200) {
      // Parse the response data (assuming it's JSON)
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        EmployeeResponse employeeResponse =
        EmployeeResponse.fromJson(data);
        employees = employeeResponse.data;
     employees..forEach((element) {
          print(element.id);
        });
      });


    } else {
      // Handle the error
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    }
  }


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await checkTokenExpiration();
      await  fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Post List"),
          ),
          body:!isLoading ? const Center(
            child: CircularProgressIndicator(),
          ): ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                final post = employeeList[index];
                //return Text("Post Title: ${post["title"]}\nPost Content: ${post["body"]}\n\n");
                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title:Text("${employeeList}",style: TextStyle(fontWeight: FontWeight.w600),) ,
                     // subtitle: Text("${post["body"]}"),
                    ),
                  ),
                );
              }
          )
      );

  }
}

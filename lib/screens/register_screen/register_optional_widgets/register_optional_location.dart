import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/credentials.dart';
import 'package:http/http.dart' as http;

typedef void LocationScreenCallback(String gender);

class RegisterOptionalLocation extends StatefulWidget {
  final LocationScreenCallback locationScreenCallback;

  RegisterOptionalLocation({required this.locationScreenCallback});

  @override
  State createState() => _RegisterOptionalLocationState();
}

class _RegisterOptionalLocationState extends State<RegisterOptionalLocation> {
  late Function _callback;
  final TextEditingController _searchController = TextEditingController();
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  final String type = '(regions)';
  final int searchRadius = 3000;
  final String session = '&sessiontoken=1234567890';
  late String _searchString;

  // Example
  // https://maps.googleapis.com/maps/api/place/autocomplete/xml
  // ?input=Amoeba
  // &types=establishment
  // &location=37.76999,-122.44696
  // &radius=500&strictbounds
  // &key=YOUR_API_KEY

  @override
  void initState() {
    super.initState();
    _callback = widget.locationScreenCallback;
    _searchController.addListener(_searchInputHandler);
  }

  void _searchInputHandler() async {
    if (_searchController.text.length < 3) return;

    var input = _searchController.text;

    var url =
        '$baseUrl?input=$input&type=$type&radius=$searchRadius&language=sv&key=$PLACES_API_KEY';

    var response = await http.get(Uri.dataFromString(url));

    if (response.statusCode == 200) {
      print('GOT RESPONSE');
      print(response.statusCode);
      print(response.body);
      // var jsonResponse = jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
    } else {
      print('Request failed with status: ${response.statusCode} and response was: $response');
    }
  }

  @override
  Widget build(BuildContext context) {
    double _safeAreaPadding = MediaQuery.of(context).padding.top;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height - 2 * _safeAreaPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: Text(
                  'Location',
                  style: largeTitleStyle(color: DARK_GRAY),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32.0),
              child: TextFormField(
                autocorrect: false,
                autovalidateMode: AutovalidateMode.disabled,
                controller: _searchController,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: PRIMARY_BLUE,
                  ),
                  hintText: 'Search location',
                  hintStyle: hintStyle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
}

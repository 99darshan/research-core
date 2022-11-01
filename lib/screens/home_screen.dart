import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:researchcore/screens/search_result_screen.dart';
import 'package:researchcore/utils/theme_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final double _lowYear = 1980;
  final double _highYear = DateTime.now().year.toDouble();
  String _searchText = '';

  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late RangeValues _currentRangeValues =
      RangeValues((_highYear - 10), _highYear);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _homeBrandHeader(context),
                  _searchFormCard(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _handleSearch() async {
    if (_searchText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(searchTermSnackBar);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchResultScreen(
            searchText: _searchText,
            minYear: _currentRangeValues.start.round(),
            maxYear: _currentRangeValues.end.round()),
      ),
    );
  }

  final searchTermSnackBar = const SnackBar(
    content: Text('Please Input a Search Text'),
    duration: Duration(seconds: 2),
  );

  Widget _rangeSlider(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      max: _highYear,
      min: _lowYear,
      divisions: (_highYear - _lowYear) ~/ 2,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }

  Widget _searchTextField() {
    return TextFormField(
      focusNode: _focusNode,
      onFieldSubmitted: (text) {
        // hides the keyboard on ok button press on keyboard,
        // Allows the user to click on Search Button
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _focusNode.unfocus();
      },
      onChanged: (text) {
        setState(() {
          _searchText = text;
        });
      },
      onEditingComplete: () {
        _textController.text = _searchText;
        _focusNode.unfocus();
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Search Term',
      ),
      controller: _textController,
    );
  }

  Widget _homeBrandHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Image.asset(
              'assets/images/research-core-logo.png',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Research Core",
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            "Search for Open Access Research Papers",
            softWrap: true,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }

  Widget _searchFormCard(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: ThemeUtil.primaryColor,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Search Term',
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            _searchTextField(),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Choose Year Range',
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                    '( Selected: ${_currentRangeValues.start.toInt().toString()} - ${_currentRangeValues.end.toInt().toString()} )',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  //this._lowYear.toInt().toString(),
                  _lowYear.toInt().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Expanded(flex: 2, child: _rangeSlider(context)),
                Text(
                  //this._highYear.toInt().toString(),
                  DateTime.now().year.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            _searchButton(context)
          ],
        ),
      ),
    );
  }

  Widget _searchButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 64.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(64.0),
          ),
        ),
        onPressed: _handleSearch,
        child: Text(
          'Search',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: Colors.white, fontSize: 24.0),
        ),
      ),
    );
  }
}

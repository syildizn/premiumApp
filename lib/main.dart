import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: SubscriptionScreen(),
    );
  }
}

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  List subscriptionOptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubscriptionData();
  }

  Future<void> fetchSubscriptionData() async {
    try {
      final url = Uri.parse('http://api.falastra.com/api/Test'); // http olarak değiştirildi
      print('Fetching data from $url');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Data fetched successfully');
        setState(() {
          subscriptionOptions = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load subscription options. Status code: ${response.statusCode}');
        throw Exception('Failed to load subscription options');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching subscription data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        title: Text(
          'Premium',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Philosopher',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: Image.asset("assets/icons/elmas.png"),
              ),
              const SizedBox(height: 30),
              Text(
                'Premium',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFE9600D),
                  fontSize: 30,
                  fontFamily: 'Philosopher',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Ayrıcalıkları ile beklemenize gerek yok.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Opacity(
                opacity: 0.60,
                child: Text(
                  'Premium ile öncelikli olduğunu hisset.\nDaha fazla bekleme',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  featureItem(Icons.check, 'Hergün 10 altın'),
                  featureItem(Icons.check, 'Reklamsız kullanım'),
                  featureItem(Icons.check, 'Tüm Özellikler'),
                ],
              ),
              const SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: subscriptionOptions.map<Widget>((option) {
                  String period = option['name'] ?? 'eksik';
                  String oldPrice = option['price'] != null ? '${option['price']} ${option['currency'] ?? ''}' : 'eksik';
                  String newPrice = option['discountedPrice'] != null ? '${option['discountedPrice']} ${option['currency'] ?? ''}' : 'eksik';
                  return subscriptionOption(period, oldPrice, newPrice);
                }).toList(),
              ),
              const SizedBox(height: 30),
              Container(
                width: 335,
                height: 51,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.61, -0.79),
                    end: Alignment(0.61, 0.79),
                    colors: [Color(0xFF5B34FF), Color(0xFFFF5303)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      '3 Gün Ücretsiz Deneme',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'İstediğin zaman iptal edebilirsin',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget subscriptionOption(String period, String oldPrice, String newPrice) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ).copyWith(
        side: MaterialStateProperty.all(BorderSide(color: Color(0x26A5AFC4))),
        elevation: MaterialStateProperty.all(0),
      ),
      child: Container(
        width: 102,
        height: 97,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.68, -0.74),
            end: Alignment(0.68, 0.74),
            colors: [Colors.black, Colors.black12],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0x26A5AFC4)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              period,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Philosopher',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              oldPrice,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
                fontFamily: 'Philosopher',
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.red,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              newPrice,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Philosopher',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget featureItem(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Color(0xFFE9600D),
          size: 40,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Philosopher',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const AmharicApp());

class AmharicApp extends StatelessWidget {
  const AmharicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.trackpad},
      ),
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const FidelPage(),
    );
  }
}

class FidelPage extends StatefulWidget {
  const FidelPage({super.key});

  @override
  State<FidelPage> createState() => _FidelPageState();
}

class _FidelPageState extends State<FidelPage> {
  final FocusNode _focusNode = FocusNode();
  bool _isTitleHovered = false;
  bool _showFinalBlessing = false; 
  
  final List<List<String>> fidelLines = [
    ['ሀ', 'ሁ', 'ሂ', 'ሃ', 'ሄ', 'ህ', 'ሆ'], ['ለ', 'ሉ', 'ሊ', 'ላ', 'ሌ', 'ል', 'ሎ'], 
    ['ሐ', 'ሑ', 'ሒ', 'ሓ', 'ሔ', 'ሕ', 'ሖ'], ['መ', 'ሙ', 'ሚ', 'ማ', 'ሜ', 'ም', 'ሞ'], 
    ['ሠ', 'ሡ', 'ሢ', 'ሣ', 'ሤ', 'ሥ', 'ሦ'], ['ረ', 'ሩ', 'ሪ', 'ራ', 'ሬ', 'ር', 'ሮ'], 
    ['ሰ', 'ሱ', 'ሲ', 'ሳ', 'ሴ', 'ስ', 'ሶ'], ['ሸ', 'ሹ', 'ሺ', 'ሻ', 'ሼ', 'ሽ', 'ሾ'], 
    ['ቀ', 'ቁ', 'ቂ', 'ቃ', 'ቄ', 'ቅ', 'ቆ'], ['በ', 'ቡ', 'ቢ', 'ባ', 'ቤ', 'ብ', 'ቦ'],
    ['ተ', 'ቱ', 'ቲ', 'ታ', 'ቴ', 'ት', 'ቶ'], ['ቸ', 'ቹ', 'ቺ', 'ቻ', 'ቼ', 'ች', 'ቾ'],
    ['ኀ', 'ኁ', 'ኂ', 'ኃ', 'ኄ', 'ኅ', 'ኆ'], ['ነ', 'ኑ', 'ኒ', 'ና', 'ኔ', 'ን', 'ኖ'],
    ['ኘ', 'ኙ', 'ኚ', 'ኛ', 'ኜ', 'ኝ', 'ኞ'], ['አ', 'ኡ', 'ኢ', 'ኣ', 'ኤ', 'እ', 'ኦ'],
    ['ከ', 'ኩ', 'ኪ', 'ካ', 'ኬ', 'ክ', 'ኮ'], ['ኸ', 'ኹ', 'ኺ', 'ኻ', 'ኼ', 'ኽ', 'ኾ'],
    ['ወ', 'ዉ', 'ዊ', 'ዋ', 'ዌ', 'ው', 'ዎ'], ['ዐ', 'ዑ', 'ዒ', 'ዓ', 'ዔ', 'ዕ', 'ዖ'],
    ['ዘ', 'ዙ', 'ዚ', 'ዛ', 'ዜ', 'ዝ', 'ዞ'], ['ዠ', 'ዙ', 'ዢ', 'ዣ', 'ዤ', 'ዥ', 'ዦ'],
    ['የ', 'ዩ', 'ዪ', 'ያ', 'ዬ', 'ይ', 'ዮ'], ['ደ', 'ዱ', 'ዲ', 'ዳ', 'ዴ', 'ድ', 'ዶ'],
    ['ጀ', 'ጁ', 'ጂ', 'ጃ', 'ጄ', 'ጅ', 'ጆ'], ['ገ', 'ጉ', 'ጊ', 'ጋ', 'ጌ', 'ግ', 'ጎ'],
    ['ጠ', 'ጡ', 'ጢ', 'ጣ', 'ጤ', 'ጥ', 'ጦ'], ['ጨ', 'ጩ', 'ጪ', 'ጫ', 'ጬ', 'ጭ', 'ጮ'],
    ['ጰ', 'ጱ', 'ጲ', 'ጳ', 'ጴ', 'ጵ', 'ጶ'], ['ጸ', 'ጹ', 'ጺ', 'ጻ', 'ጼ', 'ጽ', 'ጾ'],
    ['ፀ', 'ፁ', 'ፂ', 'ፃ', 'ፄ', 'ፅ', 'ፆ'], ['ፈ', 'ፉ', 'ፊ', 'ፋ', 'ፌ', 'ፍ', 'ፎ'],
    ['ፐ', 'ፑ', 'ፒ', 'ፓ', 'ፔ', 'ፕ', 'ፖ'], 
  ];

  int _currentIndex = 0; 
  int get currentPageNumber => _currentIndex ~/ 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  void _next() {
    setState(() {
      if (_currentIndex >= fidelLines.length - 1) {
        _showFinalBlessing = true;
      } else {
        _currentIndex++;
        _showFinalBlessing = false;
      }
    });
  }

  void _prev() {
    setState(() {
      if (_showFinalBlessing) {
        _showFinalBlessing = false;
        _currentIndex = 32;
      } else {
        _currentIndex = (_currentIndex - 1).clamp(0, fidelLines.length - 1);
      }
    });
  }

  void _jumpToPage(int page) => setState(() {
    _showFinalBlessing = (page == 11);
    _currentIndex = (page < 11) ? page * 3 : 32;
  });

  void _goHome() => setState(() {
    _showFinalBlessing = false;
    _currentIndex = 0;
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    // Responsive values
    double cardSize = isMobile ? (screenWidth / 9).clamp(20.0, 50.0) : (screenWidth / 9).clamp(40.0, 110.0);
    double titleSize = isMobile ? 24 : 42;
    double flowerSize = isMobile ? 30 : 56;
    int flowerCount = isMobile ? 2 : 5;
    int startLine = currentPageNumber * 3;

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) _next();
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) _prev();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isMobile ? 70 : 110),
          child: _buildDecorativeBar(
            screenWidth,
            flowerCount,
            flowerSize,
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isTitleHovered = true),
              onExit: (_) => setState(() => _isTitleHovered = false),
              child: GestureDetector(
                onTap: _goHome,
                child: Text(isMobile ? '🇪🇹 አማርኛ 🇩🇰' : '🇪🇹        አማርኛ ለልጆች        🇩🇰', 
                  style: TextStyle(
                    fontSize: titleSize, 
                    fontWeight: FontWeight.w900, 
                    color: _isTitleHovered ? Colors.orange : Colors.green.shade800
                  )),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(child: Container(color: Colors.green.withOpacity(0.08))),
                      Expanded(child: Container(color: Colors.yellow.withOpacity(0.18))),
                      Expanded(child: Container(color: Colors.red.withOpacity(0.08))),
                    ],
                  ),
                  _showFinalBlessing 
                    ? Center(child: _buildSingleLineBlessing(screenWidth))
                    : Column(
                        children: [
                          Expanded(child: Container(alignment: Alignment.center, child: _buildFidelRow(startLine, cardSize))),
                          Expanded(child: Container(alignment: Alignment.center, child: _buildFidelRow(startLine + 1, cardSize))),
                          Expanded(child: Container(alignment: Alignment.center, child: _buildFidelRow(startLine + 2, cardSize))),
                        ],
                      ),
                ],
              ),
            ),
            _buildAlignedFooter(screenWidth, flowerCount, flowerSize, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleLineBlessing(double width) {
    double fontSize = (width / 15).clamp(20.0, 65.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900, letterSpacing: 1.2),
            children: [
              TextSpan(text: 'እግዚአብሔር ', style: TextStyle(color: Colors.green.shade700)),
              TextSpan(text: 'ይስጥልኝ ', style: const TextStyle(color: Color(0xFFFFD700))), 
              TextSpan(text: 'አናመሰግናለን 😊', style: TextStyle(color: Colors.red.shade900)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFidelRow(int lineIndex, double cardSize) {
    if (lineIndex >= fidelLines.length) return const SizedBox.shrink();
    bool isPast = lineIndex < _currentIndex;
    bool isFuture = lineIndex > _currentIndex;

    return Visibility(
      visible: !isFuture,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Opacity(
        opacity: isPast ? 0.15 : 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: fidelLines[lineIndex].map((char) => Text(char, 
            style: TextStyle(fontSize: cardSize * 0.9, fontWeight: FontWeight.w900, color: Colors.black87))).toList(),
        ),
      ),
    );
  }

  Widget _buildDecorativeBar(double width, int count, double size, Widget centerWidget) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(count, (_) => CustomFlower(size: size)), 
          centerWidget,
          ...List.generate(count, (_) => CustomFlower(size: size)), 
        ],
      ),
    );
  }

  Widget _buildAlignedFooter(double width, int count, double size, bool isMobile) {
    return Container(
      padding: EdgeInsets.only(bottom: isMobile ? 15 : 25, top: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(count, (_) => CustomFlower(size: size)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: _prev, icon: Icon(Icons.arrow_back_ios, color: Colors.green, size: isMobile ? 20 : 28)),
              _buildTabSelector(width, isMobile),
              IconButton(onPressed: _next, icon: Icon(Icons.arrow_forward_ios, color: Colors.green, size: isMobile ? 20 : 28)),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _goHome,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: Icon(Icons.refresh, color: Colors.white, size: isMobile ? 18 : 24),
                ),
              ),
            ],
          ),
          ...List.generate(count, (_) => CustomFlower(size: size)),
        ],
      ),
    );
  }

  Widget _buildTabSelector(double width, bool isMobile) {
    int totalPages = 12; 
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isMobile ? width * 0.35 : width * 0.40),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(totalPages, (index) {
            bool selected = (index == 11 && _showFinalBlessing) || (currentPageNumber == index && !_showFinalBlessing);
            String label = (index < 11) ? fidelLines[index * 3][0] : "😊";
            return GestureDetector(
              onTap: () => _jumpToPage(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green, width: 1.5),
                ),
                child: Text(label, 
                  style: TextStyle(color: selected ? Colors.white : Colors.green, fontSize: isMobile ? 14 : 18, fontWeight: FontWeight.bold)),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class CustomFlower extends StatelessWidget {
  final double size;
  const CustomFlower({super.key, this.size = 56});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: MeskelFlowerPainter());
  }
}

class MeskelFlowerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final petalPaint = Paint()..color = Colors.yellow.withOpacity(0.35)..style = PaintingStyle.fill;
    final centerPaint = Paint()..color = Colors.orange.withOpacity(0.35)..style = PaintingStyle.fill;
    double cx = size.width / 2;
    double cy = size.height / 2;

    // Scale the petals relative to the size
    double petalWidth = size.width * 0.125; 
    double petalHeight = size.height * 0.4;

    for (int i = 0; i < 8; i++) {
      canvas.save(); 
      canvas.translate(cx, cy); 
      canvas.rotate(i * 0.785);
      canvas.drawOval(Rect.fromLTWH(-petalWidth, -petalHeight, petalWidth * 2, petalHeight * 1.2), petalPaint);
      canvas.restore();
    }
    canvas.drawCircle(Offset(cx, cy), size.width * 0.125, centerPaint);
  }
  @override bool shouldRepaint(CustomPainter oldDelegate) => false;
}
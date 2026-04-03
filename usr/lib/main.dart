import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCM Presentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0), // Corporate Blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class SlideData {
  final String title;
  final List<String> bullets;
  final IconData icon;

  SlideData({
    required this.title,
    required this.bullets,
    required this.icon,
  });
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: 'Traditional Supply Chain\nPerformance Management',
      bullets: [
        'An overview of classical metrics and methodologies',
        'Understanding the linear supply chain model',
        'Key Performance Indicators (KPIs)',
        'Limitations and the path forward'
      ],
      icon: Icons.local_shipping,
    ),
    SlideData(
      title: 'What is Traditional SCM?',
      bullets: [
        'Linear flow of goods and information (Supplier → Manufacturer → Distributor → Retailer → Customer)',
        'Siloed operations: Plan, Source, Make, Deliver',
        'Primary focus on cost reduction and operational efficiency',
        'Batch processing and periodic performance reviews rather than real-time tracking'
      ],
      icon: Icons.account_tree,
    ),
    SlideData(
      title: 'Core Performance Categories',
      bullets: [
        'Cost Management: Keeping expenses low across the chain',
        'Customer Service / Delivery: Meeting customer expectations',
        'Quality Assurance: Ensuring product standards are met',
        'Asset Management: Efficient use of inventory and facilities'
      ],
      icon: Icons.category,
    ),
    SlideData(
      title: 'Key Cost Metrics',
      bullets: [
        'Total Supply Chain Management Cost: Overall cost to manage the network',
        'Inventory Carrying Cost: Cost of storing unsold goods (warehousing, insurance, depreciation)',
        'Transportation & Logistics Costs: Freight, fuel, and routing expenses',
        'Cost of Goods Sold (COGS): Direct costs attributable to the production of the goods'
      ],
      icon: Icons.attach_money,
    ),
    SlideData(
      title: 'Delivery & Service Metrics',
      bullets: [
        'On-Time Delivery (OTD): Percentage of orders delivered by the promised date',
        'Order Fill Rate: Percentage of customer demand met from immediate stock',
        'Order Cycle Time: Time taken from order placement to delivery',
        'Perfect Order Percentage: Orders delivered on time, in full, damage-free, and with correct documentation'
      ],
      icon: Icons.timer,
    ),
    SlideData(
      title: 'Quality & Asset Metrics',
      bullets: [
        'Defect Rate: Number of defective products per thousand/million',
        'Supplier Quality Rating: Assessing vendors based on their defect rates and compliance',
        'Inventory Turnover: How many times inventory is sold and replaced over a period',
        'Capacity Utilization: Percentage of manufacturing or storage capacity being used'
      ],
      icon: Icons.fact_check,
    ),
    SlideData(
      title: 'Limitations of Traditional Metrics',
      bullets: [
        'Backward-looking: Relies heavily on historical data rather than predictive insights',
        'Lack of real-time visibility: Delays in identifying and responding to disruptions',
        'Siloed objectives: Manufacturing might optimize for cost while logistics optimizes for speed, causing conflicts',
        'Inability to handle modern volatility: Struggles with rapid market shifts and global disruptions'
      ],
      icon: Icons.warning_amber_rounded,
    ),
    SlideData(
      title: 'Conclusion',
      bullets: [
        'Traditional metrics laid the essential foundation for modern SCM',
        'They provide strong baselines for cost and basic service levels',
        'However, modern supply chains require a shift toward real-time, predictive analytics',
        'The future is transitioning from linear chains to interconnected digital supply networks'
      ],
      icon: Icons.lightbulb_outline,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
                event.logicalKey == LogicalKeyboardKey.space) {
              _nextPage();
              return KeyEventResult.handled;
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _previousPage();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: Column(
          children: [
            // Main Presentation Area
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return SlideWidget(slide: _slides[index]);
                },
              ),
            ),
            
            // Bottom Controls
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _currentPage > 0 ? _previousPage : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  Text(
                    'Slide ${_currentPage + 1} of ${_slides.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;

  const SlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    // Responsive padding based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth > 800 ? screenWidth * 0.15 : 24.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blue.shade50.withOpacity(0.3),
              ],
            ),
          ),
          padding: const EdgeInsets.all(48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      slide.icon,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Text(
                      slide.title,
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 42 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Divider(thickness: 2),
              ),
              // Body (Bullets)
              Expanded(
                child: ListView.builder(
                  itemCount: slide.bullets.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Icon(
                              Icons.play_arrow,
                              color: Theme.of(context).colorScheme.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              slide.bullets[index],
                              style: TextStyle(
                                fontSize: screenWidth > 600 ? 24 : 18,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

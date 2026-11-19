
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const KhanTechnicalTaleem());
}

class KhanTechnicalTaleem extends StatefulWidget {
  const KhanTechnicalTaleem({super.key});

  @override
  State<KhanTechnicalTaleem> createState() =>
      _KhanTechnicalTaleemState();
}

class _KhanTechnicalTaleemState
    extends State<KhanTechnicalTaleem> {
  bool isPashto = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khan Technical Taleem',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087F5B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7F6),
      ),
      home: HomePage(
        isPashto: isPashto,
        onLanguageChange: (value) {
          setState(() => isPashto = value);
        },
      ),
    );
  }
}

class Package {
  final String network;
  final String type;
  final String name;
  final String description;
  final String price;
  final String validity;
  final String activationCode;
  final bool verified;

  const Package({
    required this.network,
    required this.type,
    required this.name,
    required this.description,
    required this.price,
    required this.validity,
    required this.activationCode,
    this.verified = false,
  });
}

class HomePage extends StatefulWidget {
  final bool isPashto;
  final ValueChanged<bool> onLanguageChange;

  const HomePage({
    super.key,
    required this.isPashto,
    required this.onLanguageChange,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController =
      TextEditingController();

  String selectedNetwork = 'All';
  String selectedType = 'All';

  final List<String> networks = [
    'All',
    'Roshan',
    'AWCC',
    'Etisalat',
    'ATOMA',
    'Salaam',
  ];

  final List<String> types = [
    'All',
    'Internet',
    'Call',
    'SMS',
    'Social',
    'Night',
  ];

  final List<Package> packages = [
    const Package(
      network: 'Roshan',
      type: 'Internet',
      name: 'Internet Packages',
      description: 'Official package information pending verification.',
      price: 'Not verified',
      validity: 'Not verified',
      activationCode: '',
    ),
    const Package(
      network: 'AWCC',
      type: 'Internet',
      name: 'Internet Packages',
      description: 'Official package information pending verification.',
      price: 'Not verified',
      validity: 'Not verified',
      activationCode: '',
    ),
    const Package(
      network: 'Etisalat',
      type: 'Internet',
      name: 'Internet Packages',
      description: 'Official package information pending verification.',
      price: 'Not verified',
      validity: 'Not verified',
      activationCode: '',
    ),
    const Package(
      network: 'ATOMA',
      type: 'Internet',
      name: 'Internet Packages',
      description: 'Official package information pending verification.',
      price: 'Not verified',
      validity: 'Not verified',
      activationCode: '',
    ),
    const Package(
      network: 'Salaam',
      type: 'Internet',
      name: 'Internet Packages',
      description: 'Official package information pending verification.',
      price: 'Not verified',
      validity: 'Not verified',
      activationCode: '',
    ),
  ];

  String translate(String english, String pashto) {
    return widget.isPashto ? pashto : english;
  }

  List<Package> get filteredPackages {
    return packages.where((package) {
      final matchesNetwork = selectedNetwork == 'All' ||
          package.network == selectedNetwork;

      final matchesType =
          selectedType == 'All' || package.type == selectedType;

      final query = searchController.text.toLowerCase();

      final matchesSearch =
          package.network.toLowerCase().contains(query) ||
          package.name.toLowerCase().contains(query) ||
          package.type.toLowerCase().contains(query);

      return matchesNetwork && matchesType && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          widget.isPashto ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF087F5B),
          foregroundColor: Colors.white,
          title: const Text(
            'Khan Technical Taleem',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            PopupMenuButton<bool>(
              icon: const Icon(Icons.language),
              onSelected: widget.onLanguageChange,
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: false,
                  child: Text('English'),
                ),
                PopupMenuItem(
                  value: true,
                  child: Text('پښتو'),
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(),
              const SizedBox(height: 18),
              _buildSearch(),
              const SizedBox(height: 20),
              _buildSectionTitle(
                translate('Mobile Networks', 'مخابراتي شبکې'),
              ),
              const SizedBox(height: 12),
              _buildNetworks(),
              const SizedBox(height: 22),
              _buildSectionTitle(
                translate('Package Categories', 'د پکېج ډولونه'),
              ),
              const SizedBox(height: 12),
              _buildCategories(),
              const SizedBox(height: 22),
              _buildSectionTitle(
                translate('Available Packages', 'شته پکېجونه'),
              ),
              const SizedBox(height: 12),
              ...filteredPackages.map(_buildPackageCard),
              if (filteredPackages.isEmpty)
                _buildEmptyMessage(),
              const SizedBox(height: 20),
              _buildVerificationNotice(),
              const SizedBox(height: 20),
              _buildAbout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF087F5B),
            Color(0xFF07533F),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.phone_android,
            color: Colors.white,
            size: 38,
          ),
          const SizedBox(height: 12),
          Text(
            translate(
              'Afghanistan Telecom Packages',
              'د افغانستان مخابراتي پکېجونه',
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            translate(
              'Find internet, calls, SMS and special offers.',
              'انټرنېټ، زنګونه، SMS او ځانګړي آفرونه ومومئ.',
            ),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      controller: searchController,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: translate(
          'Search packages or networks...',
          'پکېجونه یا شبکې ولټوئ...',
        ),
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildNetworks() {
    final colors = [
      const Color(0xFF087F5B),
      const Color(0xFF2457A6),
      const Color(0xFF7A3DB8),
      const Color(0xFFDB8A12),
      const Color(0xFF1686A5),
    ];

    return Wrap(
      spacing: 9,
      runSpacing: 9,
      children: List.generate(5, (index) {
        final network = networks[index + 1];

        return InkWell(
          onTap: () {
            setState(() {
              selectedNetwork = network;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: selectedNetwork == network
                  ? colors[index]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors[index]),
            ),
            child: Text(
              network,
              style: TextStyle(
                color: selectedNetwork == network
                    ? Colors.white
                    : colors[index],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategories() {
    final labels = {
      'All': translate('All', 'ټول'),
      'Internet': translate('Internet', 'انټرنېټ'),
      'Call': translate('Calls', 'زنګونه'),
      'SMS': 'SMS',
      'Social': translate('Social', 'ټولنیزې رسنۍ'),
      'Night': translate('Night', 'شپه'),
    };

    final icons = {
      'All': Icons.apps,
      'Internet': Icons.wifi,
      'Call': Icons.call,
      'SMS': Icons.sms,
      'Social': Icons.share,
      'Night': Icons.nightlight_round,
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: types.map((type) {
        final selected = selectedType == type;

        return ChoiceChip(
          avatar: Icon(
            icons[type],
            size: 17,
            color: selected ? Colors.white : Colors.green,
          ),
          label: Text(labels[type]!),
          selected: selected,
          selectedColor: const Color(0xFF087F5B),
          labelStyle: TextStyle(
            color: selected ? Colors.white : Colors.black87,
          ),
          onSelected: (_) {
            setState(() {
              selectedType = type;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildPackageCard(Package package) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE0F2E9),
                  child: const Icon(
                    Icons.sim_card,
                    color: Color(0xFF087F5B),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.network,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        package.name,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.info_outline,
                  color: Colors.orange,
                ),
              ],
            ),
            const Divider(height: 24),
            Text(package.description),
            const SizedBox(height: 12),
            _detailRow(
              Icons.payments_outlined,
              translate('Price', 'بیه'),
              package.price,
            ),
            _detailRow(
              Icons.calendar_month,
              translate('Validity', 'موده'),
              package.validity,
            ),
            _detailRow(
              Icons.verified_outlined,
              translate('Status', 'حالت'),
              translate('Verification required', 'تصدیق ته اړتیا لري'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: package.activationCode.isEmpty
                    ? null
                    : () => _copyCode(package.activationCode),
                icon: const Icon(Icons.copy),
                label: Text(
                  translate(
                    'Copy Activation Code',
                    'د فعالولو کوډ کاپي کړئ',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.green),
          const SizedBox(width: 8),
          Text(title),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          translate('Code copied!', 'کوډ کاپي شو!'),
        ),
      ),
    );
  }

  Widget _buildEmptyMessage() {
    return const Padding(
      padding: EdgeInsets.all(25),
      child: Center(
        child: Text('No packages found.'),
      ),
    );
  }

  Widget _buildVerificationNotice() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              translate(
                'Package prices and activation codes must be verified '
                'from official network sources before use.',
                'د پکېجونو بیې او کوډونه باید د شبکو له رسمي سرچینو '
                'څخه تصدیق شي.',
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbout() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F1EC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.school,
            color: Color(0xFF087F5B),
            size: 32,
          ),
          const SizedBox(height: 8),
          const Text(
            'Khan Technical Taleem',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            translate(
              'Founder: Keftan Khan',
              'بنسټګر: Keftan Khan',
            ),
          ),
          const Text('Afghanistan'),
          const SizedBox(height: 5),
          const Text('Contact: 0747081568'),
          const SizedBox(height: 5),
          const Text(
            '@khantechnicaltaleemkeftankhan',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF087F5B)),
          ),
          const SizedBox(height: 8),
          const Text(
            'Version 1.0.0',
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

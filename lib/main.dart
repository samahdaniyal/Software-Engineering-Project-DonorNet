import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();         // Ensures Flutter is ready
  await Firebase.initializeApp();                    // Initializes Firebase
  runApp(const DonorNetApp());                       // Launches your app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Show loading while Firebase is initializing
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        // Show error message if Firebase fails to initialize
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Firebase Error: ${snapshot.error}')),
            ),
          );
        }

        // Once Firebase is initialized, show your app
        return MaterialApp(
          title: 'Donor Net',
          home: LoginScreen(), // Your actual home screen
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Example"),
      ),
      body: Center(
        child: Text("Firebase Initialized Successfully!"),
      ),
    );
  }
}

class DonorNetApp extends StatelessWidget {
  const DonorNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donor Net',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/signupRole': (context) => const SignupRoleScreen(),
        '/patientsignup-1': (context) => const PatientSignup1Screen(),
        '/patientsignup-2': (context) => const PatientSignup2Screen(),
        '/reqsent': (context) => RequestSentScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/donorsignup-1': (context) => const DonorSignup1Screen(),
        '/adminHome': (context) => const AdminHomeScreen(),
        '/searchscreen': (context) => const SearchScreen(),
        '/patienthome': (context) => const PatientHomeScreen(),
      },
      // 👇 Use onGenerateRoute for /viewdetails since it needs arguments
      onGenerateRoute: (settings) {
        if (settings.name == '/viewdetails') {
          final userData = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ViewDetailsScreen(userData: userData),
          );
        }
        return null; // fallback if route doesn't match
      },
    );
  }
}

/// 1. WELCOME SCREEN
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/donor_net_logo.png',
                width: size.width * 0.3,
                height: size.width * 0.3,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                'DONOR NET',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),
              // LOGIN button
              SizedBox(
                width: size.width * 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // SIGN UP button
              SizedBox(
                width: size.width * 0.6,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signupRole');
                  },
                  child: const Text(
                    'SIGNUP',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 2. LOGIN SCREEN
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DONOR NET'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // Email
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter Email/Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              // Keep me logged in
              Row(
                children: [
                  Checkbox(
                    value: _keepMeLoggedIn,
                    onChanged: (value) {
                      setState(() {
                        _keepMeLoggedIn = value ?? false;
                      });
                    },
                  ),
                  const Text('Keep me logged in'),
                ],
              ),
              // LOGIN button
              SizedBox(
                width: size.width * 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/patienthome');
                    Navigator.pushNamed(context, '/adminHome');
                   
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Forgot Password?
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/forgotPassword');
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Sign Up?
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signupRole');
                },
                child: const Text(
                  'Don\'t have an account? SIGN UP NOW!',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 3. FORGOT PASSWORD SCREEN
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DONOR NET'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Forgot Your Password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Enter email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter Email address to reset password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Request Reset Link button
            SizedBox(
              width: size.width * 0.6,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // TODO: Implement reset password logic
                },
                child: const Text(
                  'Request Reset Link',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Back to Login
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // or pushNamed('/login')
              },
              child: const Text(
                'Back To Login',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 4. SIGN UP ROLE SCREEN
class SignupRoleScreen extends StatelessWidget {
  const SignupRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DONOR NET'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30), // Padding remains the same
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Keep content centered vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30), // Space between "SIGN UP" and buttons
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 80), // Adjust this space to move buttons up or down
                // PATIENT button
                SizedBox(
                  width: size.width * 0.8,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red, 
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/patientsignup-1');
                    },
                    child: const Text(
                      'PATIENT',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // DONOR button
                SizedBox(
                  width: size.width * 0.8,
                  height: 70,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/donorsignup-1');
                    },
                    child: const Text(
                      'DONOR',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// 5. Patient Sign up - 1
class PatientSignup1Screen extends StatefulWidget {
  const PatientSignup1Screen({super.key});

  @override
  State<PatientSignup1Screen> createState() => _PatientSignup1ScreenState();
}

class _PatientSignup1ScreenState extends State<PatientSignup1Screen> {
  String? selectedGender;
  String? selectedMaritalStatus;

  final List<String> genderOptions = [
    'Female',
    'Male',
    'Prefer not to say',
    'Other',
  ];

  final List<String> maritalStatusOptions = [
    'Married',
    'Unmarried',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'DonorNet',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                'PATIENT SIGNUP',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
              ),

              const SizedBox(height: 50),

              _buildTextField('Enter Username'),
              const SizedBox(height: 20),

              _buildTextField('Enter Email Address'),
              const SizedBox(height: 20),

              _buildTextField('Enter CNIC'),
              const SizedBox(height: 20),

              // Gender Dropdown
              _buildDropdown(
                hint: 'Select Gender',
                value: selectedGender,
                items: genderOptions,
                onChanged: (val) => setState(() => selectedGender = val),
              ),
              const SizedBox(height: 20),

              // Marital Status Dropdown
              _buildDropdown(
                hint: 'Select Marital Status',
                value: selectedMaritalStatus,
                items: maritalStatusOptions,
                onChanged: (val) => setState(() => selectedMaritalStatus = val),
              ),
              const SizedBox(height: 20),

              _buildTextField('Enter Password', obscure: true),
              const SizedBox(height: 20),

              _buildTextField('Re-enter Password', obscure: true),
              const SizedBox(height: 40),

              // Continue Button
              SizedBox(
                width: size.width * 0.6,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/patientsignup-2');
                  },
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(String hint, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      ),
    );
  }
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        hint: Text(hint),
        icon: const Icon(Icons.arrow_drop_down),
        items: items.map((item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        )).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

// 6. Patient Sign up - 2
class PatientSignup2Screen extends StatefulWidget {
  const PatientSignup2Screen({super.key});

  @override
  State<PatientSignup2Screen> createState() => _PatientSignup2ScreenState();
}

class _PatientSignup2ScreenState extends State<PatientSignup2Screen> {
  String? selectedCity;
  String? selectedBloodGroup;

  final List<String> cityOptions = ['Karachi', 'Lahore', 'Islamabad', 'Quetta', 'Peshawar'];
  final List<String> bloodGroupOptions = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'DonorNet',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                'Enter Personal Details:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 30),

              _buildTextField('Enter Address'),
              const SizedBox(height: 20),

              _buildTextField('Enter Phone number'),
              const SizedBox(height: 20),

              _buildDropdown(
                hint: 'Select City',
                value: selectedCity,
                items: cityOptions,
                onChanged: (val) => setState(() => selectedCity = val),
              ),
              const SizedBox(height: 20),

              _buildDropdown(
                hint: 'Select Blood Group',
                value: selectedBloodGroup,
                items: bloodGroupOptions,
                onChanged: (val) => setState(() => selectedBloodGroup = val),
              ),
              const SizedBox(height: 30),

              _buildUploadSection('Enter proof of blood group:'),
              const SizedBox(height: 20),

              _buildUploadSection('Enter latest CBC:'),
              const SizedBox(height: 40),

              // SIGNUP button
              SizedBox(
                width: size.width * 0.6,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red[600],
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/reqsent');
                  },
                  child: const Text(
                    'SIGNUP!',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        hint: Text(hint),
        icon: const Icon(Icons.arrow_drop_down),
        items: items.map((item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        )).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildUploadSection(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text('upload', style: TextStyle(color: Colors.black54)),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                // TODO: Upload action
              },
              icon: const Icon(Icons.upload_file),
            ),
            IconButton(
              onPressed: () {
                // TODO: Extra upload or alternate option
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

// 7. Request Sent Confirmation
class RequestSentScreen extends StatelessWidget {
  const RequestSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'DonorNet',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Green Circle with Check Icon
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 80,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Your request has\nbeen sent\nfor approval!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 50),

            // Go to Welcome Screen Button
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/welcome');
                },
                child: const Text(
                  'Go to home screen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 8. DONOR SIGNUP SCREEN 1
class DonorSignup1Screen extends StatefulWidget {
  const DonorSignup1Screen({super.key});

  @override
  State<DonorSignup1Screen> createState() => _DonorSignup1ScreenState();
}

class _DonorSignup1ScreenState extends State<DonorSignup1Screen> {
  String? selectedGender;
  String? selectedMaritalStatus;

  final List<String> genderOptions = [
    'Female',
    'Male',
    'Prefer not to say',
    'Other',
  ];

  final List<String> maritalStatusOptions = [
    'Married',
    'Unmarried',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'DonorNet',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                'DONOR SIGNUP',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
              ),

              const SizedBox(height: 50),

              _buildTextField('Enter Username'),
              const SizedBox(height: 20),

              _buildTextField('Enter Email Address'),
              const SizedBox(height: 20),

              _buildTextField('Enter CNIC'),
              const SizedBox(height: 20),

              // Gender Dropdown
              _buildDropdown(
                hint: 'Select Gender',
                value: selectedGender,
                items: genderOptions,
                onChanged: (val) => setState(() => selectedGender = val),
              ),
              const SizedBox(height: 20),

              // Marital Status Dropdown
              _buildDropdown(
                hint: 'Select Marital Status',
                value: selectedMaritalStatus,
                items: maritalStatusOptions,
                onChanged: (val) => setState(() => selectedMaritalStatus = val),
              ),
              const SizedBox(height: 20),

              _buildTextField('Enter Password', obscure: true),
              const SizedBox(height: 20),

              _buildTextField('Re-enter Password', obscure: true),
              const SizedBox(height: 40),

              // Continue Button
              SizedBox(
                width: size.width * 0.6,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/patientsignup-2');
                  },
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(String hint, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      ),
    );
  }
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        hint: Text(hint),
        icon: const Icon(Icons.arrow_drop_down),
        items: items.map((item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        )).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

// 8. Patient Home Page 
class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/donor_net_logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text(
              'DONOR NET',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                thickness: 1,
                color: Colors.black12,
                indent: 20,
                endIndent: 20,
              ),

              // Location Details
              Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.red),
                  SizedBox(width: 10),
                  Text('Karachi', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.only(left: 34),
                child: Text(
                  'Jiwan Homes, Garden East',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 24),

              // Search Bar
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/searchscreen');
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // See Request History Button
              _buildButton(context, 'SEE REQUEST HISTORY', () {
                // Navigate to request history page
              }),
              const SizedBox(height: 24),

              // Browse Bloodbanks
              _buildSectionTitle('BROWSE BLOODBANKS'),
              const SizedBox(height: 11),
              _buildHorizontalIcons([
                Icons.local_hospital,
                Icons.local_hospital,
                Icons.local_hospital,
              ]),
              const SizedBox(height: 24),

              // Browse Donors
              _buildSectionTitle('BROWSE DONORS'),
              const SizedBox(height: 11),
              _buildHorizontalIcons([
                Icons.person_outline,
                Icons.person_outline,
                Icons.person_outline,
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 28),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload, size: 28),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
           if (index == 1) {
             Navigator.pushNamed(context, '/searchscreen');
            }

        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            // Navigate to respective section
          },
        ),
      ],
    );
  }

  Widget _buildHorizontalIcons(List<IconData> icons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons
          .map(
            (icon) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: Icon(icon, size: 40, color: Colors.red),
                onPressed: () {
                  // Handle icon tap
                },
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

// 9. Search Screen 
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedFilter = 'Donor';  // Default filter (can be patient or donor)
  String selectedBloodType = 'A+';
  bool isAvailable = false;
  String location = 'Karachi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/donor_net_logo.png', // DonorNet logo
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text('DONOR NET'),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar and filter options
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () {
                      // Handle search bar tap behavior
                      print('Search Bar Tapped');
                    },
                  ),
                  const SizedBox(height: 20),

                  // Filter: Donor/Patient
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedFilter = 'Donor';
                            });
                          },
                          child: const Text('Donor'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedFilter == 'Donor'
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedFilter = 'Patient';
                            });
                          },
                          child: const Text('Patient'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedFilter == 'Patient'
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Filter: Blood Type
                  Row(
                    children: [
                      const Text('Blood Type:'),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: selectedBloodType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedBloodType = newValue!;
                          });
                        },
                        items: ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-']
                            .map((bloodType) {
                          return DropdownMenuItem<String>(
                            value: bloodType,
                            child: Text(bloodType),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Filter: Availability
                  Row(
                    children: [
                      const Text('Availability Status:'),
                      Switch(
                        value: isAvailable,
                        onChanged: (value) {
                          setState(() {
                            isAvailable = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Filter: Location
                  Row(
                    children: [
                      const Text('Location:'),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: location,
                        onChanged: (newLocation) {
                          setState(() {
                            location = newLocation!;
                          });
                        },
                        items: ['Karachi', 'Lahore', 'Islamabad', 'Peshawar']
                            .map((loc) {
                          return DropdownMenuItem<String>(
                            value: loc,
                            child: Text(loc),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Apply Filter Button
                  ElevatedButton(
                    onPressed: () {
                      // You can implement the logic to apply filters and perform the search
                      print('Filters Applied: $selectedFilter, $selectedBloodType, $isAvailable, $location');
                    },
                    child: const Text('Search'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation logic
          print('Bottom Navigation: $index');
        },
      ),
    );
  }
}

//10.Admin Home Page 
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/donor_net_logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text('DONOR NET'),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: () {
                  // Optional: Navigate to search screen
                  print('Search Bar Tapped');
                },
              ),
              const SizedBox(height: 30),

              // Navigational Boxes
              buildNavBox(
                context,
                title: 'Approve Patient Signups',
                onTap: () => navigateTo(context, ApprovePatientSignupScreen()),
              ),
              const SizedBox(height: 20),
              buildNavBox(
                context,
                title: 'Approve Donor Signups',
                onTap: () => navigateTo(context, ApproveDonorSignupScreen()),
              ),
              const SizedBox(height: 20),
              buildNavBox(
                context,
                title: 'View Admin Dashboard',
                onTap: () => navigateTo(context, AdminDashboardScreen()),
              ),
              const SizedBox(height: 20),
              buildNavBox(
                context,
                title: 'Add a Blood Bank',
                onTap: () => navigateTo(context, AddBloodBankScreen()),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation
          print('Tapped on index: $index');
        },
      ),
    );
  }

  Widget buildNavBox(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class AddBloodBankScreen extends StatefulWidget {
  const AddBloodBankScreen({Key? key}) : super(key: key);

  @override
  State<AddBloodBankScreen> createState() => _AddBloodBankScreenState();
}

class _AddBloodBankScreenState extends State<AddBloodBankScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  String city = 'Karachi';
  String operatingHours = '';
  String admin = '';
  String website = '';
  String password = '';

  final List<String> cityOptions = [
    'Karachi', 'Lahore', 'Islamabad', 'Peshawar', 'Quetta'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/donor_net_logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text('DONOR NET'),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  'Add a Blood Bank',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                buildTextField('Name', onChanged: (val) => name = val),
                buildTextField('Email', onChanged: (val) => email = val, keyboardType: TextInputType.emailAddress),
                buildTextField('Phone Number', onChanged: (val) => phone = val, keyboardType: TextInputType.phone),
                buildTextField('Address', onChanged: (val) => address = val),
                const SizedBox(height: 10),

                const Text('City'),
                DropdownButtonFormField<String>(
                  value: city,
                  items: cityOptions.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      city = val!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                buildTextField('Operating Hours (e.g., 9AM-5PM)', onChanged: (val) => operatingHours = val),
                buildTextField('Admin In Charge', onChanged: (val) => admin = val),
                buildTextField('Website (optional)', onChanged: (val) => website = val),
                buildTextField('Password', onChanged: (val) => password = val, obscureText: true),
                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Submitting Blood Bank Info:');
                        print('Name: $name');
                        print('Email: $email');
                        print('Phone: $phone');
                        print('Address: $address');
                        print('City: $city');
                        print('Hours: $operatingHours');
                        print('Admin: $admin');
                        print('Website: $website');
                        print('Password: $password');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Blood Bank Added')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          print('Bottom Nav Tapped: $index');
        },
      ),
    );
  }

  Widget buildTextField(String label,
      {required Function(String) onChanged,
      TextInputType keyboardType = TextInputType.text,
      bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: (value) {
          if ((label != 'Website (optional)') &&
              (value == null || value.isEmpty)) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}

// Approve Patient Signup Screen 
class ApprovePatientSignupScreen extends StatelessWidget {
  const ApprovePatientSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/donor_net_logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text('DONOR NET'),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Approve Patient Signups',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildNavigationBox(context, 'Fatima Dossa'),
              const SizedBox(height: 12),
              _buildNavigationBox(context, 'Ali Raza'),
              const SizedBox(height: 12),
              _buildNavigationBox(context, 'Zainab Khan'),
              const SizedBox(height: 12),
              _buildNavigationBox(context, 'Ahmad Sheikh'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation
        },
      ),
    );
  }

  Widget _buildNavigationBox(BuildContext context, String name) {
    // Mock data to be passed — in real case, fetch from backend
    final Map<String, dynamic> mockUserData = {
      'username': name,
      'email': '$name@example.com',
      'address': '123 Street',
      'cnic': '42101-1234567-8',
      'gender': 'Female',
      'maritalStatus': 'Single',
      'password': 'password123',
      'rePassword': 'password123',
      'phoneNumber': '03123456789',
      'city': 'Karachi',
      'bloodGroup': 'O+',
      'bloodProof': 'proof_bloodgroup.pdf',
      'cbcProof': 'proof_cbc.pdf',
    };

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/viewdetails',
          arguments: mockUserData,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

// 12. Approve Donor Signup screen 
class ApproveDonorSignupScreen extends StatelessWidget {
  const ApproveDonorSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/donor_net_logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text('DONOR NET'),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Approve Donor Signups',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Example donor entries
              _buildNavigationBox(context, 'Fatima Ali'),
              const SizedBox(height: 12),
              _buildNavigationBox(context, 'Zaid Ahmed'),
              const SizedBox(height: 12),
              _buildNavigationBox(context, 'Areeba Raza'),
              const SizedBox(height: 12),
              _buildNavigationBox(context, 'Omar Farooq'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Navigation logic here if needed
        },
      ),
    );
  }

  Widget _buildNavigationBox(BuildContext context, String name) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
        context,
        '/viewdetails',
        arguments: {
          'username': 'JohnDoe',
          'email': 'john@example.com',
          'address': '123 Main Street',
          'cnic': '42101-1234567-8',
          'gender': 'Male',
          'maritalStatus': 'Single',
          'password': '123456',
          'rePassword': '123456',
          'phone': '03001234567',
          'city': 'Karachi',
          'bloodGroup': 'A+',
          'bloodGroupProof': 'https://example.com/bgproof.pdf',
          'cbcProof': 'https://example.com/cbcproof.pdf',
        },
      );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

// 13.View Details
class ViewDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ViewDetailsScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String bloodGroupProof = userData['bloodGroupProof'] ?? '';
    final String cbcProof = userData['cbcProof'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/donor_net_logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text('DONOR NET'),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'View Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDetailTile('Username', userData['username']),
            _buildDetailTile('Email', userData['email']),
            _buildDetailTile('Address', userData['address']),
            _buildDetailTile('CNIC', userData['cnic']),
            _buildDetailTile('Gender', userData['gender']),
            _buildDetailTile('Marital Status', userData['maritalStatus']),
            _buildDetailTile('Password', userData['password']),
            _buildDetailTile('Re-enter Password', userData['rePassword']),
            _buildDetailTile('Phone Number', userData['phone']),
            _buildDetailTile('City', userData['city']),
            _buildDetailTile('Blood Group', userData['bloodGroup']),

            const SizedBox(height: 20),
            const Text(
              'Proof of Blood Group:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            _buildPdfButton(context, bloodGroupProof, 'View Blood Group Proof'),

            const SizedBox(height: 16),
            const Text(
              'Proof of CBC:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            _buildPdfButton(context, cbcProof, 'View CBC Proof'),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    // TODO: Add approval logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Approved successfully')),
                    );
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Approve'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    // TODO: Add decline logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Declined')),
                    );
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Decline'),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildDetailTile(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value ?? '-',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfButton(BuildContext context, String link, String label) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Open/view PDF logic
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Open PDF: $link')),
        );
      },
      icon: const Icon(Icons.picture_as_pdf),
      label: Text(label),
    );
  }
}

//14.Mock Admin Dashboard Screen 
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/donor_net_logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text('DONOR NET'),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: const SafeArea(
        child: Center(
          child: Text(''), // Empty body as requested
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation here if needed
        },
      ),
    );
  }
}

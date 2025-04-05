import 'package:flutter/material.dart';

void main() {
  runApp(const DonorNetApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donor Net',
      home: LoginScreen(),
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
        '/reqsent' : (context) => RequestSentScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/donorsignup-1': (context) => const DonorSignup1Screen(),
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
                    // TODO: Implement your login logic
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
# 🔐 API Assignment - Flutter GetX Architecture

A Flutter application built using the **GetX architecture** that demonstrates API integration, state management, pagination, Firebase Authentication, dependency injection, form validation, and widget testing.

The project follows a **separation of concerns** approach using controllers, repositories, services, models, bindings, and views to keep the application organized and maintainable.

---

## 🚀 Overview

This application interacts with REST APIs and Firebase Authentication to perform the following operations:

* User registration using Firebase Authentication
* User login using Firebase Authentication
* User logout
* Fetch and display users from the ReqRes REST API
* Implement API pagination and infinite scrolling
* Pull-to-refresh user data
* Display user profile information and avatars
* Handle API and authentication errors
* Validate login and registration forms
* Manage dependencies using GetX bindings
* Perform widget and controller-level testing

The project is designed as a learning and demonstration application showcasing Flutter development with **GetX, REST API integration, Firebase Authentication, repository architecture, and automated testing**.

---

## ✨ Features

### 🔐 Authentication

* Firebase email/password registration
* Firebase email/password login
* Firebase logout
* Automatic login state detection
* Authentication error handling
* Loading indicators during authentication
* Email validation
* Password validation
* Confirm password validation
* Show/hide password functionality

### 👥 User Management

* Fetch users from ReqRes API
* Display first name and last name
* Display user email
* Display user avatar
* Infinite scrolling / pagination
* Load users page by page
* Pull-to-refresh support
* Loading states
* Pagination loading indicator
* API error handling
* Retry mechanism
* "No more users" state

### 🧪 Testing

* Login form widget tests
* Signup form widget tests
* Email validation tests
* Password validation tests
* Confirm password validation tests
* Password visibility tests
* Authentication controller interaction tests
* User API pagination tests
* User refresh tests
* API error handling tests

### 🏗 Architecture

* GetX state management
* GetX dependency injection
* GetX route management
* Controller / Repository / Service separation
* Model-based API response handling
* Feature separation through bindings
* Reusable services and repositories

---


## 📸 Screenshots

<p align="center">
  <img src="https://github.com/SanjogMagar/Getx-Assignment/blob/4c381e15f6e8528c03eb5c06017c6fa0ec62d894/login.jpeg" alt="Login Screen" width="250"/>
  <img src="https://github.com/SanjogMagar/Getx-Assignment/blob/4c381e15f6e8528c03eb5c06017c6fa0ec62d894/signup.jpeg" alt="Signup Screen" width="250"/>
  <img src="https://github.com/SanjogMagar/Getx-Assignment/blob/4c381e15f6e8528c03eb5c06017c6fa0ec62d894/user.jpeg" alt="User Screen" width="250"/>
</p>

## 🎥 Demo Video

▶️ [Click here to watch the Demo Video](https://github.com/SanjogMagar/Getx-Assignment/blob/4c381e15f6e8528c03eb5c06017c6fa0ec62d894/Demo%20video.mp4)

---

## 🛠 Tech Stack

### Frontend

* Flutter
* Dart

### State Management

* GetX

### Authentication

* Firebase Authentication
* Firebase Core

### Networking

* Dio
* HTTP

### Image Handling

* cached_network_image

### Architecture

* Controller Pattern
* Repository Pattern
* Service Layer
* GetX Dependency Injection
* GetX Bindings
* GetX Route Management

### Testing

* flutter_test
* Widget Testing
* Fake Services / Controllers for isolated tests

---

## 📂 Project Structure

```text
lib/
│
├── bindings/
│   ├── firebase_binding.dart
│   ├── initial_binding.dart
│   └── user_binding.dart
│
├── controllers/
│   ├── firebase_controller.dart
│   └── user_controller.dart
│
├── models/
│   └── user_model.dart
│
├── repositories/
│   ├── firebase_repositroy.dart
│   └── user_reposiotry.dart
│
├── services/
│   ├── firebase_services.dart
│   └── user_services.dart
│
├── views/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   └── user_screen.dart
│
├── firebase_options.dart
└── main.dart

test/
│
├── unit_testing/
│   ├── login_test.dart
│   ├── signup_test.dart
│   └── user_screen_test.dart
```

---

## 📦 Dependencies

```yaml
get:
dio:
http:
firebase_auth:
firebase_core:
cached_network_image:
cupertino_icons:
```

The project uses Dart SDK `^3.11.5`.

---

## ⚙️ Installation

### Clone Repository

```bash
git clone <your-repository-url>
```

### Navigate to Project

```bash
cd assignment
```

### Install Dependencies

```bash
flutter pub get
```

### Configure Firebase

Configure Firebase for the Flutter project and make sure the required Firebase Authentication setup is enabled.

### Run Application

```bash
flutter run
```

### Run Tests

```bash
flutter test
```

---

## 🔄 Application Flow

### Authentication Flow

```text
Login / Signup Screen
        ↓
AuthController
        ↓
AuthRepository
        ↓
FirebaseAuthService
        ↓
Firebase Authentication
        ↓
AuthController State
        ↓
UI Update
```

### User API Flow

```text
User Screen
     ↓
UserController
     ↓
UserRepository
     ↓
UserServices
     ↓
Dio
     ↓
ReqRes API
     ↓
UserModel
     ↓
UserController
     ↓
UI Update
```

The application separates UI, controller logic, repository operations, and API/Firebase services.

---

## 🔄 Pagination Flow

```text
User opens User Screen
        ↓
Fetch Page 1
        ↓
Display Users
        ↓
User Scrolls Near Bottom
        ↓
Load Next Page
        ↓
Append Users
        ↓
Check Total Pages
        ↓
Display More / No More Users
```

The application loads users with a default `perPage` value of **5** and prevents additional requests after the final available page.

---

## 🔐 Authentication Flow

```text
User
 ↓
Login / Signup Form
 ↓
Form Validation
 ↓
AuthController
 ↓
AuthRepository
 ↓
FirebaseAuthService
 ↓
Firebase Authentication
 ↓
Success / Error
 ↓
Users Screen / Error Message
```

Firebase authentication errors are converted into user-friendly messages such as invalid email, incorrect credentials, existing account, weak password, and network errors.

---

## 🧪 Testing

The project includes automated tests covering authentication forms and user API functionality.

### Login Tests

* Empty email validation
* Invalid email validation
* Valid email validation
* Empty password validation
* Short password validation
* Valid password validation
* Password visibility toggle
* Successful controller interaction
* Invalid input prevention

### Signup Tests

* Empty email validation
* Invalid email validation
* Password validation
* Minimum password length
* Confirm password validation
* Password mismatch validation
* Password visibility toggle
* Signup controller interaction
* Invalid input prevention

### User Tests

* First page loading
* User data parsing
* API pagination parameters
* Loading state
* Loading subsequent pages
* Preventing requests after the last page
* Pagination loading state
* Pull-to-refresh
* API error handling

---

## 📱 User Interface

The application contains three primary screens:

```text
┌──────────────────────┐
│      Login Screen    │
│                      │
│  Email               │
│  Password            │
│  [ Login ]           │
│  [ Sign Up ]         │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│     Signup Screen    │
│                      │
│  Email               │
│  Password            │
│  Confirm Password    │
│  [ Sign Up ]         │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│      Users Screen    │
│                      │
│      User Avatar     │
│      First Name      │
│      Last Name       │
│      Email           │
│                      │
│      ↓ Load More     │
└──────────────────────┘
```

---

## 📚 What I Learned

* Flutter GetX Architecture
* GetX State Management
* GetX Dependency Injection
* GetX Bindings
* GetX Route Management
* Firebase Authentication
* REST API Integration
* Dio Networking
* Repository Pattern
* Service Layer Architecture
* JSON Model Parsing
* Pagination & Infinite Scrolling
* Pull-to-Refresh
* Form Validation
* Error Handling
* Cached Network Images
* Flutter Widget Testing
* Creating fake services for isolated tests


---

## 👨‍💻 Author

**Sanjog Magar**

Flutter Developer | Full Stack Developer

* Flutter
* Dart
* Firebase
* Node.js
* MongoDB
* REST APIs

---

## 📄 License

This project is developed for educational and learning purposes as part of Flutter API integration, GetX architecture, Firebase Authentication, pagination, and testing practice.

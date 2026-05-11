<div align="center">

# 🗺️ Daliliy - City Services Guide

**Your Complete Guide to Essential City Services**

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

[Features](#-features) • [Screenshots](#-screenshots) • [Tech Stack](#-tech-stack) • [Getting Started](#-getting-started) • [Roadmap](#-roadmap)

</div>

---

## 📱 Overview

**Daliliy** (دليلي - "My Guide" in Arabic) is a comprehensive city services directory mobile application designed to connect users with essential services in their city. Built with Flutter for a seamless cross-platform experience, Daliliy makes finding trusted local services simple and efficient.

### 🎯 The Challenge

Finding reliable local services in Egyptian cities can be frustrating:
- Information is scattered across multiple platforms
- Service quality is difficult to verify
- No centralized, up-to-date directory exists
- Service providers struggle to reach potential customers

### ✨ The Solution

Daliliy provides a unified platform where:
- **Users** discover verified services instantly
- **Service Providers** expand their customer base
- **Quality** is maintained through admin approval workflow
- **Everyone** benefits from a trusted, community-driven directory

---

## 🚀 Features

### 👥 For Users

- **🔍 Smart Service Discovery**
  - Browse services by category (Pharmacies, Doctors, Labs, Restaurants, etc.)
  - Location-based search to find nearby services
  - Intuitive filtering and sorting options

- **📱 Seamless Experience**
  - Clean, modern Material Design UI
  - Smooth animations and transitions
  - Fast loading with optimized performance
  - Easy-to-use navigation

- **📍 Location Integration**
  - View services on interactive maps
  - Get directions to service locations
  - See distance from your current position

### 🏪 For Service Providers

- **➕ Self-Service Registration**
  - Add your business directly from the app
  - Upload photos and detailed descriptions
  - Set your operating hours and contact info

- **✅ Quality Assurance**
  - Admin approval process ensures listing quality
  - Verified badge for approved services
  - Instant visibility once approved

- **📊 Business Benefits**
  - Reach more customers in your area
  - No technical knowledge required
  - Free listing (currently)

### 🛡️ Admin Features

- **Approval Workflow**
  - Review new service submissions
  - Approve or reject with feedback
  - Monitor service quality

- **Content Moderation**
  - Remove inappropriate content
  - Update service information
  - Manage categories

---

## 📸 Screenshots

<div align="center">

### 🏠 Home & Navigation

<table>
  <tr>
    <td align="center">
      <img width="250" alt="Splash Screen" src="https://github.com/user-attachments/assets/ecdfcceb-fb57-4910-a750-88410d56c0ba" />
      <br />
      <b>Splash Screen</b>
    </td>
    <td align="center">
      <img width="250" alt="Home Screen" src="https://github.com/user-attachments/assets/80271868-3a11-4633-8e1e-48614d14f713" />
      <br />
      <b>Home Screen</b>
    </td>
    <td align="center">
      <img width="250" alt="Categories" src="https://github.com/user-attachments/assets/4942786a-656f-45ec-9174-e5285efc1647" />
      <br />
      <b>Service Categories</b>
    </td>
  </tr>
</table>

### 🔍 Service Discovery

<table>
  <tr>
    <td align="center">
      <img width="250" alt="Service List" src="https://github.com/user-attachments/assets/2d7e6d15-5aee-4c87-9619-14805b1eaf3a" />
      <br />
      <b>Service List</b>
    </td>
    <td align="center">
      <img width="250" alt="Service Details" src="https://github.com/user-attachments/assets/0a1fca8d-c118-477c-b084-24aa7a72bee8" />
      <br />
      <b>Service Details</b>
    </td>
    <td align="center">
      <img width="250" alt="Search Results" src="https://github.com/user-attachments/assets/5f40ed85-73bb-40dc-a21b-fd8d7ac30528" />
      <br />
      <b>Search & Filter</b>
    </td>
  </tr>
</table>

### 📍 Location & Maps

<table>
  <tr>
    <td align="center">
      <img width="250" alt="Map View" src="https://github.com/user-attachments/assets/1ce9831f-72c0-47f1-99fe-e3d2e14b6443" />
      <br />
      <b>Map View</b>
    </td>
    <td align="center">
      <img width="250" alt="Location Details" src="https://github.com/user-attachments/assets/7a2a290f-9b3c-43ee-a521-8a5850256910" />
      <br />
      <b>Location Details</b>
    </td>
    <td align="center">
      <img width="250" alt="Directions" src="https://github.com/user-attachments/assets/bd05b651-594c-4753-829a-569c14050d03" />
      <br />
      <b>Navigation</b>
    </td>
  </tr>
</table>

### ➕ Provider Features

<table>
  <tr>
    <td align="center">
      <img width="250" alt="Add Service" src="https://github.com/user-attachments/assets/b75d9d6f-d325-4920-8a6e-06dbe7e1c1d3" />
      <br />
      <b>Add Your Service</b>
    </td>
    <td align="center">
      <img width="250" alt="Admin Panel" src="https://github.com/user-attachments/assets/5ca9f0a7-6618-4676-b451-beb3e89cd82e" />
      <br />
      <b>Admin Approval</b>
    </td>
  </tr>
</table>

</div>

---

## 🛠️ Tech Stack

### **Frontend Framework**
- **Flutter 3.x** - Google's UI toolkit for cross-platform development
- **Dart 3.x** - Client-optimized programming language
- **Material Design 3** - Modern, accessible design system

### **State Management**
- **Cubit** (flutter_bloc) - Lightweight BLoC state management
- **Provider** - Dependency injection and state propagation

### **Backend & Services**
- **Firebase Authentication** - Secure user authentication
- **Cloud Firestore** - Scalable NoSQL cloud database
- **Firebase Storage** - Cloud storage for images
- **Firebase Cloud Messaging** - Push notifications (planned)

### **APIs & Integration**
- **Google Maps API** - Interactive maps and location services
- **Dio** - Powerful HTTP client for REST APIs
- **Geolocator** - Location and geocoding services

### **UI & Media**
- **Lottie** - Smooth, scalable animations
- **Cached Network Image** - Efficient image caching
- **Flutter SVG** - Scalable vector graphics support

### **Development Tools**
- **Git** - Version control
- **VS Code** - Primary IDE
- **Firebase Console** - Backend management
- **Postman** - API testing and documentation

---

## 🏗️ Project Structure

//
//  AuthenticationView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/09/2025.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    // MARK: - State Variables
    @State private var isLoginMode = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var fullName = ""
    @State private var phoneNumber = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var biometricType: LABiometryType = .none
    
    // MARK: - Methods
    private func checkBiometricAvailability() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            biometricType = context.biometryType
            print("Biometric available: \(biometricType)")
        } else {
            biometricType = .none
            print("Biometric not available: \(error?.localizedDescription ?? "Unknown Error")")
        }
    }
    // MARK: - Authentication Methods
    private func handleSignIn() {
        // Form validation
        guard !email.isEmpty, !password.isEmpty else {
            showErrorMessage("Please fill in all fields")
            return
        }
        
        guard isValidEmail(email) else {
            showErrorMessage("Please enter a valid email address")
            return
        }
        
        // Show loading state
        withAnimation(.spring()) {
            isLoading = true
        }
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.spring()) {
                isLoading = false
            }
            
            // TODO: Connect to real authentication
            print("🔐 Sign in successful for: \(email)")
            // Navigate to main app here
        }
    }

    private func handleSignUp() {
        // Enhanced validation for signup
        guard !email.isEmpty, !password.isEmpty, !fullName.isEmpty, !phoneNumber.isEmpty else {
            showErrorMessage("Please fill in all required fields")
            return
        }
        
        guard isValidEmail(email) else {
            showErrorMessage("Please enter a valid email address")
            return
        }
        
        guard password.count >= 8 else {
            showErrorMessage("Password must be at least 8 characters long")
            return
        }
        
        guard password == confirmPassword else {
            showErrorMessage("Passwords do not match")
            return
        }
        
        withAnimation(.spring()) {
            isLoading = true
        }
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.spring()) {
                isLoading = false
            }
            
            print(" Account created successfully for: \(fullName)")
            // Navigate to main app here
        }
    }

    private func handleBiometricAuth() {
        let context = LAContext()
        let reason = "Use biometrics to access your pet's medical records securely"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    print(" Biometric authentication successful!")
                    // Navigate to main app here
                } else {
                    let errorMessage = error?.localizedDescription ?? "Biometric authentication failed"
                    self.showErrorMessage(errorMessage)
                }
            }
        }
    }

    // MARK: - Helper Methods
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private func showErrorMessage(_ message: String) {
        errorMessage = message
        showError = true
    }

    private func clearForm() {
        email = ""
        password = ""
        confirmPassword = ""
        fullName = ""
        phoneNumber = ""
        showPassword = false
        showConfirmPassword = false
    }

    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: VetSpacing.xl) {
                    // MARK: - Header Section
                    AuthHeaderView(isLoginMode: isLoginMode)
                        .padding(.top, VetSpacing.xxl)
                    // MARK: - Form Section
                    VStack(spacing: VetSpacing.lg) {
                        // MARK: - Form Fields
                        VStack(spacing: VetSpacing.md) {
                            // Full Name (Sign up only)
                            if !isLoginMode {
                                VetTextField(
                                    text: $fullName,
                                    placeholder: "Full Name",
                                    icon: "person.fill"
                                )
                                .transition(.asymmetric(
                                    insertion: .move(edge: .top).combined(with: .opacity),
                                    removal: .move(edge: .top).combined(with: .opacity)
                                ))
                            }
                            
                            // Phone Number (Sign up only)
                            if !isLoginMode {
                                VetTextField(
                                    text: $phoneNumber,
                                    placeholder: "Phone Number",
                                    icon: "phone.fill",
                                    keyboardType: .phonePad
                                )
                                .transition(.asymmetric(
                                    insertion: .move(edge: .top).combined(with: .opacity),
                                    removal: .move(edge: .top).combined(with: .opacity)
                                ))
                            }
                            
                            // Email
                            VetTextField(
                                text: $email,
                                placeholder: "Email Address",
                                icon: "envelope.fill",
                                keyboardType: .emailAddress
                            )
                            
                            // Password
                            VetSecureField(
                                text: $password,
                                placeholder: "Password",
                                icon: "lock.fill",
                                showPassword: $showPassword
                            )
                            
                            // Confirm Password (Sign up only)
                            if !isLoginMode {
                                VetSecureField(
                                    text: $confirmPassword,
                                    placeholder: "Confirm Password",
                                    icon: "lock.fill",
                                    showPassword: $showConfirmPassword
                                )
                                .transition(.asymmetric(
                                    insertion: .move(edge: .top).combined(with: .opacity),
                                    removal: .move(edge: .top).combined(with: .opacity)
                                ))
                            }
                            
                            // Forgot Password (Login only)
                            if isLoginMode {
                                HStack {
                                    Spacer()
                                    Button("Forgot Password?") {
                                        print("🔑 Forgot password tapped")
                                        // TODO: Handle forgot password
                                    }
                                    .font(.vetBodyMedium)
                                    .foregroundColor(.vetPrimary)
                                }
                                .transition(.opacity)
                            }
                        }
                        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: isLoginMode)
                        
                        // MARK: - Action Buttons
                        VStack(spacing: VetSpacing.md) {
                            // Primary Action Button
                            PrimaryAuthButton(
                                title: isLoginMode ? "Sign In" : "Create Account",
                                isLoading: isLoading
                            ) {
                                if isLoginMode {
                                    handleSignIn()
                                } else {
                                    handleSignUp()
                                }
                            }
                            
                            // Biometric Auth (Login only)
                            if isLoginMode && biometricType != .none {
                                BiometricAuthButton(biometricType: biometricType) {
                                    handleBiometricAuth()
                                }
                            }
                            
                            // Alternative Actions
                            VStack(spacing: VetSpacing.lg) {
                                // Or Divider
                                HStack {
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(.secondary.opacity(0.3))
                                    
                                    Text("or")
                                        .font(.vetBodyMedium)
                                        .foregroundColor(.secondary)
                                        .padding(.horizontal, VetSpacing.md)
                                    
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(.secondary.opacity(0.3))
                                }
                                
                                // Toggle Auth Mode
                                HStack(spacing: VetSpacing.xs) {
                                    Text(isLoginMode ? "Don't have an account?" : "Already have an account?")
                                        .font(.vetBodyMedium)
                                        .foregroundColor(.secondary)
                                    
                                    Button(action: {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                            isLoginMode.toggle()
                                            clearForm()
                                        }
                                    }) {
                                        Text(isLoginMode ? "Sign up" : "Sign in")
                                            .font(.vetBodyMedium)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.vetPrimary)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, VetSpacing.lg)

                    
                    Spacer(minLength: VetSpacing.xl)
                }
            }
            .frame(minHeight: geometry.size.height)
        }
        .background(Color.vetBackground)
        .alert("Authentication Error", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .onAppear {
            checkBiometricAvailability()
        }
    }
}
// MARK: - Auth Header Component
struct AuthHeaderView: View {
    let isLoginMode: Bool
    
    var body: some View {
        VStack(spacing: VetSpacing.lg) {
            //logo
            Vets4PetsLogoView().scaleEffect(0.8)
            
            //title and subtitle with animation
            VStack(spacing: VetSpacing.sm) {
                Text(isLoginMode ? "Welcome Back" : "Join Vets4Pets")
                    .font(.vetDisplaySmall)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                
                Text(isLoginMode ? "Sign in to access your pet's health records" : "Create an account to start managing your pet's health")
                    .font(.vetBodyLarge)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, VetSpacing.lg)
        .animation(.easeInOut(duration: 0.3), value: isLoginMode)
    }
}
// MARK: - Custom Text Field Component
struct VetTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String
    var keyboardType: UIKeyboardType = .default
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: VetSpacing.md){
            //icon with focus animation
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(isFocused ? .primary : .secondary)
                .frame(width: 20)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
            //text field
            TextField(placeholder, text: $text)
                .font(.vetBodyLarge)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .focused($isFocused)
        }
        .padding(VetSpacing.md)
        .background(Color.vetCardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: VetRadius.md)
                .stroke(isFocused ? Color.vetPrimary : Color.clear, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: VetRadius.md))
        .vetElevation(.sm)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}
// MARK: - Custom Secure Field Component
struct VetSecureField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String
    @Binding var showPassword: Bool
    @FocusState private var isFocused: Bool
    
    var body: some View{
        HStack(spacing: VetSpacing.md) {
            //lock icon
            Image(systemName: icon)
                .font(.system(size:18, weight:.medium))
                .foregroundStyle(isFocused ? .primary : .secondary)
                .frame(width: 20)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
            //password field
            Group {
                if showPassword {
                    TextField(placeholder, text: $text)
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
            .font(.vetBodyLarge)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .focused($isFocused)
            
            //show/hide password button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showPassword.toggle()
                }
            }) {
                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                    .font(.system(size: 16, weight:.medium))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(VetSpacing.md)
        .background(Color.vetCardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: VetRadius.md)
                .stroke(isFocused ? Color.primary : Color.clear, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: VetRadius.md))
        .vetElevation(.sm)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}
// MARK: - Biometric Authentication Button
struct BiometricAuthButton: View {
    let biometricType: LABiometryType
    let action: () -> Void
    
    private var biometricText: String {
        switch biometricType {
        case .faceID: return "Sign in with Face ID"
        case .touchID: return "Sign in with Touch ID"
        default: return "Sign in with Biometrics"
        }
    }
    
    private var biometricIcon: String {
        switch biometricType {
        case .touchID:
            return "touchid"
        case .faceID:
            return "faceid"
        default:
            return "person.badge.key.fill"
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: VetSpacing.sm) {
                Image(systemName: biometricIcon)
                    .font(.system(size: 18, weight: .medium))
                Text(biometricText)
                    .font(.vetLabelLarge)
            }
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.primary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: VetRadius.lg))
            .overlay(
                RoundedRectangle(cornerRadius: VetRadius.lg)
                    .stroke(Color.primary.opacity(0.3), lineWidth: 1)
            )
        }
    }
}
// MARK: - Primary Action Button
struct PrimaryAuthButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: VetSpacing.sm) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Text(title)
                        .font(.vetLabelLarge)
                        .fontWeight(.semibold)
                }
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(colors: [.vetPrimary, .vetSecondary], startPoint: .leading, endPoint: .trailing
                              )
            )
            .clipShape(RoundedRectangle(cornerRadius: VetRadius.lg))
            .vetElevation(.md)
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed
            )
        }
        .disabled(isLoading)
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { 
            isPressed = true
        } onPressingChanged: { pressing in
            isPressed = pressing
        }
    }
}

#Preview {
    AuthenticationView()
}

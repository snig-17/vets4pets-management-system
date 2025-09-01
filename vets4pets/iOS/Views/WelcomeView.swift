//
//  WelcomeView.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/09/2025.
//

import SwiftUI

struct WelcomeView: View {
    // MARK: - State Variables
    @State private var currentPage = 0
    @State private var animateGradient = false
    @State private var showGetStarted = false
    
    // MARK: - Data
    private let onboardingPages = OnboardingPage.allPages
    
    // MARK: - Action Methods
       private func handleGetStarted() {
           withAnimation(.spring()) {
               // TODO: Navigate to main app
               print("Get Started tapped! Ready to go to main app")
           }
       }
       
       private func handleSkip() {
           withAnimation(.spring()) {
               // TODO: Navigate to main app
               print("Skip tapped! Going directly to main app")
           }
       }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // MARK: - Animated Background
                AnimatedGradientBackground(animate: $animateGradient).ignoresSafeArea()
                
                // MARK: - Content
                VStack(spacing: 30){
                    Spacer()
                    
                    Vets4PetsLogoView()
                        .scaleEffect(showGetStarted ? 1.0 : 0.8)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showGetStarted)
                    VStack(spacing: 10){
                        Text("Welcome to ")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        
                        
                        Text("Vets4Pets")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.vetPrimary, .vetSecondary],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                    }
                    .opacity(showGetStarted ? 1.0 : 0.0)
                    .offset(y: showGetStarted ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.2), value: showGetStarted)
                    
                    Spacer()
                    
                    TabView(selection: $currentPage){
                        ForEach(Array(onboardingPages.enumerated()), id: \.element) { index, page in
                            OnboardingCardView(page: page)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 280)
                    .opacity(showGetStarted ? 1.0 : 0.0)
                    .offset(y: showGetStarted ? 0 : 50)
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: showGetStarted)
                    
                    Spacer()
                    
                    // MARK: - Bottom Action Section
                    VStack(spacing: VetSpacing.lg) {
                        // page indicator dots
                        HStack(spacing: VetSpacing.sm) {
                            ForEach(0..<onboardingPages.count, id: \.self) { index in
                                Circle()
                                    .fill(index == currentPage ? Color.vetPrimary : Color.gray.opacity(0.3))
                                    .frame(
                                        width: index == currentPage ? 12 : 8,
                                        height: index == currentPage ? 12 : 8)
                                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: currentPage)
                            }
                        }
                        
                        // get started button
                        
                        if currentPage == onboardingPages.count - 1 {
                            GetStartedButton {
                                handleGetStarted()
                            }
                            .padding(.horizontal, VetSpacing.lg)
                            .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity), removal: .move(edge: .bottom).combined(with: .opacity)
                                                   ))
                        } else {
                            // next button
                            Button(action: {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    currentPage = min(onboardingPages.count - 1, currentPage + 1)
                                }
                            }) {
                                HStack(spacing: VetSpacing.sm) {
                                    Text("Next")
                                        .font(.vetLabelLarge)
                                        .fontWeight(.medium)
                                    
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .foregroundStyle(.primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(Color.vetPrimary.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: VetRadius.md))
                            }
                            .padding(.horizontal, VetSpacing.lg)
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity), removal: .move(edge: .bottom).combined(with: .opacity)
                            ))
                        }
                        //skip button
                        if currentPage < onboardingPages.count - 1 {
                            Button("Skip for now") {
                                handleSkip()
                            }
                            .font(.vetBodyMedium)
                            .foregroundStyle(.secondary)
                            .transition(.opacity)
                        }
                    }
                    .opacity(showGetStarted ? 1.0 : 0.0)
                    .offset(y: showGetStarted ? 0 : 30)
                    .animation(.easeOut(duration:0.8).delay(0.6), value: showGetStarted)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animateGradient = true
                showGetStarted = true
            }
        }
    }
}

// MARK: - Onboarding Data Model
struct OnboardingPage: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    //static data - all our onboarding pages
    static let allPages = [
        OnboardingPage(
                    icon: "heart.text.square.fill",
                    title: "Complete Medical Records",
                    description: "Keep track of your pet's health history, vaccinations, and treatments in one secure place.",
                    color: .vetPrimary
                ),
                OnboardingPage(
                    icon: "calendar.badge.plus",
                    title: "Smart Appointment Scheduling",
                    description: "Book appointments, receive reminders, and never miss important veterinary visits.",
                    color: .vetSecondary
                ),
                OnboardingPage(
                    icon: "bell.badge.fill",
                    title: "Intelligent Notifications",
                    description: "Get timely reminders for vaccinations, medications, and follow-up appointments.",
                    color: .vetAccent
                ),
                OnboardingPage(
                    icon: "icloud.and.arrow.up.fill",
                    title: "Sync Across All Devices",
                    description: "Access your pet's information on iPhone, iPad, Mac, and Apple Watch seamlessly.",
                    color: .vetInfo
            )
    ]
}

// MARK: - Vets4Pets Logo Component
struct Vets4PetsLogoView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.vetPrimary.opacity(0.2), .vetSecondary.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 120, height: 120)
            
            Image(systemName: "pawprint.fill")
                .font(.system(size: 50, weight: .medium))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.vetPrimary, .vetSecondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
        .vetElevation(.lg)
    }
}

// MARK: - Animated Gradient Background
struct AnimatedGradientBackground: View {
    @Binding var animate: Bool
    var body: some View {
        LinearGradient(
            colors: [Color.vetPrimary.opacity(animate ? 0.1:0.05),
                     Color.vetSecondary.opacity(animate ? 0.05:0.1),
                     Color.vetBackground],
            startPoint: animate ? .topLeading : .bottomTrailing,
            endPoint: animate ? .bottomTrailing : .topLeading
        )
        .animation(
            .easeInOut(duration: 4).repeatForever(autoreverses: true), value: animate
        )
    }
}

// MARK: - OnboardingCardView
struct OnboardingCardView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: VetSpacing.lg) {
            ZStack {
                Circle()
                    .fill(page.color.opacity(0.15))
                    .frame(width: 80, height: 80)
                
                Image(systemName: page.icon)
                    .font(.system(size: 35, weight: .medium))
                    .foregroundStyle(page.color)
            }
            VStack(spacing: VetSpacing.md) {
                Text(page.title)
                    .font(.vetHeadlineSmall)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text(page.description)
                    .font(.vetBodyLarge)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
        .padding(.horizontal, VetSpacing.xl)
    }
}

struct GetStartedButton: View {
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: VetSpacing.sm) {
                Text("Get Started")
                    .font(.vetLabelLarge)
                    .fontWeight(.semibold)
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    colors: [.vetPrimary, .vetSecondary],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: VetRadius.lg))
            .vetElevation(.md)
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { 
            isPressed = true
        } onPressingChanged: { pressing in
            isPressed = pressing
        }
    }
}

#Preview {
    WelcomeView()
}

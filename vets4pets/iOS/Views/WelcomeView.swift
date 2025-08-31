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
    
    var body: some View {
        VStack(spacing: 30){
            
            Vets4PetsLogoView()
            
            Text("Welcome to Vets4Pets!")
                .font(.largeTitle)
                .padding()
            
            Text("We have \(onboardingPages.count)")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            if onboardingPages.indices.contains(currentPage) {
                let page = onboardingPages[currentPage]
                VStack {
                    Image(systemName: page.icon)
                        .font(.system(size: 40))
                        .foregroundStyle(page.colour)
                    Text(page.title)
                        .font(.headline)
                    Text(page.description)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
            }
            HStack{
                Button("Previous"){
                    if currentPage > 0 {
                        currentPage -= 1
                    }
                }
                .disabled(currentPage == 0)
                
                Spacer()
                
                Text("Page \(currentPage + 1)")
                
                Spacer()
                
                Button("Next"){
                    if currentPage < onboardingPages.count - 1 {
                        currentPage += 1
                    }
                }
                .disabled(currentPage == onboardingPages.count - 1)
            }
            .padding()
        }
    }
}

// MARK: - Onboarding Data Model
struct OnboardingPage: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let colour: Color
    
    //static data - all our onboarding pages
    static let allPages = [
        OnboardingPage(
                    icon: "heart.text.square.fill",
                    title: "Complete Medical Records",
                    description: "Keep track of your pet's health history, vaccinations, and treatments in one secure place.",
                    colour: .vetPrimary
                ),
                OnboardingPage(
                    icon: "calendar.badge.plus",
                    title: "Smart Appointment Scheduling",
                    description: "Book appointments, receive reminders, and never miss important veterinary visits.",
                    colour: .vetSecondary
                ),
                OnboardingPage(
                    icon: "bell.badge.fill",
                    title: "Intelligent Notifications",
                    description: "Get timely reminders for vaccinations, medications, and follow-up appointments.",
                    colour: .vetAccent
                ),
                OnboardingPage(
                    icon: "icloud.and.arrow.up.fill",
                    title: "Sync Across All Devices",
                    description: "Access your pet's information on iPhone, iPad, Mac, and Apple Watch seamlessly.",
                    colour: .vetInfo
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

#Preview {
    WelcomeView()
}

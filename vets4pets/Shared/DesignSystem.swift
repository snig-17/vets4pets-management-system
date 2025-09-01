//
//  DesignSystem.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/09/2025.
//

import SwiftUI

extension Color {
    // MARK: - Primary Brand colors
    static let vetPrimary = Color.blue
    static let vetSecondary = Color.teal
    static let vetAccent = Color.red
    
    // MARK: - Semantic colors
    static let vetBackground = Color(UIColor.systemBackground)
    static let vetSurface = Color(UIColor.secondarySystemBackground)
    static let vetCardBackground = Color(UIColor.tertiarySystemBackground)
    
    // MARK: - Status colors
    static let vetSuccess = Color.green
    static let vetWarning = Color.orange
    static let vetError = Color.red
    static let vetInfo = Color.blue
    
    // MARK: - Pet Species colors
    static let dogColor = Color.brown
    static let catColor = Color.gray
    static let birdColor = Color.yellow
    static let rabbitColor = Color.pink
}

// MARK: - Typography System
extension Font {
    // MARK: - Display Fonts
    static let vetDisplayLarge = Font.custom("SF Pro Display", size: 57, relativeTo: .largeTitle).weight(.bold)
    static let vetDisplayMedium = Font.custom("SF Pro Display", size: 45, relativeTo: .largeTitle).weight(.semibold)
    static let vetDisplaySmall = Font.custom("SF Pro Display", size: 36, relativeTo: .title).weight(.medium)
    
    // MARK: - Headline Fonts
    static let vetHeadlineLarge = Font.custom("SF Pro Text", size: 32, relativeTo: .title).weight(.semibold)
    static let vetHeadlineMedium = Font.custom("SF Pro Text", size: 28, relativeTo: .title2).weight(.medium)
    static let vetHeadlineSmall = Font.custom("SF Pro Text", size: 24, relativeTo: .title3).weight(.medium)
    
    // MARK: - Body Fonts
    static let vetBodyLarge = Font.custom("SF Pro Text", size: 16, relativeTo: .body).weight(.regular)
    static let vetBodyMedium = Font.custom("SF Pro Text", size: 14, relativeTo: .callout).weight(.regular)
    static let vetBodySmall = Font.custom("SF Pro Text", size: 12, relativeTo: .caption).weight(.regular)
    
    // MARK: - Label Fonts
    static let vetLabelLarge = Font.custom("SF Pro Text", size: 14, relativeTo: .callout).weight(.medium)
    static let vetLabelMedium = Font.custom("SF Pro Text", size: 12, relativeTo: .caption).weight(.medium)
    static let vetLabelSmall = Font.custom("SF Pro Text", size: 11, relativeTo: .caption2).weight(.medium)
}
    // MARK: - Spacing System
    enum VetSpacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
        static let xxxl: CGFloat = 64
}
    
    // MARK: - Corner Radius System
    enum VetRadius {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let pill: CGFloat = 1000
        
}
    
    // MARK: - Elevation/Shadow System
extension View {
        func vetElevation(_ level: VetElevation) -> some View {
            self.shadow(
                color: level.color,
                radius: level.radius,
                x: level.x,
                y: level.y
            )
        }
}
enum VetElevation {
    case none, sm, md, lg, xl
        
    var color: Color {
            Color.black.opacity(0.1)
    }
        
        var radius: CGFloat {
            switch self {
            case .none: return 0
            case .sm: return 2
            case .md: return 4
            case .lg: return 8
            case .xl: return 16
            }
        }
        
        var x: CGFloat { 0 }
        
        var y: CGFloat {
            switch self {
            case .none: return 0
            case .sm: return 1
            case .md: return 2
            case .lg: return 4
            case .xl: return 8
            }
        }
}


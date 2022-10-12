//
//  OnboardingView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/11.
//
import SwiftUI


struct OnboardingView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
            FirstPageView()
            
            OnboardingLastPageView(
                imageName: "eyes",
                title: "끝",
                subtitle: "dq",
                isFirstLaunching: $isFirstLaunching
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

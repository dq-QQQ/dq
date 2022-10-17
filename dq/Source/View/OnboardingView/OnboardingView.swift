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
            
            SecondPageView()
            
            OnboardingLastPageView(
                isFirstLaunching: $isFirstLaunching
            )
        }
        .background(Color.dqGreen)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}


struct ho: View {
    var body: some View {
        Text("ho")
    }
}

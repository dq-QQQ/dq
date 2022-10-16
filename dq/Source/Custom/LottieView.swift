//
//  LottieView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/16.
//

import Lottie
import SwiftUI
import UIKit

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var filename: String
    var speed: Int?
    var loop: Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.animation = Animation.named(filename)
        animationView.contentMode = .scaleAspectFit
        if loop == true {
            animationView.loopMode = .loop
        } else {
            animationView.loopMode = .playOnce
        }
        animationView.play()
        if let s = speed {
            animationView.animationSpeed = CGFloat(s)
        }
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        // do nothing
    }
    
}

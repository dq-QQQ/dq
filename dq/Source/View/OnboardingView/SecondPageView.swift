//
//  FirstPageView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/11.
//

import SwiftUI

public struct SecondPageView: View {
    @State private var angle: Angle = .zero
    @State var appear = false
    let words: [String]
    
    public init() {
        self.words = "42Seoul,SAFFY,우아한 테크 코스, 코드스타터캠프, SOPT, DDD, 커리어스타터캠프,sadf,afdadsf,asdfsadf,sd,sadf,sadf,asdf,sdf,dfasd,vads,vdsf,ef,ewf,wef,dsf,asdva,sdv,feqw,rwe,rwe,fd,fdas,feqwr,wer,g,fg,f,sdaf,asf,qewfr,wer,wer".components(separatedBy: ",")
    }
    
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                let midX = Int(proxy.size.width / 4)
                let midY = Int(proxy.size.height / 4)
                ZStack {
                    Color.clear
                    ZStack {
                        Color.clear
                        ForEach(Array(self.words.enumerated()), id: \.offset) { index, word in
                                let opacity = CGFloat.random(in: 0.5...1.0)
                                RowView(word: word, width: CGFloat(min(midX, midY)))
                                    .frame(width: min(proxy.size.width, proxy.size.height))
                                    .foregroundColor(.dqGray)
                                    .rotationEffect(Angle(degrees: CGFloat(Int.random(in: 0...360))))
                                    .offset(x: CGFloat(Int.random(in: -midX...midX)),
                                            y: CGFloat(Int.random(in: -midY...midY)))
                                    .scaleEffect(index%2 == 0 ? opacity * 3.0 : opacity * 6.0)
                                    .opacity(opacity)
                        }
                        .rotationEffect(angle)
                        VStack(alignment: .center) {
                            Text("부트캠프")
                                .font(.dqBigSmallFont)
                                .foregroundColor(.dqWhite)
                                .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 0)
                                .transition(.move(edge: .top))
                                
                            Text("&")
                                .font(.dqMediumBigFont)
                                .foregroundColor(.dqWhite)
                                .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 0)
                            
                            Text("동아리")
                            .font(.dqBigSmallFont)
                            .foregroundColor(.dqWhite)
                            .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 0)
                        }
                        .scaleEffect(appear == false ? CGFloat(0) : CGFloat(3))
                        .animation(.easeInOut(duration: 3), value: appear)
                        
                        }
                }
            }
        }
        .contentShape(Rectangle())
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0)) {
                angle = Angle(degrees: CGFloat(Int.random(in: 0...360)))
            }
            appear = true
        }
        .onDisappear {
            appear = false
        }
        .padding()
    }
    

}

fileprivate
struct RowView: View {
    let word: String
    let width: CGFloat
    var body: some View {
        HStack {
            Text(word)
                .font(.caption)
                .fontWeight(.bold)
                .fixedSize()
            Rectangle()
                .frame(width: width, height: 1)
            Circle()
                .frame(width: 5, height: 5)
                .offset(x: -3)
            Spacer()
        }
    }
}

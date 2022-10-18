//
//  HomeView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI
import Firebase

struct HomeView: View {
    var fbBootcamp: FirebaseBootcamp
    var fbClub: FirebaseClub
    @EnvironmentObject private var viewModel: ViewModel
    @ObservedObject var ho: MainViewHandler
    @Binding var isFirstLaunching: Bool
    
    @Environment(\.openURL) var openURL
    var email = SupportEmail(toAddress: "42.4.kyujlee@gmail.com",
                                     subject: "Support Email",
                                     messageHeader: "이슈를 설명해주세요")
    
    @State var getID = false
    
    var body: some View {
        ScrollView {
            Block(title: "관심있어요!", flag: 0, fbBootcamp: fbBootcamp)
            
            spacer
            
            Block(title: "지원기간이 얼마 안남았어요!", flag: 1, fbBootcamp: fbBootcamp)
            
            spacer
            spacer
            

            HStack(spacing: 20) {
                Button {
                    isFirstLaunching = true
                } label: {
                    HStack {
                        Text("dq")
                            .font(.dqMediumLogoFont)
                    }
                }
                
                Link(destination: URL(string: "https://github.com/dq-QQQ")!) {
                    MyAsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/dqapp-d00bb.appspot.com/o/github.png?alt=media&token=9e3bd493-e1c1-40e7-92ca-cf0185129de6")){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 30, height: 30)
                }
                
                Button {
                    email.send(openURL: openURL)
                } label: {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.dqGreen)
                }
            }
            
            Text("Q")
                .foregroundColor(Color.secondary)
                .onLongPressGesture(minimumDuration: 7) {
                    getID = true
                }
            if getID == true {
            Text("")
                    .alert("UUID", isPresented: $getID, actions: {
                        Button("Copy") {
                            UIPasteboard.general.string =  UIDevice.current.identifierForVendor!.uuidString
                        }

                    }){
                        Text(UIDevice.current.identifierForVendor!.uuidString)
                            .textSelection(.enabled)
                    }
            }
        }
        
    }
}

extension HomeView {
    var spacer: some View {
        Spacer().frame(height: viewModel.getPhoneSize().height / 15)
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(fbBootcamp: fbBootcamp("BootCamp"),
//                 clubViewModel: ClubViewModel("Club"))
//            .environmentObject(ViewModel())
//    }
//}


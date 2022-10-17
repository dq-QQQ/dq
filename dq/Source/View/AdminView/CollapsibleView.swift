//
//  ChildView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/16.
//

import SwiftUI


struct CollapsibleView<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    @Binding var bootcampList: [BootcampModel]
    var fbBootcamp: FirebaseBootcamp
    
    @State var date = Date()
    
    var flag: (tabFlag: Int, ListFlag: Int)
    
    @Binding var values: (info: [String: String], date: Date)
    
    var body: some View {
        VStack {
            HStack {
                Button(
                    action: { withAnimation(.easeOut) {
                        self.collapsed.toggle()
                    } },
                    label: {
                        self.label()
                        
                            .padding(.bottom, 1)
                            .background(Color.white.opacity(0.01))
                    }
                )
                .buttonStyle(PlainButtonStyle())
                Spacer()
                if flag.ListFlag == 0 {
                    DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }
                Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
            }
            
            VStack {
                if flag.ListFlag == 0 || flag.ListFlag == 2{
                    ForEach(bootcampList) { bootcamp in
                        HStack {
                            Text(bootcamp.name)
                            Spacer()
                            Button {
                                if flag.ListFlag == 0 {
                                    fbBootcamp.updateFireStore(data: bootcamp, date: date)
                                } else if flag.ListFlag == 2 {
                                    fbBootcamp.deleteFireStore(data: bootcamp)
                                }
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding()
                        .foregroundColor(.dqGreen)
                    }
                } else if flag.ListFlag == 1 {
                    self.content()
                    Button {
                        Task { await fbBootcamp.newBootcamp(values: values) }
                    } label: {
                        Text("Push")
                            .font(.dqBigFont)
                            .foregroundColor(.dqWhite)
                            .background(Color.dqGreen)
                            .cornerRadius(6)
                    }

                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .transition(.slide)
            .padding(.horizontal)
        }
    }
}

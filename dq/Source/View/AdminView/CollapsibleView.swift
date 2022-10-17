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
    
    @Binding var date: Date
    
    var flag: (tabFlag: Int, ListFlag: Int)
    
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
                if flag.ListFlag == 0 {
                    DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }
                Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
            }
            
            VStack(alignment: .leading) {
                if flag.ListFlag == 0 {
                    ForEach(bootcampList) { bootcamp in
                        HStack {
                            Text(bootcamp.name)
                            Spacer()
                            Button {
                                fbBootcamp.updateFireStore(data: bootcamp, date: date)
                            } label: {
                                Image(systemName: "arrow.up.doc")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding()
                        .foregroundColor(.dqGreen)
                    }
                } else if flag.ListFlag == 1 {
                    self.content()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .transition(.slide)
            .padding(.horizontal)
        }
    }
}

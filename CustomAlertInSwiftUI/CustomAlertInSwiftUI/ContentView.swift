//
//  ContentView.swift
//  CustomAlertInSwiftUI
//
//  Created by SHUBHAM AGARWAL on 16/01/21.
//

import SwiftUI
struct ContentView: View {
    
    @State var shown = false
    @State var message = ""
    @State var c: AlertAction?
    @State var isSuccess = false
    @State var showGreeting = true
    @State var checkState:Bool = false ;
    @State var checked = false
    @State private var isOn = false
    @State var cartview = false
    @State var ttsview1 = false
    @State var isNavigationBarHidden: Bool = true
    var body: some View {
    
        ZStack {
        
                VStack {
                    if checked{
                        Charts(viewModel: CalendarView.Coordinator())
                    }else{
                        if cartview {
                            HomeView(viewModel: HomeViewModel())
                        }else if ttsview1{
                            ttsview()
                        }
                        else{
                            NavigationView{
                                VStack(alignment: .center){
                                    VStack() {
                                        Image("demo")
                                            .resizable().frame(width: 300, height: 200)
                                        Button("Success Alert") {
                                            isSuccess = true
                                            message = "커스텀 Alert창 입니다"
                                            shown.toggle()
                                        }
                                        
                                        Button("Failure Alert") {
                                            isSuccess = false
                                            message = "커스텀 에러 Alert"
                                            shown.toggle()
                                            
                                        }
                                        Text(c == .ok ? "확인" : c == .cancel ? "닫기" : "")
                                        Toggle("Show welcome message", isOn: $showGreeting)
                                                       .toggleStyle(SwitchToggleStyle(tint: .red))
                                        
                                        if #available(iOS 15.0, *) {
                                            Toggle("Filter", isOn: $isOn)
                                                .toggleStyle(.button)
                                                .tint(.mint)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                        
                                        Button(action:
                                                    {
                                                        //1. Save state
                                                        self.checkState = !self.checkState
                                                        print("State : \(self.checkState)")


                                                }) {
                                                    HStack(alignment: .top, spacing: 5) {

                                                                //2. Will update according to state
                                                           Rectangle()
                                                                    .fill(self.checkState ? Color.green : Color.red)
                                                                    .frame(width:20, height:20, alignment: .center)
                                                                    .cornerRadius(5)

                                                        Text("Todo  item ").foregroundColor(Color.black)

                                                    }
                                                }
                                    }
                                }
                                .navigationTitle("")
                                .navigationBarHidden(true)
                            }
                        }

                        
                    }
                    HStack{
                        Button(action: {
                            checked.toggle()
                        }) {
                            Image(checked ? "check" :  "check-1")
                                .renderingMode(.original)
                                .resizable()
                                .padding(0)
                                .frame(width: 14.0, height: 14.0)
                                .background(Color.white)
                            Text("Chartview").padding(0)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.02))
                        .cornerRadius(0)
                        Button(action: {
                            cartview    .toggle()
                        }) {Text("화면전환")}
                        Button(action: {
                            ttsview1    .toggle()
                        }) {Text("화면전환2")}
                    }
                  
                }.blur(radius: shown ? 30 : 0)
            
            if shown {
                AlertView(shown: $shown, closureA: $c, isSuccess: isSuccess, message: message)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

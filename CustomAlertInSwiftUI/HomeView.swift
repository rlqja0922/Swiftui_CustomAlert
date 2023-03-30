//
//  HomeView.swift
//  CalendarDemo
//
//  Created by Dmitrijs Beloborodovs on 31/05/2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var birthDate = Date()
    @State private var name = "text"
    @State private var name2 = "textfield"
    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return formatter
       }
    var body: some View {
        NavigationView {
            VStack {
                CalendarView2(calendar: viewModel.calendar,
                             isCalendarExpanded: $viewModel.isCalendarExpanded)
                    .frame(maxWidth: .infinity)
                    .frame(height: viewModel.calendarHeight)
                TextField("텍스트를 입력해주세요", text: $name,onCommit: {
                    name2 = name
                    print("\(name) retun눌렀다!!!")
                })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textCase(.lowercase)
                            .padding(.horizontal)

                //           .textCase(.lowercase) - 소문자
//                            .textCase(.uppercase) - 대문자
//                            .textCase(.none) - 사용자 지정
                Spacer()
                VStack {
                    
                    Text(name2)
                    DatePicker("날짜선택",selection: $birthDate, in: ...Date(),displayedComponents: [.date, .hourAndMinute])
                        .foregroundColor(.blue)
                            .accentColor(.blue)
                            .border(Color.black)
                            .foregroundColor(.red)
                            .background(Color.orange)
                 
                    Text("Date is \(birthDate, formatter: dateFormatter)")
                        }
                        .padding()
                        .onTapGesture {
                            hideKeyboard()
                        }
                
                Text(viewModel.selectedDate)
                    .padding()
            }
            .onChange(of: name) { value in
                       print("dd")
                   }
            //.onSubmit {  //ios15이후부터만가능
            //print("\(name)")
            //}                            .onReceive(self.name.publisher ,perform: { _ in print(selfname+"receive")})
            //  .onChange(of: name){
            //   print("onchange")
            //   }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            viewModel.isCalendarExpanded.toggle()
                        }
                    }, label: {
                        Image(systemName: "list.bullet.below.rectangle")
                    })
                }
            }
            .navigationTitle("Calendar demo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
      
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
      return true
    }
}

#endif

#if DEBUG

private final class MockedViewModel: HomeViewModel {
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

#endif

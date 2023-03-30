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
    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return formatter
       }
    var body: some View {
        NavigationView {
            VStack {
                CalendarView(calendar: viewModel.calendar,
                             isCalendarExpanded: $viewModel.isCalendarExpanded)
                    .frame(maxWidth: .infinity)
                    .frame(height: viewModel.calendarHeight)
                
                Spacer()
                VStack {
                            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                                Text("날짜를 선택하세요")
                            }
                 
                            Text("Date is \(birthDate, formatter: dateFormatter)")
                        }
                        .padding()
                
                Text(viewModel.selectedDate)
                    .padding()
            }
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

#if DEBUG

private final class MockedViewModel: HomeViewModel {
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

#endif

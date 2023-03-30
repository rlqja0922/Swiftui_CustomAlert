//
//  CalendarRepresentable.swift
//  CalendarDemo
//
//  Created by Dmitrijs Beloborodovs on 31/05/2021.
//

import SwiftUI
import FSCalendar
import Foundation

struct CalendarView: UIViewRepresentable {
    
  typealias UIViewType = FSCalendar
    var calendar = FSCalendar()
    @Binding var isCalendarExpanded: Bool
    
    func makeUIView(context: Context) -> FSCalendar {
      

          // 헤더의 날짜 포맷 설정
          calendar.appearance.headerDateFormat = "YYYY년 MM월"

          // 헤더의 폰트 색상 설정
          calendar.appearance.headerTitleColor = UIColor.link

          // 헤더의 폰트 정렬 설정
          // .center & .left & .justified & .natural & .right
          calendar.appearance.headerTitleAlignment = .left

          // 헤더 높이 설정
          calendar.headerHeight = 45

          // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
          calendar.appearance.headerMinimumDissolvedAlpha = 0.0   // 0.0 = 안보이게 됩니다.
          
          // 1번째 방법 (추천)
    //      calendar.locale = Locale(identifier: "ko_KR")

    //      // 2번째 방법
          calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
          calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
          calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
          calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
          calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
          calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
          calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        let scope: FSCalendarScope = isCalendarExpanded ? .month : .week
        uiView.setScope(scope, animated: false)
    }
}

import SwiftUI
import Charts
import FSCalendar
import Foundation

struct Charts: View {
    @ObservedObject var viewModel: CalendarView.Coordinator
    @State static var texts = "D"
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    let entries1 = [
        ChartDataEntry(x: 1, y: 1),
        ChartDataEntry(x: 2, y: 2),
        ChartDataEntry(x: 3, y: 0),
        ChartDataEntry(x: 4, y: 0),
        ChartDataEntry(x: 5, y: 0),
        ChartDataEntry(x: 6, y: 0),
        ChartDataEntry(x: 7, y: 1),
        
    ]
    let entries2 = [
        ChartDataEntry(x: 1, y: 2),
        ChartDataEntry(x: 3, y: 0),
        ChartDataEntry(x: 4, y: 0),
        ChartDataEntry(x: 5, y: 0),
        ChartDataEntry(x: 6, y: 0),
        ChartDataEntry(x: 7, y: 2)
    ]
    var body: some View {
        VStack{
            Spacer()
            MultiLineChartView(entries1: entries1, entries2: entries2, days: days)
            .frame(height: 220)
            Spacer()
            Text(Charts.texts).foregroundColor(Color.black)
            CalendarView()
            
        }
    }
}

struct CalendarView: UIViewRepresentable {
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        
    }
    
  typealias UIViewType = FSCalendar
    var calendar = FSCalendar()
    
  func makeUIView(context: Context) -> FSCalendar {
    
    calendar.delegate = context.coordinator
    calendar.dataSource = context.coordinator
      
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


  class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource,ObservableObject {
      
      @Published var selectedDate: String = "날짜"
      @Published var text: String = "날짜"
      
      func calendar(_ calendar: FSCalendar,
                    didSelect date: Date,
                    at monthPosition: FSCalendarMonthPosition) {
          dateSelected(date)
      }
      func dateSelected(_ date: Date) {
          DispatchQueue.main.async { [weak self] in
              guard let self = self else { return }

              self.selectedDate = date.description
              self.text = date.description
              Charts.texts = date.description
          }
      }
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator()
  }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        Charts(viewModel: CalendarView.Coordinator())
    }
}

struct MultiLineChartView : UIViewRepresentable {
    
    var entries1 : [ChartDataEntry]
    var entries2 : [ChartDataEntry]
    var days: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        return createChart(chart: chart)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
    }
    
    func createChart(chart: LineChartView) -> LineChartView{
        chart.chartDescription?.enabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawLabelsEnabled = true
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.drawBordersEnabled = false
        chart.legend.form = .none
        chart.xAxis.labelCount = 7
        chart.xAxis.forceLabelsEnabled = true
        chart.xAxis.granularityEnabled = true
        chart.xAxis.granularity = 1
        chart.xAxis.valueFormatter = CustomChartFormatter(days: days)
        
        chart.data = addData()
        return chart
    }
    
    func addData() -> LineChartData{
        let data = LineChartData(dataSets: [
            //Schedule Trips Line
            generateLineChartDataSet(dataSetEntries: entries1, color: UIColor(Color(#colorLiteral(red: 0.6235294118, green: 0.7333333333, blue: 0.3568627451, alpha: 1))), fillColor: UIColor(Color.white)),
            //Unloadings Line
            generateLineChartDataSet(dataSetEntries: entries2, color: UIColor(Color(#colorLiteral(red: 0.003921568627, green: 0.231372549, blue: 0.431372549, alpha: 1))), fillColor: UIColor(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))))
        ])
        return data
    }
    
    func generateLineChartDataSet(dataSetEntries: [ChartDataEntry], color: UIColor, fillColor: UIColor) -> LineChartDataSet{
        let dataSet = LineChartDataSet(entries: dataSetEntries, label: "")
        dataSet.colors = [color]
        dataSet.mode = .linear
        dataSet.circleRadius = 5 //0
        dataSet.circleHoleColor = UIColor(Color(#colorLiteral(red: 0.003921568627, green: 0.231372549, blue: 0.431372549, alpha: 1)))
        dataSet.fill = Fill.fillWithColor(fillColor)
        dataSet.drawFilledEnabled = true
        dataSet.setCircleColor(UIColor.clear)
        dataSet.lineWidth = 2 //0
        dataSet.valueTextColor = color
        dataSet.valueFont = UIFont(name: "Avenir", size: 12)! //0 주석처리 해둔것들 0으로 처리시 안보이는 그래프 생성됨
        return dataSet
    }
    
}

class CustomChartFormatter: NSObject, IAxisValueFormatter {
    var days: [String]
    
    init(days: [String]) {
        self.days = days
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return days[Int(value-1)]
    }
}

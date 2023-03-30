//
//  CustomAlert.swift
//  CustomAlertInSwiftUI
//
//  Created by SHUBHAM AGARWAL on 16/01/21.
//

import SwiftUI

enum AlertAction {
    case ok
    case cancel
    case others
}

struct AlertView: View {
    
    @Binding var shown: Bool
    @Binding var closureA: AlertAction?
    var isSuccess: Bool //true : 버튼 2개 , false : 1개
    var message: String
    
    var body: some View {
        VStack {
            
            Spacer()
            Text(message).foregroundColor(Color.black)
            Spacer()
            HStack {
                if isSuccess {
                    Button("취소") {
                        closureA = .cancel
                        shown.toggle()
                    }.frame(width: UIScreen.main.bounds.width/3, height: 40)
                    .foregroundColor(.white)
                    .background(Color("shape"))
                    .cornerRadius(20)
                    
                    Button("확인") {
                        closureA = .ok
                        shown.toggle()
                    }.frame(width: UIScreen.main.bounds.width/3, height: 40)
                    .foregroundColor(.white)
                    .background(Color("detailblue"))
                    .cornerRadius(20)
                }else {
                    
                    Button("확인") {
                        closureA = .others
                        shown.toggle()
                    }.frame(width: UIScreen.main.bounds.width/3, height: 40)
                    .foregroundColor(.white)
                    .background(Color("detailblue"))
                    .cornerRadius(20)
                }
             
                
            }
            HStack{}.frame(width: UIScreen.main.bounds.width/3, height: 10)
        }
        .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.height/4)
        
        .background(Color.white)
        .clipped()
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color("shape"), lineWidth: 1)
        )
    }
}

struct CustomAlert_Previews: PreviewProvider {
    
    static var previews: some View {
        AlertView(shown: .constant(false), closureA: .constant(.others), isSuccess: false, message: "")
    }
}

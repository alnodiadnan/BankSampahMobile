//
//  EducationQuiz.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 09/07/21.
//

import SwiftUI

struct EducationQuiz: View {
    let questionList : [String] = ["Sampah manakah yang dapat di daur ulang menjadi produk komersil?", "Jenis sampah manakah yang tepat?", "Sampah manakah yang termasuk sampah organik?", "Sampah manakah yang termasuk sampah anorganik?", "Sampah manakah yang termasuk sampah bahan berbahaya dan beracun?"]
    
    let answerList : [String] = ["D", "A", "B", "A", "A"]
    //var optionList : [[String]] = [["Answer0-0", "Answer0-1", "Answer0-2", "Answer0-3"]]
    
    @State var questionCounter : Int = 0
    @State var trueCount : Int = 0
    @State var falseCount : Int = 0
    @State var userAnswer : String = ""
    
    @State var showingResultPage : Bool = false
    
    @Binding var isShowingQuiz : Bool
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            NavigationLink(destination: EducationQuizResult(trueCount: $trueCount, falseCount: $falseCount, isShowingQuiz: $isShowingQuiz), isActive: $showingResultPage) {
                EmptyView()
            }
            
            VStack(spacing: 30) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.init(hex: "fe565e"))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                        .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    VStack {
                        Text("\(questionList[questionCounter])")
                            .fontWeight(.heavy)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .frame(maxWidth: ScreenSize.width * 0.75)
                            .padding(.top, 20)
                        
                        HStack {
                            Image("QuizLogo")
                                .resizable()
                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.trailing, 30)
                            
                            Image("TrueLogo")
                                .resizable()
                                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Text("\(trueCount)")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            
                            Image("FalseLogo")
                                .resizable()
                                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.leading, 30)
                            
                            Text("\(falseCount)")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 15)
                        .padding(.trailing, 30)
                    }
                    
                    
                }
                
                VStack(spacing: 20) {
                    HStack(spacing: 20){
                        Button(action: {
                            self.userAnswer = "A"
                            
                            if userAnswer == answerList[questionCounter] {
                                self.trueCount += 1
                            }
                            else {
                                self.falseCount += 1
                            }
                            
                            if questionCounter < questionList.count-1 {
                                self.questionCounter += 1
                            }
                            else if questionCounter == questionList.count-1 {
                                self.showingResultPage.toggle()
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color.init(hex: "3ED598"))
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image("Answer\(questionCounter)-0")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        
                        Button(action: {
                            self.userAnswer = "B"
                            
                            if userAnswer == answerList[questionCounter] {
                                self.trueCount += 1
                            }
                            else {
                                self.falseCount += 1
                            }
                            
                            if questionCounter < questionList.count-1 {
                                self.questionCounter += 1
                            }
                            else if questionCounter == questionList.count-1 {
                                self.showingResultPage.toggle()
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color.init(hex: "3ED598"))
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image("Answer\(questionCounter)-1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        
                    }
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            self.userAnswer = "C"
                            
                            if userAnswer == answerList[questionCounter] {
                                self.trueCount += 1
                            }
                            else {
                                self.falseCount += 1
                            }
                            
                            if questionCounter < questionList.count-1 {
                                self.questionCounter += 1
                            }
                            else if questionCounter == questionList.count-1 {
                                self.showingResultPage.toggle()
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color.init(hex: "3ED598"))
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image("Answer\(questionCounter)-2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        
                        Button(action: {
                            self.userAnswer = "D"
                            
                            if userAnswer == answerList[questionCounter] {
                                self.trueCount += 1
                            }
                            else {
                                self.falseCount += 1
                            }
                            
                            if questionCounter < questionList.count-1 {
                                self.questionCounter += 1
                            }
                            else if questionCounter == questionList.count-1 {
                                self.showingResultPage.toggle()
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color.init(hex: "3ED598"))
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image("Answer\(questionCounter)-3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        
                    }
                }
                
                
                
//                Button(action: {
//                    if questionCounter < questionList.count-1 {
//                        self.questionCounter += 1
//                    }
//
//                }) {
//                    Text("Next")
//                }
                
                Spacer()
            }
            
        }
    }
    
}

struct EducationQuiz_Previews: PreviewProvider {
    static var previews: some View {
        EducationQuiz(isShowingQuiz: .constant(true))
    }
}

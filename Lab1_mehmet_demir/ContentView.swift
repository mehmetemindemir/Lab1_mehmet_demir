

import SwiftUI
internal import Combine

struct ContentView: View {
    @State private var currentNumber: Int = Int.random(in: 1...100)
    @State private var timeRemaining: Int = 5
    @State private var showResultIcon: String? = nil
    @State private var showResultColor: Color = .clear
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    @State private var userAnswered: Bool = false
    @State private var totalAttempts: Int = 0
    @State private var showDialog: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing:40){
            Spacer()
            // Number Display
            Text("\(currentNumber)")
            .font(.system(size: 70, weight: .bold))
            .foregroundColor(.black)
        
            // Timer Display
            Text("Time Left: \(timeRemaining)")
            .font(.headline)
            .foregroundColor(.black)
            
            // Prime Button
            Button(action: {
                checkAnswer(userChoiceIsPrime:true)
            }) {
                Text("Prime")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Not Prime Button
            Button(action: {
                checkAnswer(userChoiceIsPrime: false)
            }) {
                Text("Not Prime")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Result Icon
            if let icon = showResultIcon {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(showResultColor)
                    .transition(.scale)
            }
            Spacer()
            // Score Display
              HStack {
                  Text("Correct: \(correctCount)")
                      .foregroundColor(.green)
                  Spacer()
                  Text("Wrong: \(wrongCount)")
                      .foregroundColor(.red)
              }.padding()
        } .onReceive(timer) { _ in
            print("timer: ",timeRemaining)
            handleTimerTick()
        }.alert("Game Summary", isPresented: $showDialog) {
            Button("Continue") {
               print("reset game")
            }
        } message: {
            Text("After 10 attempts:\n\nCorrect: \(correctCount)\nWrong: \(wrongCount)")
        }
    }
    func isPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        
        for i in 2...Int(Double(number).squareRoot()) {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
    func checkAnswer(userChoiceIsPrime: Bool) {
        guard !userAnswered else { return }
        userAnswered = true
        let correctAnswer = isPrime(currentNumber)
        if userChoiceIsPrime == correctAnswer {
            correctCount += 1
            showResultIcon = "checkmark.circle.fill"
            showResultColor = .green
        } else {
            wrongCount += 1
            showResultIcon = "xmark.circle.fill"
            showResultColor = .red
        }
        totalAttempts += 1
               
       DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           proceedToNextRound()
       }
           
    }
    func proceedToNextRound() {
        if totalAttempts % 10 == 0 {
            print("After 10 attempts:\n\nCorrect: \(correctCount)\nWrong: \(wrongCount)")
            
            
        }
    
        currentNumber = Int.random(in: 1...100)
        timeRemaining = 5
        showResultIcon = nil
        userAnswered = false
    }
    func handleTimerTick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            if !userAnswered {
                wrongCount += 1
                totalAttempts += 1
                showResultIcon = "xmark.circle.fill"
                showResultColor = .red
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                proceedToNextRound()
            }
        }
    }
}

#Preview {
    ContentView()
}

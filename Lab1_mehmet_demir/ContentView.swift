

import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Int = Int.random(in: 1...100)
    @State private var timeRemaining: Int = 5
    
    var body: some View {
        VStack(spacing:40){
            Spacer()
            // Number Display
            Text("\(currentNumber)")
            .font(.system(size: 70, weight: .bold))
            .foregroundColor(.teal)
        
            // Timer Display
            Text("Time Left: \(timeRemaining)")
            .font(.headline)
            .foregroundColor(.gray)
            
            // Prime Button
            Button(action: {
                
            }) {
                Text("Prime")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}

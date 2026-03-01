

import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Int = Int.random(in: 1...100)
    @State private var timeRemaining: Int = 5
    @State private var showResultIcon: String? = nil
    @State private var showResultColor: Color = .clear
    
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
            
            // Not Prime Button
            Button(action: {
            }) {
                Text("Not Prime")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
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
        }
    }
}

#Preview {
    ContentView()
}

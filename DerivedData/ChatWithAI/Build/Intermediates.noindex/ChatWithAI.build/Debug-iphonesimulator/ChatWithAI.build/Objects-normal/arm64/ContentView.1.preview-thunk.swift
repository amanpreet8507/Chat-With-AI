import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/amanpreeetsandhu/Desktop/iOS Mobile Application Programming/ChatWithAI/ChatWithAI/ContentView.swift", line: 1)
//
//  ContentView.swift
//  ChatWithAI
//
//  Created by Amanpreeet Sandhu on 2025-03-03.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    let model = GenerativeModel(name: "gemini-1.5-pro", apiKey: APIKey.default)
    @State var userPrompt = ""
    @State var response: LocalizedStringKey = "How can I help you today?"
    @State var isLoading = false
    
    var body: some View {
        VStack {
            Text(__designTimeString("#6838_0", fallback: "Welcome to Gemini AI"))
                .font(.largeTitle)
                .foregroundStyle(.indigo)
                .fontWeight(.bold)
                .padding(.top, __designTimeInteger("#6838_1", fallback: 40))
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title)
                }
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(__designTimeInteger("#6838_2", fallback: 4))
                }
                
            }
            
            TextField(__designTimeString("#6838_3", fallback: "Ask anything..."), text: $userPrompt, axis: .vertical)
                .lineLimit(__designTimeInteger("#6838_4", fallback: 5))
                .font(.title3)
                .padding()
                .background(Color.indigo.opacity(__designTimeFloat("#6838_5", fallback: 0.3)), in: Capsule())
                .disableAutocorrection(__designTimeBoolean("#6838_6", fallback: true))
                .onSubmit {
                    generateResponse()
                }
            
                
        }
        .padding()
    }
    
    func generateResponse(){
        isLoading = __designTimeBoolean("#6838_7", fallback: true);
        response = __designTimeString("#6838_8", fallback: "")
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = __designTimeBoolean("#6838_9", fallback: false)
                response = LocalizedStringKey(result.text ?? __designTimeString("#6838_10", fallback: "No response found"))
                userPrompt = __designTimeString("#6838_11", fallback: "")
            } catch {
                print(__designTimeString("#6838_12", fallback: "API Call Failed! Error:"), error) // Print full error object
                print(__designTimeString("#6838_13", fallback: "Localized Description:"), error.localizedDescription) // Print readable message
                response = "Something went wrong! \n\(error.localizedDescription)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}


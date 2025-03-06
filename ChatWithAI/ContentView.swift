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
            Text("Welcome to Gemini AI")
                .font(.largeTitle)
                .foregroundStyle(.indigo)
                .fontWeight(.bold)
                .padding(.top, 40)
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title)
                }
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(4)
                }
                
            }
            
            TextField("Ask anything...", text: $userPrompt, axis: .vertical)
                .lineLimit(5)
                .font(.title3)
                .padding()
                .background(Color.indigo.opacity(0.3), in: Capsule())
                .disableAutocorrection(true)
                .onSubmit {
                    generateResponse()
                }
            
                
        }
        .padding()
    }
    
    func generateResponse(){
        isLoading = true;
        response = ""
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No response found")
                userPrompt = ""
            } catch {
                print("API Call Failed! Error:", error) // Print full error object
                print("Localized Description:", error.localizedDescription) // Print readable message
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


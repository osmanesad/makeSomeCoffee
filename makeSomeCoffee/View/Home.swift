//
//  Home.swift
//  makeSomeCoffee
//
//  Created by Osman Esad on 1.02.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Home: View {
    @State private var quizInfo: Info?
    @AppStorage("log_status") private var logStatus: Bool = false
    @State private var questions: [Question] = []
    var body: some View {
        
        if let info = quizInfo {
            VStack(spacing: 10){
                Text(info.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .halign(.leading)
                
                CustomLabel("list.bullet.rectangle.potrait", "\(questions.count)", "Çoktan seçmeli sorular.")
                    .padding(.top, 20)
                CustomLabel("person", "\(info.peopleAttended)", "Sorulara katıldı.")
                    .padding(.top, 5)
                
                Divider()
                    .padding(.horizontal, -15)
                    .padding(.top, 15)
                
                if !info.rules.isEmpty {
                    RulesView(info.rules)
                    
                }
            }
            .padding(15)
            .valign(.top)
            
        } else {
            VStack(spacing: 4){
                ProgressView()
                Text("Lütfen Bekleyin...")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .task {
                do {
                   try await fetchData()
                } catch {
                    print("Hata mesajı: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    @ViewBuilder
    func RulesView(_ rules: [String])->some View {
        VStack(alignment: .leading, spacing: 15){
            Text("Başlamadan önce açıklamaları okuyun.")
                .font(.title3)
                .fontWeight(.bold)
            
            ForEach(rules, id: \.self){rule in
                HStack(alignment: .top, spacing: 10){
                    Circle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                    Text(rule)
                        .font(.callout)
                        .lineLimit(3)
                    
                }
                
            }
        }
    }
    
    @ViewBuilder
    func CustomLabel(_ image: String, _ title: String, _ subTitle: String) -> some View {
        HStack(spacing: 12){
            Image(systemName: image)
                .font(.title3)
                .frame(width: 45, height: 45)
                .background{
                    Circle()
                        .fill(.gray.opacity(0.1))
                        .padding(-1)
                        .background{
                            Circle()
                                .stroke(Color.green, lineWidth: 1)
                        }
                }
            
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Text(subTitle)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
            .halign(.leading)
        }
    }
    
    // Hatırlatma: Firebase veritabanı "Rules" ayarlarında veritabanına erişim kısımını şu şekilde değiştirin "allow read, write: if request.auth !=null;" veya "...if true;"
    func fetchData()async throws{
        try await loginUserAnonymous()
        let info = try await Firestore.firestore().collection("Quiz").document("Info").getDocument().data(as: Info.self)
        let questions = try await Firestore.firestore().collection("Quiz").document("Info").collection("Questions").getDocuments().documents.compactMap{
            try $0.data(as: Question.self)
        }
        
        await MainActor.run(body: {
            self.quizInfo = info
            self.questions = questions
        })
    }
    
    func loginUserAnonymous()async throws{
        if !logStatus {
            try await Auth.auth().signInAnonymously()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View{
    func halign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func valign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

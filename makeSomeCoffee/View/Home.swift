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
            Text(info.title)
        } else {
            VStack(spacing: 4){
                ProgressView()
                Text("Lütfen Bekleyin...")
                    .font(.caption2)
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

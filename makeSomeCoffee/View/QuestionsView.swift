//
//  QuestionsView.swift
//  makeSomeCoffee
//
//  Created by Osman Esad on 22.02.2023.
//

import SwiftUI

struct QuestionsView: View {
    var info: Info
    var questions: [Question]
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .halign(.leading)
        }
        .padding(15)
        .halign(.center).valign(.top)
        .background{
            Color(.gray)
                .ignoresSafeArea()
        }
        .environment(\.colorScheme, .dark)
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

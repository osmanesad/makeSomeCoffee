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
    @State private var progress: CGFloat = 0
    var body: some View {
        VStack(spacing: 15){
            Button {
                dismiss()
                
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .halign(.leading)
            
            Text(info.title)
                .font(.title)
                .fontWeight(.semibold)
                .halign(.leading)
            GeometryReader {
                let size = $0.size
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity(0.2))
                    Rectangle()
                        .fill(Color(.purple))
                        .frame(width: progress * size.width, alignment: .leading)
                    
                }
            }
            .frame(height: 20)
            .padding(.top, 5)
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

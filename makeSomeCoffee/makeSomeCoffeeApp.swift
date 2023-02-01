//
//  makeSomeCoffeeApp.swift
//  makeSomeCoffee
//
//  Created by Osman Esad on 17.01.2023.
//

import SwiftUI
import Firebase

@main
struct makeSomeCoffeeApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

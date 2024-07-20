//
//  Training.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 17.07.2024.
//

import Foundation

struct Training: Codable {
    let title: String
    let description: String
    let miniDescription: String
    var progress: Int
    let imageName: String
    let time: Int
    let kcal: Int
    var seconds: Double
    var complete: Bool
    let index: Int
}

extension Training {
    static let mock: [Training] = [
        Training(title: "Sit Up",
                 description: "Sit-ups are a classic core-strengthening exercise that targets the abdominal muscles. By lying on your back, bending your knees, and raising your torso towards your thighs, you engage your core effectively.",
                 miniDescription: "35 Sit Up",
                 progress: 0,
                 imageName: ImageKeys.training1.rawValue,
                 time: 20,
                 kcal: 115,
                 seconds: 0,
                 complete: false,
                 index: 0),
        
        Training(title: "Push Up",
                 description: "Push-ups are a fundamental bodyweight exercise that targets the chest, triceps, and shoulders. By starting in a plank position and lowering your body until your chest touches the ground, then pushing back up, you can build upper body strength.",
                 miniDescription: "100 Belly fat burner",
                 progress: 0,
                 imageName: ImageKeys.training2.rawValue,
                 time: 30,
                 kcal: 295,
                 seconds: 0,
                 complete: false,
                 index: 1),
        
        Training(title: "Belly fat burner",
                 description: "There isn't a specific exercise for burning belly fat exclusively. However, a combination of cardiovascular exercises like running or cycling and a healthy diet can help reduce overall body fat, including belly fat.",
                 miniDescription: "40 Belly fat burner",
                 progress: 0,
                 imageName: ImageKeys.training3.rawValue,
                 time: 15,
                 kcal: 200,
                 seconds: 0,
                 complete: false,
                 index: 2),
        
        Training(title: "Plank",
                 description: "Planks are an isometric core exercise where you hold a push-up position, engaging your core muscles. This exercise helps strengthen your core, improve posture, and support your back.",
                 miniDescription: "2 minutes",
                 progress: 0,
                 imageName: ImageKeys.training4.rawValue,
                 time: 2,
                 kcal: 135,
                 seconds: 0,
                 complete: false,
                 index: 3),
        
        Training(title: "Leg excercises",
                 description: "Leg exercises can include squats, lunges, leg presses, or calf raises. These exercises target the quadriceps, hamstrings, glutes, and calves to improve lower body strength and muscle tone.",
                 miniDescription: "40 Leg excercises",
                 progress: 0,
                 imageName: ImageKeys.training5.rawValue,
                 time: 20,
                 kcal: 276,
                 seconds: 0,
                 complete: false,
                 index: 4),
        
        Training(title: "Backward lunges",
                 description: "Backward lunges are a variation of the traditional lunge where you step backward instead of forward. This exercise targets the quadriceps, hamstrings, and glutes while also challenging your balance.",
                 miniDescription: "50 Backward lunges",
                 progress: 0,
                 imageName: ImageKeys.training6.rawValue,
                 time: 30,
                 kcal: 250,
                 seconds: 0,
                 complete: false,
                 index: 5),
        
        Training(title: "Knee Push Up",
                 description: "Knee push-ups are a modification of the standard push-up. By performing push-ups on your knees instead of your toes, you can reduce the amount of body weight you're lifting, making it a more accessible exercise for beginners or those with limited upper body strength.",
                 miniDescription: "60 Knee Push Up",
                 progress: 0,
                 imageName: ImageKeys.training7.rawValue,
                 time: 20,
                 kcal: 180,
                 seconds: 0,
                 complete: false,
                 index: 6),
        
        Training(title: "Lower Body Training",
                 description: "The lower abdomen and hips are the most difficult areas of the body to reduce when we are on a diet. Even so, in this area, especially the legs as a whole, you can reduce weight even if you don't use tools.",
                 miniDescription: "100 Lower Body",
                 progress: 0,
                 imageName: ImageKeys.training8.rawValue,
                 time: 50,
                 kcal: 196,
                 seconds: 0,
                 complete: false,
                 index: 7)
    ]
}

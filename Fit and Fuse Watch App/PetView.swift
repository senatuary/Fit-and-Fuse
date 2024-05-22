//
//  PetView.swift
//  Fit and Fuse Watch App
//
//  Created by Josefany Jaya on 21/05/24.
//

import SwiftUI

struct PetView: View {
    @State var moveProgress: Double = 0
    @State var exerciseProgress: Double = 0
    @State var standProgress: Double = 0
    @State var fusionInProgress: Bool = false

    var body: some View {
        if fusionInProgress {
            Text("Fusion in progress!")
                .font(.title)
                .padding()
        } else {
            TabView {
                MovePet(petType: "Move", progress: $moveProgress, color: .red, textColor: Color(red: 236/255, green: 35/255, blue: 83/255, opacity: 1), checkFusion: checkFusion)
                ExercisePet(petType: "Exercise", progress: $exerciseProgress, color: .green, textColor: Color(red: 172/255, green: 208/255, blue: 55/255, opacity: 1), checkFusion: checkFusion)
                StandPet(petType: "Stand", progress: $standProgress, color: .blue, textColor: Color(red: 104/255, green: 201/255, blue: 209/255, opacity: 1), checkFusion: checkFusion)
            }
            .tabViewStyle(.carousel)
        }
    }

    func checkFusion() {
        if moveProgress >= 1.0 && exerciseProgress >= 1.0 && standProgress >= 1.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                fusionInProgress = true
            }
            print("fusion : \(fusionInProgress)")
        }
    }
}

struct MovePet: View {
    let petType: String
    @Binding var progress: Double
    let color: Color
    let textColor: Color
    let checkFusion: () -> Void
    let moveGoal: Double = 200

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, Color(red: 236/255, green: 35/255, blue: 83/255, opacity: 0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            ZStack{
                VStack {
                    PetImage(progress: progress, imageNames: ["Move0","Move1", "Move2", "Move3", "Move4"], textColor: Color(red: 236/255, green: 35/255, blue: 83/255, opacity: 1), activityType: "Move")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Text("\(Int(progress * moveGoal)) / \(Int(moveGoal)) kCal")
                        .font(.subheadline)
                        .foregroundColor(textColor)
                        .padding(5)
                }
                .padding(.bottom,30)
                
                Button(action: {
                    updateProgress(by: 0.25)
                    print("move progress : \(progress * 100)%")
                    checkFusion()
                }) {
                    Text("+")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }

    private func updateProgress(by amount: Double) {
        progress = min(1.0, progress + amount)
    }
}

struct ExercisePet: View {
    let petType: String
    @Binding var progress: Double
    let color: Color
    let textColor: Color
    let checkFusion: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, Color(red: 172/255, green: 208/255, blue: 55/255, opacity: 1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            ZStack{
                VStack {
                    PetImage(progress: progress, imageNames: ["Exercise0","Exercise1", "Exercise2", "Exercise3", "Exercise4"], textColor: Color(red: 172/255, green: 208/255, blue: 55/255, opacity: 0.5), activityType: "Exercise")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Text("\(Int(progress * 30)) / 30 min")
                        .font(.subheadline)
                        .foregroundColor(textColor)
                        .padding(5)
                }
                .padding(.bottom,30)
                
                Button(action: {
                    updateProgress(by: 0.25)
                    print("exercise progress : \(progress * 100)%")
                    checkFusion()
                }) {
                    Text("+")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }

    private func updateProgress(by amount: Double) {
        progress = min(1.0, progress + amount)
    }
}

struct StandPet: View {
    let petType: String
    @Binding var progress: Double
    let color: Color
    let textColor: Color
    let checkFusion: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, Color(red: 104/255, green: 201/255, blue: 209/255, opacity: 1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            ZStack{
                VStack {
                    PetImage(progress: progress, imageNames: ["Stand0", "Stand1", "Stand2", "Stand3", "Stand4"], textColor: Color(red: 104/255, green: 201/255, blue: 209/255, opacity: 0.5), activityType: "Stand")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Text("\(Int(progress * 360)) / 360 min")
                        .font(.subheadline)
                        .foregroundColor(textColor)
                        .padding(5)
                }
                .padding(.bottom,30)
                
                Button(action: {
                    updateProgress(by: 0.25)
                    print("stand progress : \(progress * 100)%")
                    checkFusion()
                }) {
                    Text("+")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }

    private func updateProgress(by amount: Double) {
        progress = min(1.0, progress + amount)
    }
}

struct PetImage: View {
    let progress: Double
    let imageNames: [String]
    let textColor: Color
    let activityType: String

    var body: some View {
        let imageName: String
        let imageSize: CGFloat

        switch progress {
                case 0..<0.25:
                    imageName = imageNames[0]
                    imageSize = 30
                case 0.25..<0.50:
                    imageName = imageNames[1]
                    imageSize = 40
                case 0.50..<0.75:
                    imageName = imageNames[2]
                    imageSize = 60
                case 0.75..<1.0:
                    imageName = imageNames[3]
                    imageSize = 80
                case 1.0:
                    imageName = imageNames[4]
                    imageSize = 110
                default:
                    imageName = imageNames[0]
                    imageSize = 30
                }

        return VStack {
            Text(String(format: "%.0f%%", progress * 100))
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
            
            Text(activityType)
                .font(.headline)
                .foregroundColor(textColor)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Center the image
        }
    }
}

#Preview {
    PetView()
}

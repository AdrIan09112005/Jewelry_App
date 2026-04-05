//
//  JoyeriaApp.swift
//  Joyeria
//
//  Created by Tu Nombre
//  Copyright © 2026 Joyeria App. All rights reserved.
//

import SwiftUI

// MARK: - Extensión de Color para colores personalizados
extension Color {
    // Color principal AZUL OSCURO #02274E
    static let azulOscuro = Color(red: 2/255, green: 39/255, blue: 78/255)
    static let azulOscuroClaro = Color(red: 42/255, green: 79/255, blue: 118/255)
    static let azulOscuroOscuro = Color(red: 0/255, green: 19/255, blue: 38/255)
    
    // Colores secundarios
    static let dorado = Color(red: 212/255, green: 175/255, blue: 55/255)
    static let plateado = Color(red: 192/255, green: 192/255, blue: 192/255)
    static let azulRolex = Color(red: 0/255, green: 82/255, blue: 147/255)
    static let blanco = Color.white
}

@main
struct JoyeriaApp: App {
    // MARK: - Propiedades
    @State private var isSplashScreenShowing = true
    
    // Configuración de la apariencia global
    init() {
        // Configuración de la barra de navegación
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = UIColor(Color.blanco)
        navigationAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.azulOscuro),
            .font: UIFont(name: "Didot-Bold", size: 20) ?? .boldSystemFont(ofSize: 20)
        ]
        navigationAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.azulOscuro),
            .font: UIFont(name: "Didot-Bold", size: 34) ?? .boldSystemFont(ofSize: 34)
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().tintColor = UIColor(Color.azulOscuro)
        
        // Configuración de la barra de pestañas
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.blanco)
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = UIColor(Color.azulOscuro)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isSplashScreenShowing {
                    SplashScreenView()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation(.easeOut(duration: 0.8)) {
                                    isSplashScreenShowing = false
                                }
                            }
                        }
                } else {
                    ContentView()
                }
            }
        }
    }
}

// MARK: - Splash Screen
struct SplashScreenView: View {
    @State private var isAnimating = false
    @State private var scaleAmount: CGFloat = 0.3
    @State private var opacityAmount: Double = 0
    @State private var rotationAmount: Double = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.azulOscuro,
                    Color.azulOscuroOscuro
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            GeometryReader { geometry in
                ForEach(0..<8) { index in
                    Image(systemName: "star.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color.dorado.opacity(0.1))
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                        .rotationEffect(.degrees(Double(index * 45)))
                }
            }
            
            VStack(spacing: 25) {
                ZStack {
                    Circle()
                        .stroke(Color.dorado.opacity(0.3), lineWidth: 2)
                        .frame(width: 200, height: 200)
                        .scaleEffect(isAnimating ? 1.2 : 0.8)
                        .opacity(isAnimating ? 0.5 : 1)
                    
                    Image(systemName: "crown.fill")
                        .font(.system(size: 100))
                        .foregroundColor(Color.dorado)
                        .scaleEffect(isAnimating ? 1.1 : 0.9)
                        .rotationEffect(.degrees(rotationAmount))
                }
                
                VStack(spacing: 10) {
                    Text("JOYERÍA")
                        .font(.custom("Didot-Bold", size: 48))
                        .foregroundColor(Color.dorado)
                        .opacity(opacityAmount)
                        .scaleEffect(scaleAmount)
                    
                    Text("Lujo y Elegancia")
                        .font(.custom("Didot", size: 20))
                        .foregroundColor(Color.plateado)
                        .opacity(opacityAmount)
                    
                    Rectangle()
                        .fill(Color.dorado)
                        .frame(width: 100, height: 2)
                        .opacity(opacityAmount)
                        .padding(.top, 10)
                }
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.dorado))
                    .scaleEffect(1.5)
                    .padding(.top, 50)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                scaleAmount = 1
                opacityAmount = 1
            }
            
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                rotationAmount = 360
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
        }
    }
}

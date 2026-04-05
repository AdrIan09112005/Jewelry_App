//
//  ContentView.swift
//  Joyeria
//
//  Created by Tu Nombre
//  Copyright © 2026 Joyeria App. All rights reserved.
//

import SwiftUI

// MARK: - Modelos de Datos
struct JoyaItem: Identifiable {
    let id = UUID()
    let nombre: String
    let coleccion: String
    let precio: Double
    let descripcion: String
    let imagen: String
    let material: MaterialJoya
    let disponible: Bool
}

enum MaterialJoya: String {
    case oro = "Oro"
    case plata = "Plata"
    case bicolor = "Bicolor"
    case platino = "Platino"
    
    var color: Color {
        switch self {
        case .oro:
            return Color(red: 212/255, green: 175/255, blue: 55/255)
        case .plata:
            return Color(red: 192/255, green: 192/255, blue: 192/255)
        case .bicolor:
            return Color(red: 212/255, green: 175/255, blue: 55/255)
        case .platino:
            return Color(red: 229/255, green: 228/255, blue: 226/255)
        }
    }
}

struct Categoria: Identifiable {
    let id = UUID()
    let nombre: String
    let icono: String
    let color: Color
}

// MARK: - ContentView Principal
struct ContentView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showCart = false
    
    let categorias: [Categoria] = [
        Categoria(nombre: "Anillos", icono: "circle", color: Color.azulOscuro),
        Categoria(nombre: "Collares", icono: "circle.dotted", color: Color.dorado),
        Categoria(nombre: "Pulseras", icono: "circle.hexagongrid", color: Color.azulRolex),
        Categoria(nombre: "Relojes", icono: "clock", color: Color.azulOscuro),
        Categoria(nombre: "Dijes", icono: "diamond", color: Color.dorado),
        Categoria(nombre: "Pendientes", icono: "ear", color: Color.azulRolex)
    ]
    
    let joyasDestacadas: [JoyaItem] = [
        JoyaItem(
            nombre: "Submariner Date",
            coleccion: "Submariner",
            precio: 9600.00,
            descripcion: "Reloj sumergible profesional con bisel giratorio",
            imagen: "watch_submariner",
            material: .plata,
            disponible: true
        ),

        // Items adicionales para mostrar variedad
        JoyaItem(
            nombre: "Daytona Cosmograph",
            coleccion: "Daytona",
            precio: 12500.00,
            descripcion: "Cronógrafo de precisión con esfera negra",
            imagen: "watch_daytona",
            material: .oro,
            disponible: true
        ),
        JoyaItem(
            nombre: "Datejust 41",
            coleccion: "Datejust",
            precio: 7500.00,
            descripcion: "Elegancia clásica con fecha instantánea",
            imagen: "watch_datejust",
            material: .bicolor,
            disponible: true
        ),
        JoyaItem(
            nombre: "GMT-Master II",
            coleccion: "GMT-Master",
            precio: 10200.00,
            descripcion: "Doble huso horario con bisel bicolor",
            imagen: "watch_gmt",
            material: .plata,
            disponible: false
        )
    ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView(
                    categorias: categorias,
                    joyasDestacadas: joyasDestacadas,
                    searchText: $searchText,
                    isSearching: $isSearching
                )
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {}) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(Color.azulOscuro)
                                .font(.title2)
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("JOYERÍA")
                            .font(.custom("Didot-Bold", size: 24))
                            .foregroundColor(Color.azulOscuro)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 15) {
                            Button(action: {}) {
                                Image(systemName: "heart")
                                    .foregroundColor(Color.azulOscuro)
                            }
                            
                            Button(action: { showCart.toggle() }) {
                                ZStack(alignment: .topTrailing) {
                                    Image(systemName: "bag")
                                        .foregroundColor(Color.azulOscuro)
                                    
                                    Circle()
                                        .fill(Color.dorado)
                                        .frame(width: 12, height: 12)
                                        .offset(x: 5, y: -5)
                                }
                            }
                        }
                        .font(.title2)
                    }
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Inicio")
            }
            .tag(0)
            
            NavigationView {
                CatalogoView()
                    .navigationTitle("CATÁLOGO")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "square.grid.2x2.fill")
                Text("Catálogo")
            }
            .tag(1)
            
            NavigationView {
                FavoritosView()
                    .navigationTitle("FAVORITOS")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favoritos")
            }
            .tag(2)
            
            NavigationView {
                PerfilView()
                    .navigationTitle("PERFIL")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Perfil")
            }
            .tag(3)
        }
        .accentColor(Color.azulOscuro)
    }
}

// MARK: - HomeView
struct HomeView: View {
    let categorias: [Categoria]
    let joyasDestacadas: [JoyaItem]
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 25) {
                SearchBar(text: $searchText, isSearching: $isSearching)
                    .padding(.horizontal)
                
                HeroBannerView()
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("CATEGORÍAS")
                        .font(.custom("Didot-Bold", size: 20))
                        .foregroundColor(Color.azulOscuro)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(categorias) { categoria in
                                CategoriaCard(categoria: categoria)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("DESTACADOS")
                        .font(.custom("Didot-Bold", size: 20))
                        .foregroundColor(Color.azulOscuro)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(joyasDestacadas) { joya in
                            JoyaCard(joya: joya)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color.blanco)
    }
}

// MARK: - Componentes UI
struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.azulOscuro.opacity(0.6))
                
                TextField("Buscar joyas...", text: $text)
                    .font(.custom("Didot", size: 16))
                    .foregroundColor(.black)
                    .onTapGesture {
                        isSearching = true
                    }
                
                if !text.isEmpty {
                    Button(action: { text = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.azulOscuro)
                    }
                }
            }
            .padding(10)
            .background(Color.azulOscuro.opacity(0.1))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.azulOscuro.opacity(0.3), lineWidth: 1)
            )
            
            if isSearching {
                Button("Cancelar") {
                    isSearching = false
                    text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .font(.custom("Didot", size: 16))
                .foregroundColor(Color.azulOscuro)
            }
        }
    }
}

struct HeroBannerView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.azulOscuro,
                    Color.azulOscuroClaro
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 200)
            .cornerRadius(15)
            
            HStack(spacing: 30) {
                ForEach(0..<3) { i in
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color.dorado.opacity(0.2))
                        .offset(y: isAnimating ? -10 : 10)
                        .animation(
                            Animation.easeInOut(duration: 2)
                                .repeatForever(autoreverses: true)
                                .delay(Double(i) * 0.3),
                            value: isAnimating
                        )
                }
            }
            .offset(x: 50, y: -30)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("NUEVA COLECCIÓN")
                    .font(.custom("Didot-Bold", size: 28))
                    .foregroundColor(Color.dorado)
                
                Text("Elegancia en azul")
                    .font(.custom("Didot", size: 18))
                    .foregroundColor(.white)
                
                HStack {
                    Text("DESCUBRE")
                        .font(.custom("Didot-Bold", size: 14))
                        .foregroundColor(Color.azulOscuro)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 12)
                        .background(Color.dorado)
                        .cornerRadius(25)
                    
                    Spacer()
                    
                    Circle()
                        .stroke(Color.dorado, lineWidth: 2)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color.dorado)
                        )
                }
            }
            .padding(20)
        }
        .padding(.horizontal)
        .shadow(color: Color.azulOscuro.opacity(0.3), radius: 10, x: 0, y: 5)
        .onAppear {
            isAnimating = true
        }
    }
}

struct CategoriaCard: View {
    let categoria: Categoria
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(categoria.color.opacity(0.15))
                    .frame(width: 80, height: 80)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                
                Image(systemName: categoria.icono)
                    .font(.system(size: 35))
                    .foregroundColor(categoria.color)
            }
            
            Text(categoria.nombre)
                .font(.custom("Didot", size: 14))
                .foregroundColor(.black)
        }
        .frame(width: 100)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: categoria.color.opacity(0.2), radius: 5, x: 0, y: 2)
        )
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .onTapGesture {
            withAnimation(.spring()) {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                }
            }
        }
    }
}

struct JoyaCard: View {
    let joya: JoyaItem
    @State private var isFavorite = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 150)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundColor(Color.azulOscuro.opacity(0.3))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.azulOscuro.opacity(0.3), lineWidth: 1)
                    )
                
                Button(action: { isFavorite.toggle() }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? Color.azulOscuro : Color.gray)
                        .padding(8)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(8)
                
                if !joya.disponible {
                    Text("AGOTADO")
                        .font(.custom("Didot", size: 10))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.azulOscuro)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(8)
                        .offset(y: 30)
                }
            }
            
            Text(joya.nombre)
                .font(.custom("Didot-Bold", size: 16))
                .foregroundColor(.black)
                .lineLimit(1)
            
            Text(joya.coleccion)
                .font(.custom("Didot", size: 14))
                .foregroundColor(.gray)
            
            HStack {
                Text("$\(joya.precio, specifier: "%.2f")")
                    .font(.custom("Didot-Bold", size: 18))
                    .foregroundColor(Color.azulOscuro)
                
                Spacer()
                
                Circle()
                    .fill(joya.material.color)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color.azulOscuro, lineWidth: 1)
                    )
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.azulOscuro.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Vistas Adicionales
struct CatalogoView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<10) { index in
                    NavigationLink(destination: Text("Detalle del producto")) {
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.azulOscuro.opacity(0.1))
                                .frame(height: 150)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(Color.azulOscuro.opacity(0.5))
                                )
                            
                            Text("Producto \(index + 1)")
                                .font(.custom("Didot", size: 14))
                                .foregroundColor(.black)
                            
                            Text("$\(Double.random(in: 1000...10000), specifier: "%.2f")")
                                .font(.custom("Didot-Bold", size: 16))
                                .foregroundColor(Color.azulOscuro)
                        }
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.azulOscuro.opacity(0.1), radius: 3, x: 0, y: 2)
                    }
                }
            }
            .padding()
        }
        .background(Color.blanco)
    }
}

struct FavoritosView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart")
                .font(.system(size: 80))
                .foregroundColor(Color.azulOscuro.opacity(0.3))
            
            Text("No tienes favoritos aún")
                .font(.custom("Didot", size: 18))
                .foregroundColor(.gray)
            
            Text("Explora nuestro catálogo y agrega tus piezas favoritas")
                .font(.custom("Didot", size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {}) {
                Text("EXPLORAR CATÁLOGO")
                    .font(.custom("Didot-Bold", size: 16))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.azulOscuro)
                    .cornerRadius(25)
            }
            .padding(.top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blanco)
    }
}

struct PerfilView: View {
    var body: some View {
        VStack(spacing: 25) {
            ZStack {
                Circle()
                    .fill(Color.azulOscuro.opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color.azulOscuro)
            }
            
            Text("Invitado")
                .font(.custom("Didot-Bold", size: 24))
                .foregroundColor(.black)
            
            VStack(spacing: 15) {
                PerfilOptionRow(icono: "bag", texto: "Mis pedidos")
                PerfilOptionRow(icono: "location", texto: "Direcciones")
                PerfilOptionRow(icono: "creditcard", texto: "Métodos de pago")
                PerfilOptionRow(icono: "bell", texto: "Notificaciones")
                PerfilOptionRow(icono: "questionmark.circle", texto: "Ayuda")
            }
            .padding(.horizontal)
            
            Button(action: {}) {
                Text("INICIAR SESIÓN")
                    .font(.custom("Didot-Bold", size: 16))
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(Color.azulOscuro)
                    .cornerRadius(25)
            }
            .padding(.top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blanco)
    }
}

struct PerfilOptionRow: View {
    let icono: String
    let texto: String
    
    var body: some View {
        HStack {
            Image(systemName: icono)
                .foregroundColor(Color.azulOscuro)
                .frame(width: 30)
            
            Text(texto)
                .font(.custom("Didot", size: 16))
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

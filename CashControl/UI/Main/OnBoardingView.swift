//
//  OnBoardingView.swift
//  CashControl
//
//  Created by Analucia Krubzkaya on 22/12/25.
//

import SwiftUI

enum OnBoardingPage: Int, CaseIterable {
    case browseMenu
    case quickDelivery
    case orderTracking
    
    var title: String {
        switch self {
        case .browseMenu:
            return "Controla tus gastos"
        case .quickDelivery:
            return "Registra tus ingresos"
        case .orderTracking:
            return "Visualiza tu progreso"
        }
    }
    
    var description: String {
        switch self {
        case .browseMenu:
            return "Lleva un registro claro de en qué gastas tu dinero y toma mejores decisiones financieras."
        case .quickDelivery:
            return "Anota tus ingresos de forma rápida y mantén el control total de tu dinero."
        case .orderTracking:
            return "Consulta gráficos y resúmenes para entender tus hábitos y alcanzar tus metas."
                }
    }
}



struct OnBoardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 0
    @State private var isAnimating = false
    @State private var deliveryOffset = false
    @State private var trackingProgress: CGFloat = 0.0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(OnBoardingPage.allCases, id: \.rawValue) { page in
                    getPageView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.spring(), value: currentPage)
            
            HStack(spacing: 12) {
                ForEach(0..<OnBoardingPage.allCases.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.5))
                        .frame(
                            width: currentPage == index ? 12 : 8,
                            height: currentPage == index ? 12 : 8
                        )
                        .animation(.spring(), value: currentPage)
                }
            }
            
            Button {
                withAnimation(.spring()) {
                    if currentPage < OnBoardingPage.allCases.count - 1 {
                        currentPage += 1
                        isAnimating = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isAnimating = true
                        }
                    } else {
                        // por mientras está en false para probar
                        // cambiar a true cuando ya esté listo
                        withAnimation(.spring()) {
                            hasSeenOnboarding = true
                        }

                    }
                }
            } label: {
                Text(currentPage < OnBoardingPage.allCases.count - 1 ? "Siguiente" : "Empecemos")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue,
                                Color.blue.opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    isAnimating = true
                }
            }
        }
    }
    
    private var ImagenesOnBoarding: some View {
        ZStack {
            Image("imag1")
                .resizable()
                .scaledToFit()
                .frame(height: 240)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
                .zIndex(1)
        }
    }
    
    private var deliveryAnimation: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            
            Image("imag2")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .offset(y: deliveryOffset ? -20 : 0)
                .rotationEffect(.degrees(deliveryOffset ? 5 : -5))
                .opacity(isAnimating ? 1 : 0)
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimating)
            
            ForEach(0..<8) { index in
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .offset(
                        x: 120 * cos(Double(index) * .pi / 4),
                        y: 120 * sin(Double(index) * .pi / 4)
                    )
                    .scaleEffect(isAnimating ? 1 : 0)
                    .opacity(isAnimating ? 0.7 : 0)
                    .animation(
                        .easeInOut(duration: 1.5)
                            .repeatForever()
                            .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
    }
    
    private var orderTrackingAnimation: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            
            Image("imag8")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .opacity(isAnimating ? 1 : 0)
                .scaleEffect(isAnimating ? 1 : 0.8)
                .rotation3DEffect(
                    .degrees(isAnimating ? 360 : 1),
                    axis: (x: 0, y: 1, z: 0)
                )
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimating)
            
            ForEach(0..<4) { index in
                Image(systemName: "location.fill")
                    .foregroundStyle(Color.blue)
                    .offset(
                        x: 100 * cos(Double(index) * .pi / 2),
                        y: 100 * sin(Double(index) * .pi / 2)
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0)
                    .animation(
                        .spring(dampingFraction: 0.6)
                            .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
    }
    
    @ViewBuilder
    private func getPageView(for page: OnBoardingPage) -> some View {
        VStack(spacing: 30) {
            ZStack {
                switch page {
                case .browseMenu:
                    ImagenesOnBoarding
                case .quickDelivery:
                    deliveryAnimation
                case .orderTracking:
                    orderTrackingAnimation
                }
            }
            
            VStack(spacing: 20) {
                Text(page.title)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
                
                Text(page.description)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .padding(.horizontal, 32)
                    .multilineTextAlignment(.center)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    OnBoardingView()
}

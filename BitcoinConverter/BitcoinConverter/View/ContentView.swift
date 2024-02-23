//
//  ContentView.swift
//  BitcoinConverter
//
//  Created by Emir Rassulov on 27/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isRotating = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(hexColor: "#00C7BE")  // Use the hex code here
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("bitcoinLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .rotationEffect(Angle(degrees: isRotating ? 360 : 0))
                        .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
                        .onAppear() {
                            withAnimation {
                                self.isRotating.toggle()
                            }
                        }
                        .padding(.bottom, 100)

                    Text("Bitcoin Converter")
                        .font(Font.custom("Pacifico-Regular", size: 40))
                        .bold()
                        .foregroundColor(.white)

                    Spacer()

                    NavigationLink(destination: NextPageView(viewModel: NextPageViewModel())) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .frame(height: 50)
                            .padding([.leading, .trailing], 20)
                            .overlay(HStack {
                                Text("Let's Get Started").foregroundColor(.black)
                            })
                            .padding(.bottom, 100)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Color extension to initialize from hex string
extension Color {
    init(hexColor: String) {
        var hexSanitized = hexColor.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self = Color(red: red, green: green, blue: blue)
    }
}





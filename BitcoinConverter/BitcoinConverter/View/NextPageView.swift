//
//  NextPageView.swift
//  BitcoinConverter
//
//  Created by Emir Rassulov on 27/01/2024.
//

import SwiftUI

struct NextPageView: View {
    @ObservedObject var viewModel = NextPageViewModel()

    var formattedBitcoinPrice: String {
        viewModel.formattedBitcoinPrice
    }

    var body: some View {
        ZStack {
            Color(hex: 0x00C7BE)
                .ignoresSafeArea()

            VStack {
                Spacer()

                GifView(gifName: "Animation")
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 150)

                HStack {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .padding(.leading, 10)

                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .onAppear {
                                viewModel.startRotation()
                            }
                    } else {
                        Text("\(formattedBitcoinPrice) \(viewModel.selectedCurrency)")
                            .font(.title)
                            .foregroundColor(.white)
                            .rotationEffect(Angle(degrees: viewModel.rotationAngle))
                            .padding()
                    }
                }
                .background(RoundedRectangle(cornerRadius: 500)
                                .foregroundColor(.gray))
                .frame(maxWidth: .infinity)
                .offset(y: -30)


                Spacer()

                Picker("Select Currency", selection: $viewModel.selectedCurrency) {
                    ForEach(viewModel.currencyArray, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .onChange(of: viewModel.selectedCurrency) { _ in
                    viewModel.getCoinPrice()
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 10)
            }
            .padding()
        }
    }
}

struct NextPageView_Previews: PreviewProvider {
    static var previews: some View {
        NextPageView()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}





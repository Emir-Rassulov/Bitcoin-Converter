//
//  GifView.swift
//  BitcoinConverter
//
//  Created by Emir Rassulov on 27/01/2024.
//

import SwiftUI
import FLAnimatedImage

struct GifView: UIViewRepresentable {
    var gifName: String

    func makeUIView(context: Context) -> FLAnimatedImageView {
        guard let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
              let gifData = try? Data(contentsOf: gifURL) else {
            return FLAnimatedImageView()
        }

        let animatedImageView = FLAnimatedImageView()
        animatedImageView.animatedImage = FLAnimatedImage(animatedGIFData: gifData)
        return animatedImageView
    }

    func updateUIView(_ uiView: FLAnimatedImageView, context: Context) {
        // Update logic if needed
    }
}

// ImageView+Exstension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для загрузки картинки
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    if let loadedImage = UIImage(data: imageData) {
                        self.image = loadedImage
                    }
                }
            }
        }
    }
}

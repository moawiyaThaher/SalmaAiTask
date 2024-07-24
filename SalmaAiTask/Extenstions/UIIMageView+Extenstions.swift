//
//  UIIMageView+Extenstions.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 23/07/2024.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    public func loadImage(urlString: String?,
                  completion: ((UIImage?) -> Void)? = nil) {
        guard let urlString = urlString,
        let url = URL(string: urlString) else {
            image = nil
            return
        }
        self.sd_setImage(with: url) { image, _, _, _ in
            completion?(image)
        }
    }
}

//
//  UIImageView +.swift
//  StarMovie
//
//  Created by petar on 19.06.2024.
//

import Kingfisher
import UIKit

extension UIImageView{
    func getImageMovie(url: String, plaseholderImage: UIImage){
        let urlImage = URL(string: "\(Resources.UrlMovieDB.imageUrlPath)\(url)")
        kf.setImage(with: urlImage, placeholder: plaseholderImage)
    }
}

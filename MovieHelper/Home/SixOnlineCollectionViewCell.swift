//
//  PartOfOnlineMovieCollectionViewCell.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/8/27.
//

import UIKit
import WebKit
import Kingfisher

class SixOnlineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameEN: UILabel!
    @IBOutlet weak var nameCH: UILabel!
    @IBOutlet weak var posterView: UIView!
    
    func setup(with movie: OnlineMovieKeys) {
        nameCH.text = movie.Title
        nameEN.text = movie.EnglishTitle
        posterSetup(url: movie.PosterURL)
    }
}

extension SixOnlineCollectionViewCell: WKNavigationDelegate {
    
    func posterSetup(url: String) {
        
        // 外框效果
        posterView.layer.borderWidth = 3.0
        posterView.layer.borderColor = UIColor.darkGray.cgColor
        posterView.layer.cornerRadius = 10.0
        posterView.clipsToBounds = true
        
        guard let posterUrl = URL(string: url) else {
            assertionFailure("URL error")
            return
        }
        self.posterImageView.kf.setImage(with: posterUrl)
    }
}

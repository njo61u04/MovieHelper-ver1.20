//
//  BoxOfficeCollectionViewCell.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/9/13.
//

import UIKit
import WebKit

class BoxOfficeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var rankImageView: UIImageView!
    @IBOutlet weak var posterWebView: WKWebView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameENLabel: UILabel!
    @IBOutlet weak var nameCHLabel: UILabel!
    
    func setup(with movie: OnlineMovieKeys, rank: Int) {
        nameCHLabel.text = movie.Title
        nameENLabel.text = movie.EnglishTitle
        infoLabel.text = movie.Info
        dateLabel.text = movie.date
        ageLabel.text = movie.AgeRating
        ageLabelSetup()
        rankImageViewSetup(rank: rank)
        posterSetup(url: movie.PosterURL)
    }
     
}

extension BoxOfficeCollectionViewCell: WKNavigationDelegate {
    
    func posterSetup(url: String) {
        // 外框效果
        borderView.layer.borderWidth = 3.0
        borderView.layer.borderColor = UIColor.darkGray.cgColor
        borderView.layer.cornerRadius = 10.0
        borderView.clipsToBounds = true
        
        guard let url = URL(string: url) else {
            assertionFailure("URL error")
            return
        }
        let request = URLRequest(url: url)
        posterWebView.load(request)
        posterWebView.navigationDelegate = self
        posterWebView.isUserInteractionEnabled = false
    }
    
    func rankImageViewSetup(rank: Int) {
        
        backgroundImageView.backgroundColor = .white
        backgroundImageView.layer.cornerRadius = backgroundImageView.frame.size.width / 2
        backgroundImageView.clipsToBounds = true
        
        rankImageView.tintColor = .systemPurple//UIColor(named: "rankColor")
        let iconName: String
        if rank < 10 {
            iconName = "0\(rank).square.fill"
        } else {
            iconName = "\(rank).square.fill"
        }
        rankImageView.image = UIImage(systemName: iconName)
        rankImageView.contentMode = .scaleToFill
    }
    
    func ageLabelSetup() {
        ageLabel.layer.cornerRadius = 5.0
        ageLabel.layer.masksToBounds = true
        ageLabel.textColor = .white
        if let ageRating = ageLabel.text {
            if ageRating.contains("輔") {
                ageLabel.backgroundColor = .systemYellow
            }
            else if ageRating.contains("普") {
                ageLabel.backgroundColor = .systemGreen
            }
            else if ageRating.contains("護") {
                ageLabel.backgroundColor = .systemCyan
            }
            else if ageRating.contains("限") {
                ageLabel.backgroundColor = .systemRed
            }
        }
    }

}



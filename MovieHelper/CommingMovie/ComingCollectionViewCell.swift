//
//  CommingMovieCollectionViewCell.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/8/27.
//

import UIKit
import WebKit

class ComingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameENLabel: UILabel!
    @IBOutlet weak var nameCHLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var posterWebView: WKWebView!
    
    func setup(with movie: ComingMovieKeys) {
        nameCHLabel.text = movie.Title
        nameENLabel.text = movie.EnglishTitle
        dateLabel.text = movie.date
        infoLabel.text = movie.Info
        ageLabel.text = movie.AgeRating
        ageLabelSetup()
        posterSetup(url: movie.PosterURL)

    }
}

extension ComingCollectionViewCell: WKNavigationDelegate {
    
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


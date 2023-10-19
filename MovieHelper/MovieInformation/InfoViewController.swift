//
//  MovieInfoViewController.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/9/1.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {
    
    var nameCH: String?
    var onlineURL = CatchDataHelper.shared.onlineMovies
    var comingURL = CatchDataHelper.shared.comingMovies

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rtLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var nameENLabel: UILabel!
    @IBOutlet weak var nameCHLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
    
            guard let nameCH = self.nameCH else {
                assertionFailure("Can't Read nameCH!!!!")
                return
            }
            print(nameCH)
            let filteredTimeList = CatchDataHelper.shared.datafilter(self.onlineURL, name: nameCH)
            if let searchingMovie = filteredTimeList.first {
                self.posterSetup(url: (searchingMovie.PosterURL))
                self.nameCHLabel.text = searchingMovie.Title
                self.nameENLabel.text = searchingMovie.EnglishTitle
                self.dateLabel.text = searchingMovie.date
                self.ageLabel.text = searchingMovie.AgeRating
                self.infoLabel.text = searchingMovie.Info
                self.lengthLabel.text = searchingMovie.length
                self.directorLabel.text = searchingMovie.direct
                self.actorLabel.text = searchingMovie.act
                self.imdbLabel.text = searchingMovie.imdb
                self.rtLabel.text = searchingMovie.rt
            }else {
                let filteredTimeList = CatchDataHelper.shared.datafilter(self.comingURL, name: nameCH)
                if let searchingMovie = filteredTimeList.first {
                    self.posterSetup(url: (searchingMovie.PosterURL))
                    self.nameCHLabel.text = searchingMovie.Title
                    self.nameENLabel.text = searchingMovie.EnglishTitle
                    self.dateLabel.text = searchingMovie.date
                    self.ageLabel.text = searchingMovie.AgeRating
                    self.infoLabel.text = searchingMovie.Info
                    self.lengthLabel.text = searchingMovie.length
                    self.directorLabel.text = searchingMovie.direct
                    self.actorLabel.text = searchingMovie.act
                    self.imdbLabel.text = searchingMovie.imdb
                    self.rtLabel.text = searchingMovie.rt
                }
            }
        }
        self.infoViewSetup()
    }
}

extension InfoViewController: WKNavigationDelegate {
    
    //show web view
    func posterSetup(url: String) {
        
        guard let url = URL(string: url) else {
            assertionFailure("URL error")
            return
        }
        let request = URLRequest(url: url)
        infoWebView.load(request)
        infoWebView.navigationDelegate = self
        infoWebView.isUserInteractionEnabled = false
    }
    
    func infoViewSetup() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //gradientLayer.frame = view.bounds // 使用 view 的尺寸而不是 infoView 的尺寸
        
        // 设置渐变颜色，仅在顶部添加透明颜色
        let transparentColor = UIColor.clear.cgColor
        let solidColor = UIColor.black.cgColor
        gradientLayer.colors = [transparentColor, solidColor]
        
        // 设置渐变方向，这里是从上到下
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.1)
        
        // 将 gradientLayer 添加到 infoView
        infoView.layer.insertSublayer(gradientLayer, at: 0)
        
        view.sendSubviewToBack(infoView)
    }
}

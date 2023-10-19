//
//  TrailerViewController.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/9/1.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    
    var nameCH: String?
    var onlineTrail = CatchDataHelper.shared.onlineMovies
    var comingTrail = CatchDataHelper.shared.comingMovies

    @IBOutlet weak var trailerWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            guard let nameCH = self.nameCH else {
                assertionFailure("Can't Read nameCH!!!!")
                return
            }
            print(nameCH)
            let filteredTimeList = CatchDataHelper.shared.datafilter(self.onlineTrail, name: nameCH)
            if let searchingMovie = filteredTimeList.first {
                self.webViewSetup(url: (searchingMovie.yt_url))
            }else {
                let filteredTimeList = CatchDataHelper.shared.datafilter(self.comingTrail, name: nameCH)
                if let searchingMovie = filteredTimeList.first {
                    self.webViewSetup(url: (searchingMovie.yt_url))
                }
            }
        }
    }
}
    
extension TrailerViewController: WKNavigationDelegate {
    
    //show web view
    func webViewSetup(url: String) {
        
        guard let url = URL(string: url) else {
            assertionFailure("URL error")
            return
        }
        let request = URLRequest(url: url)
        trailerWebView.load(request)
        trailerWebView.navigationDelegate = self
        trailerWebView.scrollView.bounces = false
    }
}


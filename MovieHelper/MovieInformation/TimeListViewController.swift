//
//  TimeListViewController.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/9/1.
//

import UIKit
import FirebaseDatabase
import WebKit

class TimeListViewController: UIViewController {
    
    var nameCH: String?
    var onlineURL = CatchDataHelper.shared.onlineMovies
    var comingURL = CatchDataHelper.shared.comingMovies
    
    @IBOutlet weak var timeListWebView: WKWebView!
    
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
                self.webViewSetup(url: (searchingMovie.URL))
            }else {
                let filteredTimeList = CatchDataHelper.shared.datafilter(self.comingURL, name: nameCH)
                if let searchingMovie = filteredTimeList.first {
                    self.webViewSetup(url: (searchingMovie.URL))
                }
            }
        }
    }
}

extension TimeListViewController: WKNavigationDelegate {

    //show web view
    func webViewSetup(url: String) {
        
        guard let url = URL(string: url) else {
            assertionFailure("URL error")
            return
        }
        let request = URLRequest(url: url)
        timeListWebView.load(request)
        timeListWebView.navigationDelegate = self
        timeListWebView.scrollView.bounces = false
    }
}
/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/

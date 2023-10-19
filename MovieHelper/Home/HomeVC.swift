//
//  ViewController.swift
//  MovieHelper
//
//  Created by student on 2023/8/2.
//

import UIKit
import FirebaseDatabase
import Foundation
import WebKit

class HomeVC: UIViewController {
        
    @IBOutlet weak var comingLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var onlineCollectionView: UICollectionView!
    @IBOutlet weak var comingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change specific text color
        if let onlineText = onlineLabel.text {
            let onlineAttributedText = NSMutableAttributedString(string: onlineText)
            onlineAttributedText.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: NSRange(location: onlineText.count - 1, length: 1))
            onlineLabel.attributedText = onlineAttributedText
        }
        if let comingText = comingLabel.text {
            let comingAttributedText = NSMutableAttributedString(string: comingText)
            comingAttributedText.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: NSRange(location: comingText.count - 1, length: 1))
            comingLabel.attributedText = comingAttributedText
        }
        
        onlineCollectionView.dataSource = self
        onlineCollectionView.delegate = self
        comingCollectionView.dataSource = self
        comingCollectionView.delegate = self
        
        CatchDataHelper.shared.readSixData(dataSource: "users/online", objectType: OnlineMovieKeys.self) { [weak self] result in
            guard let sixOnlineMovies = result else {
                assertionFailure("Can't Read Data!!!!")
                return
            }
            CatchDataHelper.shared.sixOnlineMovies = sixOnlineMovies
            self?.onlineCollectionView.reloadData()
        }
        
        CatchDataHelper.shared.readSixData(dataSource: "users/coming", objectType: ComingMovieKeys.self) { [weak self] result in
            guard let sixComingMovies = result else {
                assertionFailure("Can't Read Data!!!!")
                return
            }
            //print(sixComingMovies)
            CatchDataHelper.shared.sixComingMovies = sixComingMovies
            self?.comingCollectionView.reloadData()
        }
        
        CatchDataHelper.shared.readData(dataSource: "users/online", objectType: OnlineMovieKeys.self) { result in
            guard let onlineMovies = result else {
                assertionFailure("Can't Read Data!!!!")
                return
            }
            CatchDataHelper.shared.onlineMovies = onlineMovies
        }
        
        CatchDataHelper.shared.readData(dataSource: "users/coming", objectType: ComingMovieKeys.self) { result in
            guard let comingMovies = result else {
                assertionFailure("Can't Read Data!!!!")
                return
            }
            CatchDataHelper.shared.comingMovies = comingMovies
        }
    }
}

extension HomeVC: UICollectionViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onlineToMain" {
            if let destinationVC = segue.destination as? MainViewController,
               let index = onlineCollectionView.indexPathsForSelectedItems?.first {
                destinationVC.nameCH = CatchDataHelper.shared.sixOnlineMovies[index.row].Title
            }
        }
        else if segue.identifier == "comingToMain" {
            if let destinationVC = segue.destination as? MainViewController,
               let index = comingCollectionView.indexPathsForSelectedItems?.first {
                destinationVC.nameCH = CatchDataHelper.shared.sixComingMovies[index.row].Title
            }
        }
    }
}

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.onlineCollectionView {
            return CatchDataHelper.shared.sixOnlineMovies.count
        }
        else if collectionView == self.comingCollectionView {
            return CatchDataHelper.shared.sixComingMovies.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.onlineCollectionView {
            let sixOnlineCell = collectionView.dequeueReusableCell(withReuseIdentifier: "onlineCell", for: indexPath) as! SixOnlineCollectionViewCell
            // Configure the cell
            let sixOnlineMovie = CatchDataHelper.shared.sixOnlineMovies[indexPath.row]

            sixOnlineCell.setup(with: sixOnlineMovie)
            
            return sixOnlineCell
        }
        else if collectionView == self.comingCollectionView{
            let sixComingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "comingCell", for: indexPath) as! SixComingCollectionViewCell
            // Configure the cell
            let sixComingMovie = CatchDataHelper.shared.sixComingMovies[indexPath.row]
            
            sixComingCell.setup(with: sixComingMovie)
            
            return sixComingCell
        }
        else {
            return UICollectionViewCell()
        }
    }
}

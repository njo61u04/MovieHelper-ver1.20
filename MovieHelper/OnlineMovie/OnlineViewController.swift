//
//  OnlineMovieViewController.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/8/23.
//

import UIKit
import FirebaseDatabase
import Foundation
import WebKit

class OnlineViewController: UIViewController, WKNavigationDelegate {
    
    var onlineMovies = CatchDataHelper.shared.onlineMovies
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //change navigationbar style
        navigationController?.navigationBar.tintColor = .systemYellow
        if let navigationBar = navigationController?.navigationBar {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
            navigationBar.titleTextAttributes = attributes
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension OnlineViewController: UICollectionViewDelegate {
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MainViewController,
           let index = collectionView.indexPathsForSelectedItems?.first {
            destinationVC.nameCH = onlineMovies[index.row].Title
        }
    }
}

extension OnlineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.onlineMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! OnlineCollectionViewCell
        // Configure the cell
        let movie = self.onlineMovies[indexPath.row]
        cell.setup(with: movie)
        return cell
    }
}

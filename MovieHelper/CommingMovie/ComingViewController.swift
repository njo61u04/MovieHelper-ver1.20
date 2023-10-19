//
//  CommingMovieViewController.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/8/27.
//

import UIKit
import Foundation
import FirebaseDatabase
import WebKit

class ComingViewController: UIViewController {
    
    var comingMovies = CatchDataHelper.shared.comingMovies
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .systemYellow
        
        //change title style
        if let navigationBar = navigationController?.navigationBar {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
            navigationBar.titleTextAttributes = attributes
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ComingViewController: UICollectionViewDelegate {
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MainViewController,
           let index = collectionView.indexPathsForSelectedItems?.first {
            destinationVC.nameCH = comingMovies[index.row].Title
        }
    }
}

extension ComingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ComingCollectionViewCell
        // Configure the cell
        let movie = self.comingMovies[indexPath.row]
        cell.setup(with: movie)
        return cell
    }
}


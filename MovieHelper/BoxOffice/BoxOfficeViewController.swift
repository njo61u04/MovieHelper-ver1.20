//
//  BoxOfficeViewController.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/9/10.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    var filteredOnlineMovies = [OnlineMovieKeys]()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var boxOfficeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change specific text color
        if let onlineText = titleLabel.text {
            let onlineAttributedText = NSMutableAttributedString(string: onlineText)
            onlineAttributedText.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: NSRange(location: onlineText.count - 1, length: 1))
            titleLabel.attributedText = onlineAttributedText
        }
        
        boxOfficeCollectionView.dataSource = self
        boxOfficeCollectionView.delegate = self
         
        CatchDataHelper.shared.readData(dataSource: "users/chart", objectType: BoxOfficeKeys.self) { [weak self] result in
            guard let boxOffice = result else {
                assertionFailure("Can't Get Chart!!!!")
                return
            }
            
            CatchDataHelper.shared.readData(dataSource: "users/online", objectType: OnlineMovieKeys.self) { [weak self] result in
                guard let onlineMovies = result else {
                    assertionFailure("Can't Read Online!!!!")
                    return
                }
                for index in 0..<boxOffice.count {
                    let filteredData = CatchDataHelper.shared.datafilter(onlineMovies, name: boxOffice[index].Title)
                    self?.filteredOnlineMovies.append(contentsOf: filteredData)
                    self?.boxOfficeCollectionView.reloadData()
                }
            }
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MainViewController,
           let index = boxOfficeCollectionView.indexPathsForSelectedItems?.first {
            destinationVC.nameCH = filteredOnlineMovies[index.row].Title
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredOnlineMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! BoxOfficeCollectionViewCell
        // Configure the cell
        let movie = filteredOnlineMovies[indexPath.row]
        cell.setup(with: movie, rank: indexPath.item + 1)
        return cell
    }
}


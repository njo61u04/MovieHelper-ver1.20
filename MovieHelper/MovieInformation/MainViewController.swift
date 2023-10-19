//
//  MainViewController.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/8/31.
//

import UIKit

class MainViewController: UIViewController {
    
    var nameCH: String?
    
    @IBOutlet weak var trailerContainerView: UIView!
    @IBOutlet weak var timeListContainerView: UIView!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageChangeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let infoViewController = self.children[0] as? InfoViewController,
              let timeListViewController = self.children[1] as? TimeListViewController,
              let trailerViewController = self.children[2] as? TrailerViewController,
              let nameCH = nameCH else {
            assertionFailure("Segue To Container View Failed!!!!")
            return
        }
        
        navigationController?.navigationBar.tintColor = .systemYellow
        let customTitleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,  // 设置文字颜色
            .font: UIFont.boldSystemFont(ofSize: 20)  // 设置字体和大小
        ]
        navigationController?.navigationBar.titleTextAttributes = customTitleTextAttributes
        navigationItem.title = nameCH
        
        scrollView.delegate = self
        
        customSegmentControl()
        
        infoContainerView.backgroundColor = .systemGray
        trailerContainerView.backgroundColor = .darkGray
        
        infoViewController.nameCH = nameCH
        timeListViewController.nameCH = nameCH
        trailerViewController.nameCH = nameCH
        
    }
    
    func customSegmentControl() {
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemYellow,
        ]
        pageChangeSegment.backgroundColor = .clear
        pageChangeSegment.selectedSegmentTintColor = .clear
        pageChangeSegment.setTitleTextAttributes(normalTextAttributes, for: .normal)
        pageChangeSegment.setTitleTextAttributes(selectedTextAttributes, for: .selected)
    }
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.size.width)
         pageChangeSegment.selectedSegmentIndex = Int(pageIndex)
    }
    
    @IBAction func pageChangeBtn(_ sender: UISegmentedControl) {
        let locationX = CGFloat(sender.selectedSegmentIndex) * scrollView.bounds.width
        let offset = CGPoint(x: locationX, y: 0)
        scrollView.setContentOffset(offset, animated: false)
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
       

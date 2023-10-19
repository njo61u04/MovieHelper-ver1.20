//
//  PlaceInfoViewController.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/9/8.
//

import UIKit
import CoreLocation
import MapKit

class PlaceInfoViewController: UIViewController {

    let place: PlaceAnnotation
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .black
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.alpha = 0.4
        label.textColor = .darkGray
        return label
    }()
    
    //導航按鍵
    var directionBtn: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.init(systemName: "location.fill"), for: .normal)
        button.setTitle("導航", for: .normal)
        button.tintColor = .systemPurple
        button.titleLabel?.tintColor = .black
        return button
    }()
    
    //撥號按鍵
    var callBtn: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.init(systemName: "phone.arrow.up.right.fill"), for: .normal)
        button.setTitle("撥號", for: .normal)
        button.tintColor = .systemPurple
        button.titleLabel?.tintColor = .black
        return button
    }()
    init(place: PlaceAnnotation) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "MapColor")
    }
    
    //MARK: 設定彈出畫面的介面
    func setupUI() {
        
        //stackView setup
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20//UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 60, leading: 20, bottom: 20, trailing: 20)
        
        //設定label文字
        nameLabel.text = place.name
        addressLabel.text = place.address
        
        //把label放到stackView上
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(addressLabel)
        nameLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        
        //stackView setup
        let buttonStackView = UIStackView()
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 40//UIStackView.spacingUseSystem
        
        directionBtn.addTarget(self, action: #selector(directionBtnPressed), for: .touchUpInside)
        callBtn.addTarget(self, action: #selector(callBtnPressed), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(directionBtn)
        buttonStackView.addArrangedSubview(callBtn)
          
        stackView.addArrangedSubview(buttonStackView)
        
        view.addSubview(stackView)
    }
    
    //MARK: 導航
    @objc func directionBtnPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "導航到\(String(describing: place.name))", message: "請問您是否要導航到\(String(describing: place.name))？", preferredStyle: .alert)
        let ok = UIAlertAction(title: "確認", style: .default) { _ in
            
            let destinationPlacemark = MKPlacemark(coordinate: self.place.location.coordinate)
            let destinationItem = MKMapItem(placemark: destinationPlacemark)
            destinationItem.name = self.place.name
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            destinationItem.openInMaps(launchOptions: launchOptions)
        }
        let cancel = UIAlertAction(title: "取消", style: .default)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    //MARK: 通話
    @objc func callBtnPressed(_ sender: UIButton) {
        if  let url = URL(string: "tel://\(place.phone.formatPhoneForCall)") {
            let alert = UIAlertController(title: "撥號給\(String(describing: place.name))", message: "請問您是否要撥打電話給\(String(describing: place.name))？", preferredStyle: .alert)
            let ok = UIAlertAction (title: "確認", style: .default) { _ in
                UIApplication.shared.open(url)
            }
            let cancel = UIAlertAction(title: "取消", style: .default)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
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

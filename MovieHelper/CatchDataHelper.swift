//
//  FirebaseHelper.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/9/6.
//

import Foundation
import FirebaseDatabase
import FirebaseCore
import UIKit

class CatchDataHelper {
    static let shared = CatchDataHelper()
    private init() {}
    
    var sixOnlineMovies = [OnlineMovieKeys]()
    var sixComingMovies = [ComingMovieKeys]()
    var onlineMovies = [OnlineMovieKeys]()
    var comingMovies = [ComingMovieKeys]()

    //get firebase database
    func readData<T: Decodable>(dataSource: String, objectType: T.Type, completion: @escaping ([T]?) -> Void) {

        let database: DatabaseReference = Database.database().reference()
        database.child(dataSource).observeSingleEvent(of: .value, with: { snapshot in
            guard let snapshotValue = snapshot.value as? [Any] else {
                assertionFailure("snapshot.value type is not [Any]")
                completion(nil)
                return
            }
            
            var array = [T]()
            for value in snapshotValue {
                guard let dataDictionary = value as? [String: Any] else {
                    assertionFailure("dataItem is not [String: Any]!!!!")
                    continue
                }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dataDictionary, options: [])
                    let item = try JSONDecoder().decode(T.self, from: jsonData)
                    array.append(item)
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
            completion(array) //傳遞結果
        })
        
    }
    
    //get six firebase database
    func readSixData<T: Decodable>(dataSource: String, objectType: T.Type, completion: @escaping ([T]?) -> Void) {
        
        let database: DatabaseReference = Database.database().reference()
        database.child(dataSource).observeSingleEvent(of: .value, with: { snapshot in
            guard let snapshotValue = snapshot.value as? [Any] else {
                assertionFailure("snapshot.value type is not [Any]")
                completion(nil)
                return
            }

            var array = [T]()
            for value in snapshotValue {
                guard let dataDictionary = value as? [String: Any] else {
                    assertionFailure("dataItem is not [String: Any]!!!!")
                    continue
                }
                if array.count < 6 {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dataDictionary, options: [])
                        let item = try JSONDecoder().decode(T.self, from: jsonData)
                        array.append(item)
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                }
            }
            completion(array) //傳遞結果
        })
    }
    
    func datafilter<T: TextContainable>(_ inputList: [T], name: String) -> [T] {
        return inputList.filter { item in
            return item.name.contains(name)
        }
    }
    
    func setupLabelUI(view: UIView, text: String) {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.textAlignment = .center
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

protocol TextContainable {
    var name: String { get }
}

struct OnlineMovieKeys: Decodable, TextContainable {
    var AgeRating: String = ""
    var EnglishTitle: String = ""
    var Info: String = ""
    var PosterURL: String = ""
    var Title: String = ""
    var URL: String = ""
    var date: String = ""
    var yt_url: String = ""
    var length: String = ""
    var act: String = ""
    var direct: String = ""
    var imdb: String = ""
    var rt: String = ""
    var name: String {
        return Title
    }
}

struct ComingMovieKeys: Decodable, TextContainable {
    var AgeRating: String = ""
    var EnglishTitle: String = ""
    var Info: String = ""
    var PosterURL: String = ""
    var Title: String = ""
    var URL: String = ""
    var date: String = ""
    var yt_url: String = ""
    var length: String = ""
    var act: String = ""
    var direct: String = ""
    var imdb: String = ""
    var rt: String = ""
    var name: String {
        return Title
    }
}

struct BoxOfficeKeys: Decodable {
    var Num: String = ""
    var Title: String = ""
}

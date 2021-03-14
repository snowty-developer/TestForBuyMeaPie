//
//  ViewModel.swift
//  TestForBuyMeaPie
//
//  Created by Александр Зубарев on 02.03.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewModel {
    var stories: [Story] = []
    var dateString = ""
    let dateFormatter = DateFormatter()
    
    
    func loadData(completion: @escaping () -> Void) {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
//        SVProgressHUD.show()
        Alamofire.request("https://pivl.github.io/sample_api/covers/").responseJSON { response in
            if response.result.isSuccess {
                let dataResult = JSON(response.value!)
                
                var storyArray: [Story] = []
                if let dataArray = dataResult.array {
                    for data in dataArray {
                        storyArray.append(Story.init(textId: data["textId"].stringValue, title: data["title"].stringValue, image: self.loadImage(data["image"].stringValue), rating: data["rating"].doubleValue, description: data["description"].stringValue, author: data["author"].stringValue))
                    }
                }
                
                DispatchQueue.main.async {
                    self.stories = storyArray
                    self.dateString = dateString
//                    SVProgressHUD.dismiss()
                    completion()
                }
            }
            else { print("Connection error!") }
        }
    }
    
    func loadImage(_ picture: String) -> UIImage? {
        var image: UIImage?
            if let data = try? Data(contentsOf: URL(string: picture)!) {
                if let img = UIImage(data: data) {
                    image = img
                }
            }
        return image
    }
}

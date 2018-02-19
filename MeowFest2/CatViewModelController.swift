//
//  CatViewModelController.swift
//  MeowFest2
//
//  Created by May Yang on 2/18/18.
//  Copyright © 2018 May Yang. All rights reserved.
//

import Foundation

class CatViewModelController {
    fileprivate var viewModels: [CatViewModel?] = []
    
    func getImages(_ completionBlock: @escaping (_ success: Bool, _ error: NSError?) -> ()) {
        let url = NSURL(string: "https://chex-triplebyte.herokuapp.com/api/cats?page=0")
        let request = NSMutableURLRequest(url: url! as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            guard error == nil && data != nil else
            {
                print(error as Any)
                completionBlock(false, error as NSError?)
                return
            }
            let httpStatus = response as? HTTPURLResponse
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    if let received = try! JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [AnyObject] {
                        var cats = [Cat?]()
                        for data in received {
                            if let cat = CatViewModelController.parse(data as! [String : AnyObject]) {
                                cats.append(cat)
                            }
                        }
                        self.viewModels = CatViewModelController.initViewModels(cats)
                        completionBlock(true, nil)
                    }
                }
                else {
                    print("No Data from URL")
                    completionBlock(false, nil)
                }
            }
            else {
                print("HTTP Status is 200. But error is: ",httpStatus!.statusCode)
                completionBlock(false, error! as NSError)
            }
        }
        task.resume()
    }
    var viewModelsCount: Int {
        return viewModels.count
    }
    func viewModel(at index: Int) -> CatViewModel? {
        guard index >= 0 && index < viewModelsCount else { return nil }
        return viewModels[index]
    }
}

private extension CatViewModelController {
    static func parse(_ data: [String: AnyObject]) -> Cat? {
        let imageURL = data["image_url"] as? String ?? ""
        let title = data["title"] as? String ?? ""
        let imageDescription = data["description"] as? String ?? ""
        let timestamp = data["timestamp"] as? String ?? ""
        return Cat(title: title, timestamp: timestamp, image_url: imageURL, description: imageDescription)
    }
    static func initViewModels(_ cats: [Cat?]) -> [CatViewModel?] {
        return cats.map { cat in
            if let cat = cat {
                return CatViewModel(cat: cat)
            } else {
                return nil
            }
        }
    }
}

//
//  ViewController.swift
//  ResultStructre
//
//  Created by Mac on 25.06.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

struct User: Decodable {
    let userId:Int
    let id : Int
    let title :String
    let completed : Bool
}
enum CGError : String  , Error {
    case urlProblem          =  "Error occurred with URL"
    case requestProblem   = "Error occured with Request"
}

class ViewController: UIViewController {
    private let urlString = "https://sadasdasjsonplaceholder.typicode.com/todos"
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.fetchJSONdata {  res in
            switch res {
                case .success(let users):
                    users.forEach { (user) in
                        print(user.title)
                    }
                case .failure(let err):
                    print("error \(err.rawValue)")
            }
        }
        
        
        
        
        // Swift 4.2
//        fetchJSONdata { (users, error) in
//            if let err = error {
//                print("Error occured \(String(describing: err.localizedDescription))")
//            }
//            if let users = users {
//                users.forEach { (user) in
//                    print(user.title)
//                }
//            }
//        }
    }
    fileprivate func fetchJSONdata(complition : @escaping (Result<[User] , CGError>) -> Void){
        guard let url = URL(string: self.urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
                
            if let _ = err {
                complition(.failure(.urlProblem))
                return
            }
            if let  data = data {
                do {
                    let datas = try JSONDecoder().decode([User].self, from: data)
                    complition(.success(datas))
                }catch _{
                    complition(.failure(.requestProblem))
                }
            }
        }.resume()
    }

    // Swift 4.2
//    fileprivate func fetchJSONdata(complition : @escaping ([User]?, Error?) -> Void){
//         guard let url = URL(string: self.urlString) else {return}
//
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//
//            if let err = err {
//                complition(nil , err)
//                return
//            }
//            if let  data = data {
//                do {
//                    let datas = try JSONDecoder().decode([User].self, from: data)
//                    complition(datas , nil)
//                }catch let jsonError{
//                    complition(nil , jsonError)
//                }
//            }
//        }.resume()
//    }
}



////
////  APIManager.swift
////  VK
////
////  Created by Dmitry on 16.07.25.
////
//
//import Foundation
//import UIKit
//import FirebaseCore
//import FirebaseStorage
//import FirebaseFirestore
//
//
//
//
//class APIManager {
//    
//    static let shared  = APIManager()
//    
//    private func configureFB() -> Firestore {
//        var db: Firestore!
//        let settings = FirestoreSettings()
//        Firestore.firestore().settings = settings
//        db = Firestore.firestore()
//        return db
//    }
//    
//    
//    func getPost(id: String, imageID: String, completion: @escaping (Post?) -> Void) {
//        let db = configureFB()
//        db.collection("posts").document(id).getDocument() { (document, error) in
//            guard error == nil else {completion(nil); return }
//            self.getImage(id: imageID, completion: {image in
//                let post = Post(name: document?.get("name") as! String, date: document?.get("date") as! String, text:  document?.get("text") as! String, image: image)
//                completion(post)
//            })
//            
//        }
//    }
//    
//    func getImage(id: String, completion: @escaping (UIImage) -> Void) {
//        let storage = Storage.storage()
//        let reference = storage.reference()
//        let pathRef = reference.child("pictures")
//        
//        var image: UIImage = UIImage(named: "chat")!
//        
//        let fileRef = pathRef.child(id + ".jpeg")
//        fileRef.getData(maxSize: 1024*1024, completion: {data, error in
//            guard error == nil else {completion(image); return }
//            image = UIImage(data: data!)!
//            completion(image)
//        })
//    }
//    
//    
//}
//
//struct Post {
//    let name: String
//    let date: String
//    let text: String
//    let image: UIImage
//}


import Foundation
import UIKit

class APIManager {
    
    static let shared = APIManager()
    
    // URL на ваш JSON с постами
    private let postsURL = URL(string: "https://gist.githubusercontent.com/Dmitryswiftnew/3b15a38e48f146bc6de690aab61ec904/raw/3b4d002aec66b879833fbd1b5b41fec3837939f8/posts.json")!
    
    // Метод для получения всех постов из JSON
    func getPosts(completion: @escaping ([Post]) -> Void) {
        URLSession.shared.dataTask(with: postsURL) { data, response, error in
            guard error == nil,
                  let data = data else {
                print("Ошибка загрузки JSON: \(error?.localizedDescription ?? "nil")")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            do {
                // Декодируем массив постов
                let postsData = try JSONDecoder().decode([PostData].self, from: data)

                // Для каждого поста загружаем картинку по URL
                self.loadImages(for: postsData) { postsWithImages in
                    DispatchQueue.main.async {
                        completion(postsWithImages)
                    }
                }
            } catch {
                print("Ошибка декодирования JSON: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
    
    // Загрузка картинок для каждого поста
    private func loadImages(for postsData: [PostData], completion: @escaping ([Post]) -> Void) {
        var posts: [Post] = []
        let group = DispatchGroup()
        
        for postData in postsData {
            group.enter()
            loadImage(from: postData.image) { image in
                let post = Post(
                    name: postData.name,
                    date: postData.date,
                    text: postData.text,
                    image: image ?? UIImage(named: "placeholder")!
                )
                posts.append(post)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            // Вернём все посты после загрузки всех картинок
            completion(posts)
        }
    }
    
    // Загрузка картинки по URL
    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let data = data,
                  let image = UIImage( data: data) else {
                // Возвращаем nil в случае ошибки
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}

// Структура для декодирования JSON
struct PostData: Codable {
    let name: String
    let date: String
    let text: String
    let image: String
}

// Модель с картинки UIImage, готовая для UI
struct Post {
    let name: String
    let date: String
    let text: String
    let image: UIImage
}

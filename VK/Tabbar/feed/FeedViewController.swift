//
//  FeedViewController.swift
//  VK
//
//  Created by Dmitry on 15.07.25.
//

//import UIKit
//
//class FeedViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
//    
//    
//    var posts: [Post] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        APIManager.shared.getPost(id: <#T##String#>, imageID: <#T##String#>, completion: <#T##(Post?) -> Void#>)
//        
//        
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
//        cell.postName.text = posts[indexPath.row].name
//        cell.postDate.text = posts[indexPath.row].date
//        cell.postText.text = posts[indexPath.row].text
//        cell.postImage.image = posts[indexPath.row].image
//        
//        return cell
//    }
//    
//
//}



import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!  // Подключить IBOutlet из storyboard

    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Назначаем делегаты для таблицы
        tableView.dataSource = self
        tableView.delegate = self
        
        // Загружаем посты
        loadPosts()
    }

    // MARK: - Загрузка постов через APIManager
    
    private func loadPosts() {
        APIManager.shared.getPosts { [weak self] loadedPosts in
            guard let self = self else { return }
            
            self.posts = loadedPosts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()  // обновляем UI
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Получаем ячейку и кастуем к вашей кастомной ячейке
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FeedTableViewCell else {
            fatalError("Не удалось получить ячейку FeedTableViewCell")
        }
        
        let post = posts[indexPath.row]
        
        // Заполняем UI ячейки
        cell.postName.text = post.name
        cell.postDate.text = post.date
        cell.postText.text = post.text
        cell.postImage.image = post.image
        
        // Можно добавить стилизацию картинки, если нужно
        cell.postImage.layer.cornerRadius = 8
        cell.postImage.clipsToBounds = true
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    // Здесь можно добавить обработку выбора строк и другие методы делегата
    
}

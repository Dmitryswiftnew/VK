//
//  SearchViewController.swift
//  VK
//
//  Created by Dmitry on 15.07.25.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell

        switch indexPath.row {
        case 0:
            cell.pic1.image = UIImage(named: "1")
            cell.pic2.image = UIImage(named: "2")
        case 1:
            cell.pic1.image = UIImage(named: "3")
            cell.pic2.image = UIImage(named: "4")  // поправил здесь pic1 -> pic2 , похоже опечатка
        default:
            cell.pic1.image = UIImage(named: "4")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

}


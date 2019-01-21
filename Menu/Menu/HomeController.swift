//
//  HomeController.swift
//  Menu
//
//  Created by osx on 21/01/19.
//  Copyright © 2019 osx. All rights reserved.
//

extension UIColor{
    public class var primaryColor : UIColor {
        return UIColor(red:12.0/255.0, green:46.0/255.0 ,blue:86.0/255.0 , alpha:1.00)
    }
    public class var selectedColor : UIColor {
        return UIColor(red:50/255.0, green:100/255.0 ,blue:150/255.0 , alpha:1.00)
    }
    
}

import UIKit

class HomeController: UIViewController {

    var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor

        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor,constant:20).isActive = true
        
    }
}
    extension HomeController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 15
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "")
            cell.textLabel?.textColor = .white
            cell.contentView.backgroundColor = .primaryColor
            cell.textLabel?.text = "Section: \(indexPath.section),Row: \(indexPath.row)"
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
        
    }

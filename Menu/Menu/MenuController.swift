//
//  MenuController.swift
//  Menu
//
//  Created by osx on 21/01/19.
//  Copyright © 2019 osx. All rights reserved.
//

class Menu {
    var name:String?
    var image:UIImage?
    var vc:UIViewController?
    
    init(name:String?,image:UIImage?,vc:UIViewController?) {
        self.name = name
        self.image = image
        self.vc = vc
    }
}



import UIKit

class MenuController: UIViewController {

    var tableView: UITableView!
    var delegate: MenuDelegate?
    var menus = [Menu]()
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.selected(menu: menus.first)
        view.backgroundColor  = .primaryColor
        view.tintColor = .white
        configureTableView()
    }
    
    // MARK: - Handlers
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuCell.self, forCellReuseIdentifier: "reuseIdentifer")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor,constant:20).isActive = true
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifer", for: indexPath) as! MenuCell
        cell.menu = menus[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = menus[indexPath.row]
        delegate?.selected(menu: menu)
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuCell else { return }
        cell.setSelected(true, animated: false)
    }
    
}


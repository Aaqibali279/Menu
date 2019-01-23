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

typealias CheckActionCodeCallback = (String,DidSelectRowAt<Menu>) -> Void


import UIKit

class MenuController: UIViewController {

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
        let tableView = TableView<Menu,MenuCell>()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.heightForRow = 60
        tableView.list = menus
        tableView.didSelectRowAt = { (indexPath,menu) -> Void in
            self.delegate?.selected(menu: menu)
            guard let cell = tableView.cellForRow(at: indexPath) as? MenuCell else { return }
            cell.setSelected(true, animated: false)
        }
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor,constant:20).isActive = true
    }
}


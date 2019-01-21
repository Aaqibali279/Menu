//
//  ViewController.swift
//  Menu
//
//  Created by osx on 21/01/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    // MARK: - Properties
    var currentViewController:UIViewController?
    var menuController: MenuController!
    var menuImage = #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysTemplate)
    var backImage = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate)
    var isExpanded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuController()
        configureNavigationController()
    }
    
    func configureNavigationController(){
        view.addSubview(nvc.view)
        addChildViewController(nvc)
        nvc.didMove(toParentViewController: self)
        nvc.view.layer.shadowOpacity = 0.6
        nvc.view.layer.shadowRadius = 5
        nvc.view.layer.shadowOffset = CGSize(width: -1, height: 1)
    }
    
    
    var nvc = { () -> UINavigationController in
        let nvc = UINavigationController()
        
        nvc.navigationBar.isTranslucent = true
        nvc.navigationBar.tintColor = .white
        nvc.navigationBar.barTintColor = .clear
        nvc.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        nvc.navigationBar.shadowImage = UIImage()
        nvc.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        return nvc
    }()
    
    func configureMenuController() {
        if menuController == nil {
            menuController = MenuController()
            let items:[(UIImage,UIViewController,String)] = [(#imageLiteral(resourceName: "profile"),HomeController(),"Home"),(menuImage,NotificationsController(),"Notifications"),(#imageLiteral(resourceName: "settings"),SettingsController(),"Settings"),(#imageLiteral(resourceName: "mail"),ProfileController(),"Mail"),(backImage,NewController(),"Logout")]
             let menus = items.map({ (image,vc,name) -> Menu in
                return Menu(name: name, image: image, vc: vc)
            })
            menuController.delegate  = self
            menuController.menus = menus
            view.insertSubview(menuController.view, at: 0)
            addChildViewController(menuController)
            menuController.didMove(toParentViewController: self)
        }
    }
    
    func animatePanel() {

        isExpanded = !isExpanded
        let x = nvc.view.frame.width
        let expanded = isExpanded
        
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut, animations: {
            self.nvc.view.frame.origin.x = expanded ? x - 80 : 0
        })
        
        guard let leftItem = currentViewController?.navigationItem.leftBarButtonItem?.customView as? UIButton else { return }
        
        UIView.transition(with: leftItem, duration: 0.35, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            leftItem.setImage( expanded ? self.backImage : self.menuImage, for: .normal)
        })
    }
    
    @objc func handleMenuToggle(){
        animatePanel()
    }
}

protocol MenuDelegate{
    func selected(menu: Menu?)
}
extension ContainerController : MenuDelegate{
    func selected(menu: Menu?) {
        guard let vc = menu?.vc else { return }
        currentViewController = vc
        nvc.viewControllers = [vc]
        let barItem = UIButton()
        barItem.tintColor = .white
        barItem.setImage(menuImage, for: .normal)
        barItem.addTarget(self, action: #selector(handleMenuToggle), for: .touchUpInside)
        barItem.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        let item = UIBarButtonItem(customView: barItem)
        vc.navigationItem.leftBarButtonItem = item
        
        vc.navigationItem.title = menu?.name
        animatePanel()
    }
}

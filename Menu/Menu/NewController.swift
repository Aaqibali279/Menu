//
//  NewController.swift
//  Menu
//
//  Created by osx on 21/01/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class NewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        
        
        let darkLabel = UILabel()
        darkLabel.text = "Aaqib Ali Najar"
        darkLabel.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 400)
        darkLabel.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        darkLabel.textAlignment = .center

        darkLabel.font = UIFont.systemFont(ofSize: 50)
        view.addSubview(darkLabel)
        
        
        let label = UILabel()
        label.text = "Aaqib Ali Najar"
        label.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 400)
        label.textColor = .white
        label.textAlignment = .center
        
        label.font = UIFont.systemFont(ofSize: 50)
        view.addSubview(label)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor]
        gradientLayer.locations = [0,0.5,1]
//        gradientLayer.backgroundColor = UIColor.red.cgColor
        gradientLayer.frame = label.frame
        let radians = Measurement(value: 100, unit: UnitAngle.degrees)
            .converted(to: .radians).value
        gradientLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(radians)))
        label.layer.mask = gradientLayer
//        view.layer.addSublayer(gradientLayer)
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.duration = 2
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: "")
        
        
    }

}

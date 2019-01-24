//
//  NotificationsController.swift
//  Menu
//
//  Created by Aqib Ali on 21/01/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController {

    let container = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor  = .primaryColor
        
        container.bounds = view.frame
        container.position = view.center
        view.layer.addSublayer(container)
        
        addLayers()
        addTransforms()
        
    }
    
    
    func addLayers(){
        let faceColors = [UIColor.red,UIColor.blue,UIColor.brown,UIColor.green,UIColor.white,UIColor.cyan]
        faceColors.forEach { (color) in
            let layer = CAShapeLayer()
            layer.backgroundColor = color.cgColor
            layer.frame = CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 50, width: 100, height: 100)
            layer.position = view.center
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: -1, height: 1)
            layer.shadowRadius = 3
            let glayer = CAGradientLayer()
            glayer.colors = [color.cgColor,UIColor.black.cgColor]
            glayer.locations = [0,1]
            glayer.frame = layer.bounds
            layer.mask = glayer
            container.addSublayer(layer)
        }
    }
    
    
    func addTransforms(){
        guard let layers = container.sublayers else { return }
        let segment = 360/4
        var angle = segment - 45
        let faces = layers.prefix(upTo: 4)
        let topBottomFaces = layers.suffix(from: 4)
        faces.forEach { (face) in
            var transform = CATransform3DIdentity
            transform.m34 = -(1/500)
            transform = CATransform3DRotate(transform, Double(angle).radians(), 0, 1, 0)
            transform = CATransform3DTranslate(transform, 0, 0, 50)
            face.transform = transform
            angle += segment
        }
        var xAngle = 90
        topBottomFaces.forEach { (layer) in
            var transform = CATransform3DIdentity
            transform.m34 = -(1/500)
            transform = CATransform3DRotate(transform, Double(xAngle).radians(), 1, 0, 0)
            transform = CATransform3DRotate(transform, Double(45).radians(), 0, 0, 1)
            transform = CATransform3DTranslate(transform, 0, 0, 50)
            layer.transform = transform
            xAngle = -xAngle
        }
        
        
        var transform = CATransform3DIdentity
        //transform.m34 = -(1/500)
        transform = CATransform3DRotate(transform, Double(-30).radians(),1, 0, 0)
        container.sublayerTransform = transform
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        rotate()
    }
    
    @objc
    func rotate(){
        
        let anim = CABasicAnimation(keyPath: "transform.rotation.x")
        anim.toValue = Double(89).radians()
        anim.duration = 5
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        container.add(anim, forKey: nil)
        
//        var transform = CATransform3DIdentity
//        transform.m34 = -(1/500)
//        transform = CATransform3DRotate(transform, Double(-45).radians(), 1, 0, 0)
//        container.transform = transform
    }
}

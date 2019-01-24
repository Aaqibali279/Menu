//
//  ProfileController.swift
//  Menu
//
//  Created by osx on 21/01/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    var transformLayer = CATransformLayer()
    var currentAngle:CGFloat = 0
    var currentOffset:CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        
        transformLayer.frame = view.bounds
        
        view.layer.addSublayer(transformLayer)
        
        
        
        [#imageLiteral(resourceName: "a"),#imageLiteral(resourceName: "b"),#imageLiteral(resourceName: "c"),#imageLiteral(resourceName: "d")].forEach { (image) in
            addImageCard(image: image)
        }
        turn(direction: .left)
        let gesture  = UIPanGestureRecognizer(target: self, action: #selector(gesture(gesture:)))
        view.addGestureRecognizer(gesture)
        
    }
    
    @objc
    func gesture(gesture:UIPanGestureRecognizer){
        
        let xOffset = gesture.translation(in: view).x
        
        let angle = xOffset > 0 ? 90 : -90
        
        if gesture.state == .ended{
            var transform = transformLayer.sublayerTransform
            transform = CATransform3DRotate(transform, Double(angle).radians(), 0, 1, 0)
            transformLayer.sublayerTransform = transform
        }
        
    }
    
    func addImageCard(image:UIImage){
        let imageCardSize = CGSize(width: view.frame.width/2, height: view.frame.height/2)
        
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: view.frame.width/2 - imageCardSize.width/2, y: view.frame.height/2 - imageCardSize.height/2, width: imageCardSize.width, height: imageCardSize.height)
        imageLayer.contents = image.cgImage
        imageLayer.position = view.center
        imageLayer.anchorPointZ = -80
        imageLayer.contentsGravity = "resizeAspectFill"
        imageLayer.masksToBounds = true
        imageLayer.isDoubleSided = true
        imageLayer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
        imageLayer.borderWidth = 5
        imageLayer.cornerRadius = 5

        transformLayer.addSublayer(imageLayer)
    }
    
    var angle:CGFloat = 0
    
    func turn(direction:Direction){
        guard let subLayers = transformLayer.sublayers else { return }
        
        let segment = CGFloat(360/subLayers.count)
        
        angle = direction == .right ? angle + segment : angle - segment
        
        var angleOffset = angle
        
        for layer in subLayers{
            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, Double(angleOffset).radians(), 0, 1, 0)
            transform = CATransform3DTranslate(transform, 0, 0, 80)
            layer.transform = transform
            angleOffset += segment
        }
        
        
        var transform = CATransform3DIdentity
        transform.m34 = -1/500
        transformLayer.sublayerTransform = transform
    }
}

enum Direction{
    case left
    case right
}

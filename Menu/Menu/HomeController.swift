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

    var transformLayer = CATransformLayer()
    var currentAngle:CGFloat = 0
    var currentOffset:CGFloat = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        
        transformLayer.frame = view.bounds
        view.layer.addSublayer(transformLayer)
        
        [#imageLiteral(resourceName: "a"),#imageLiteral(resourceName: "b"),#imageLiteral(resourceName: "c"),#imageLiteral(resourceName: "d")].forEach { (image) in
            addImageCard(image: image)
        }
        turn()
        let gesture  = UIPanGestureRecognizer(target: self, action: #selector(gesture(gesture:)))
        view.addGestureRecognizer(gesture)
        
        var transform = CATransform3DIdentity
        transform = CATransform3DScale(transform, 0.75, 0.75, 0.75)
        view.layer.sublayerTransform = transform
        
    }
    
    @objc
    func gesture(gesture:UIPanGestureRecognizer){
        let xOffset = gesture.velocity(in: view).x
        
        print(xOffset)

        print(xOffset)
        if gesture.state == .began{
            currentOffset = 0
        }

        let xDiff = xOffset * 0.6 - currentOffset

        currentOffset += xDiff
        currentAngle += xDiff

        print(currentOffset,currentAngle)
        turn()
        
    }
    
    func addImageCard(image:UIImage){
        let imageCardSize = view.bounds
        
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: view.frame.width/2 - imageCardSize.width/2, y: view.frame.height/2 - imageCardSize.height/2, width: imageCardSize.width, height: imageCardSize.height)
        imageLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        imageLayer.contents = image.cgImage
        imageLayer.contentsGravity = "resizeAspectFill"
        imageLayer.masksToBounds = true
        imageLayer.isDoubleSided = true
        imageLayer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        imageLayer.borderWidth = 5
        imageLayer.cornerRadius = 10
        
        transformLayer.addSublayer(imageLayer)
        
        
        
    }
    
    var transforms = [String:CATransform3D]()
    
    var angle = 0
    
    func turn(){
        guard let subLayers = transformLayer.sublayers else { return }

        let segment = CGFloat(360/subLayers.count)
        var angleOffset = currentAngle
        for layer in subLayers{
            var transform = CATransform3DIdentity
            transform.m34 = -(1/800)
            transform = CATransform3DRotate(transform, Double(angleOffset).radians(), 0, 1, 0)
            transform = CATransform3DTranslate(transform, 0, 0, 160)
            
            CATransaction.setAnimationDuration(0)
            layer.transform = transform
            angleOffset += segment
        }
    }
}

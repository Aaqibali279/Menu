//
//  SettingsController.swift
//  Menu
//
//  Created by osx on 21/01/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import QuartzCore

class SettingsController: UIViewController {

    let container = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .primaryColor

        addlayers()
//        drawPolygon()
    }
    
    func addlayers(){
        let colors = [UIColor.red,UIColor.blue,UIColor.brown,UIColor.cyan,UIColor.darkGray,UIColor.green]
        let points = polygonPointArray(sides: colors.count, center: view.center, radius: 100, offset: 0)
        let path = polygonPath(center: view.center, radius: 100, sides: colors.count, offset: 0)
        container.path = path.cgPath
        container.bounds = CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 50, width: 100, height: 100)
        container.position = view.center
        container.fillColor = UIColor.purple.cgColor
        view.layer.addSublayer(container)
        scale(layer: container, duration: 60)
        for (index,color) in colors.enumerated(){
            let layer = CAShapeLayer()
            let path = polygonPath(center: points[index], radius: 33.33, sides: colors.count, offset: 0)
            layer.path = path.cgPath
            let point = points[index]
            layer.bounds = CGRect(x: point.x - 33.33, y: point.y - 33.33, width: 66.66, height: 66.66)
            layer.position = point
            layer.fillColor = color.cgColor
            layer.isDoubleSided = true
            container.addSublayer(layer)
            scale(layer: layer, duration: 20)
        }
    }

    
    
    func scale(layer:CALayer,duration:Double){
    
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: -1, height: -1)
        
        let animation = CAAnimationGroup()
        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnim.toValue = 60
        rotateAnim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)

        animation.animations = [rotateAnim]
        animation.duration = duration
        animation.repeatCount = .infinity
        layer.add(animation, forKey: nil)

    }
    
    
    
    var angle:Double = 0
    
    @objc
    func rotate(){
//        guard let subLayers = container.sublayers else {
//            return
//        }
//        angle += Double(360/subLayers.count)
//        let radians  = angle.radians()
//        rotateLayer(angle: radians, layer: container)
//
//        for layer in subLayers{
//            rotateLayer(angle: radians, layer: layer)
//        }
    }
    
    func rotateLayer(angle:CGFloat,layer:CALayer){
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, angle, 0, 0, 1)
        layer.transform = transform
        CATransaction.setAnimationDuration(2)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setCompletionBlock {
            
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        let point = touch!.location(in: self.view)
//        if (layer.path!.contains(point)) {
//            print ("We tapped the square")
//        }
//
//    }

    
//    - (void)A_singlePlane{
//
//    //Create the container
//    CALayer *container = [CALayer layer];
//    container.frame = CGRectMake(0, 0, 640, 300);
//    [self.view.layer addSublayer:container];
//
//    //Create a Plane
//    CALayer *purplePlane = [self addPlaneToLayer:container
//    size:CGSizeMake(100, 100)
//    position:CGPointMake(250, 150)
//    color:[UIColor purpleColor]];
//
//    //Apply transform to the PLANE
//    CATransform3D t = CATransform3DIdentity;
//    t = CATransform3DRotate(t, 45.0f * M_PI / 180.0f, 0, 1, 0);
//    purplePlane.transform = t;
//    }

    
    func drawPolygon(){
        let layer = CAShapeLayer()
        let path = polygonPath(center: view.center, radius: 100, sides: 5, offset: 0  )
        layer.strokeColor = UIColor.red.cgColor
        layer.borderWidth = 10
        layer.path = path.cgPath
        view.layer.addSublayer(layer)
    }
    
    
    func polygonPointArray(sides:Int,center:CGPoint,radius:CGFloat,offset:CGFloat)->[CGPoint] {
        let angle:Double = (Double(360/sides))
        let cx = center.x // x origin
        let cy = center.y // y origin
        let r = radius    // radius of circle
        var i = 0
        var points = [CGPoint]()
        while i <= sides {
            let ang = angle * Double(i)
            let radian = CGFloat(ang.radians())
            let alphaX = cos(radian)
            let alphaY = sin(radian)
            
            /* unit of circle with origin(0,0) will have (x,y), where x = cos$ and y = sin$, whrer $ is angle in radians
            */
            let xpo = cx + r * alphaX
            let ypo = cy + r * alphaY
            
            print(xpo,ypo)
            
            points.append(CGPoint(x: xpo, y: ypo))
            i += 1
        }
        return points
    }
    /*
     center is point where ploygons center lies
     radius of the circle in which polygon lies or half of the diagonal
     sides is the number of sides
     offset is the value by which a polgon is rotated with respect to center
     */
    
    func polygonPath(center:CGPoint, radius:CGFloat, sides:Int, offset:CGFloat) -> UIBezierPath {
        let path = CGMutablePath()
        let points = polygonPointArray(sides: sides,center: center,radius: radius, offset: offset)
        let cpg = points[0]
        path.move(to: CGPoint(x: cpg.x, y: cpg.y))
        for p in points {
            path.addLine(to: CGPoint(x: p.x, y: p.y))
        }
        path.closeSubpath()
        let bezierPath = UIBezierPath(cgPath: path)
        return bezierPath
    }

}

extension Double {
    func radians() -> CGFloat {
        let b = Measurement(value: self, unit: UnitAngle.degrees).converted(to: UnitAngle.radians).value
        return CGFloat(b)
    }
}



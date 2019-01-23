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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .primaryColor
        
        let container = CALayer()
        container.frame = view.frame
        view.layer.addSublayer(container)
        
        //Create a Plane
        let purplePlane = CALayer()
        purplePlane.frame = CGRect(x: 10, y: 50, width: 300, height: 500)
        purplePlane.borderColor = UIColor.red.cgColor
        purplePlane.backgroundColor = UIColor.blue.cgColor
        
        container.addSublayer(purplePlane)
        
        //Apply transform to the PLANE
        var t = CATransform3DIdentity
        t.m34 = -(1/100)
        t = CATransform3DRotate(t, Double(45).radians(), 0, 1, 0)
        purplePlane.transform = t
        
        
        
    }
    
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

    
    func polygonPath(center:CGPoint, radius:CGFloat, sides:Int, offset: CGFloat) -> CGPath {
        let path = CGMutablePath()
        let points = polygonPointArray(sides: sides,center: center,radius: radius, offset: offset)
        let cpg = points[0]
        path.move(to: CGPoint(x: cpg.x, y: cpg.y))
        for p in points {
            path.addLine(to: CGPoint(x: p.x, y: p.y))
        }
        path.closeSubpath()
        return path
    }
    
    func drawPolygonBezier(center:CGPoint, radius:CGFloat, sides:Int, offset:CGFloat) -> UIBezierPath {
        let path = polygonPath(center: center, radius: radius, sides: sides, offset: offset)
        let bez = UIBezierPath(cgPath: path)
        bez.fill()
        return bez
    }

}

extension Double {
    func radians() -> CGFloat {
        let b = Measurement(value: self, unit: UnitAngle.degrees).converted(to: UnitAngle.radians).value
        return CGFloat(b)
    }
}



//
//  CustomPersonalButton.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import Foundation
import UIKit
class PersonalButton : UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    
    func  setUp()  {
        self.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width

        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        let p = CGPoint(x: self.bounds.maxX - self.bounds.width/8 ,y: self.bounds.maxY - self.bounds.width/8)
        drawCircle( p, CGFloat(self.bounds.width/8))
  
    }
    func drawCircle(_ point : CGPoint,_ radius : CGFloat)  {
        let circlePath = UIBezierPath(arcCenter: point, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi*2), clockwise: true)
            
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
       
        shapeLayer.fillColor = #colorLiteral(red: 0.1568627451, green: 0.7843137255, blue: 0.2509803922, alpha: 1)
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shapeLayer.lineWidth = 3.0
            
        self.layer.addSublayer(shapeLayer)
    }
}

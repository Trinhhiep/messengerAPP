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
        
    }
    
   
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
    }

    func addImageView(image : UIImage , status : Bool)  {
        let color : UIColor?
        if status == true {
            color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else{
            color = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60 ))
        imageView.maskCircle(anyImage: image)
        self.addSubview(imageView)
        let pBottomRight = CGPoint(x: self.bounds.maxX - self.bounds.width/8 ,y: self.bounds.maxY - self.bounds.width/8)
        
        drawCircle( pBottomRight, CGFloat(self.bounds.width/8),color!.cgColor)
    }
    func drawCircle(_ point : CGPoint,_ radius : CGFloat , _ color : CGColor )  {
        let circlePath = UIBezierPath(arcCenter: point, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi*2), clockwise: true)
            
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
       
        shapeLayer.fillColor = color
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shapeLayer.lineWidth = 3.0
            
        self.layer.addSublayer(shapeLayer)
    }
}
extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true
   self.image = anyImage
  }
}

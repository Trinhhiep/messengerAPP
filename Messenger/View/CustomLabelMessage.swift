//
//  CustomLabelMessage.swift
//  Messenger
//
//  Created by Admin on 10/05/2021.
//

import Foundation
import UIKit
class LabelMessage : UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.clear.cgColor
        self.numberOfLines = .max
        self.widthAnchor.accessibilityElements = .none
        self.lineBreakMode = .byWordWrapping
    }
}

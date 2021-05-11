//
//  MessageTableViewCell.swift
//  Messenger
//
//  Created by Admin on 11/05/2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    let host : String = "TQH"// username of host
    let messageLable = UILabel()
    let bubbleBackgroundView = UIView()
    var leadingConstrain : NSLayoutConstraint!
    var trailingConstrain : NSLayoutConstraint!
    
    // setup lable,text,color leading or trailing
    var chatMessage : ChatMessage! {
        didSet{
            let isHost = chatMessage.sender == host
            bubbleBackgroundView.backgroundColor = isHost ? #colorLiteral(red: 0, green: 0.5019607843, blue: 0.968627451, alpha: 1) : .white
            messageLable.textColor = isHost ?  .white : .black
            messageLable.text = chatMessage.message
            if isHost == true{
                trailingConstrain.isActive = true
                leadingConstrain.isActive = false
            }
            else{
                trailingConstrain.isActive = false
                leadingConstrain.isActive = true
            }
            
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    func setUp(){
        self.backgroundColor = #colorLiteral(red: 0.9288164119, green: 0.9288164119, blue: 0.9288164119, alpha: 1)
        addSubview(bubbleBackgroundView)
        
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.layer.cornerRadius = 20
        addSubview(messageLable)
     
       
        messageLable.numberOfLines = 0
        
        //
        messageLable.translatesAutoresizingMaskIntoConstraints = false
        
        // constrains
        let constrains =   [messageLable.topAnchor.constraint(equalTo: self.topAnchor,constant: 24),
                            messageLable.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -24),
                            messageLable.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
                            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLable.topAnchor,constant: -12),
                            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLable.bottomAnchor,constant: 12),
                            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLable.leadingAnchor,constant:-16),
                            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLable.trailingAnchor,constant:16) ]
 
        NSLayoutConstraint.activate(constrains)
        
        leadingConstrain = messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24)
       
        trailingConstrain = messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24)
    
    }
    
    
}

//
//  SearchBarTableViewCell.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {

    @IBOutlet weak var searchBar: UISearchBar!
    override func awakeFromNib() {
        super.awakeFromNib()
       

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

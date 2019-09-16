//
//  TopicCell.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var titleTopicLabel: UILabel!
    
    @IBOutlet weak var numVisitasLabel: UILabel!
    
    @IBOutlet weak var editTopicButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }


    func configure( title: String, numVisitas: String) {
        titleTopicLabel.text = title
        numVisitasLabel.text = numVisitas
    }
    
}

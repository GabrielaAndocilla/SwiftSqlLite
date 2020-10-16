//
//  TableCell.swift
//  FotoVideo
//
//  Created by GABRIELA on 14/10/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

   
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

     override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

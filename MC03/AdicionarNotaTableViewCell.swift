//
//  AdicionarNotaCellTableViewCell.swift
//  MC03
//
//  Created by João Marcos on 22/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class AdicionarNotaTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tipoNota: UILabel!
    @IBOutlet weak var pesoNota: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

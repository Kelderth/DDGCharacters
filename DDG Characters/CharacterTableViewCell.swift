//
//  CharacterTableViewCell.swift
//  DDG Characters
//
//  Created by MCS on 12/18/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(character: Character) {
        self.characterLabel.text = character.characterName
    }
    
}

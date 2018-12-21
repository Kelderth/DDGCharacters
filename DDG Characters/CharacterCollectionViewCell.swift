//
//  CharacterCollectionViewCell.swift
//  DDG Characters
//
//  Created by MCS on 12/19/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(character: CharacterSource) {
        print(characterImageView)
        print(characterImageView.image)
        self.characterImageView.image = UIImage(data: character.pictureData! as Data)
    }
}

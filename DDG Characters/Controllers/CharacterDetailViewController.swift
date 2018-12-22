//
//  CharacterDetailViewController.swift
//  DDG Characters
//
//  Created by MCS on 12/22/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit
//import CoreData

class CharacterDetailViewController: UIViewController {

    // MARK: - Properties
    var characterName: String = ""
    var dataSource: DDGPersistence = DDGPersistence()
    
    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Displays the Character Details that was picked up in the TableView or Collection View.
        displayCharacter()
    }
    
    // MARK: - Action Functions
    
    // Displays the Character Details
    func displayCharacter () {
        
        let characterFetchedInfo = getCharacterInfo(nameOfCharacter: characterName)
        
        nameLabel.text = characterFetchedInfo[0].characterName
        detailLabel.text = characterFetchedInfo[0].characterDetail
        characterImageView.image = UIImage(data: characterFetchedInfo[0].pictureData! as Data)
    }
    
    // MARK: - Herlper Functions
    
    /**
     Function that fetches the Character's details according to the ViewController Source selection.
     - Parameters:
        - nameOfCharacter: Character's name of String Type .
     - Returns: An array with the Characters' details.
     */
    private func getCharacterInfo (nameOfCharacter: String) -> [CharacterSource] {
        let characterRequest = dataSource.readData().filter{$0.characterName == nameOfCharacter}
        return characterRequest
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

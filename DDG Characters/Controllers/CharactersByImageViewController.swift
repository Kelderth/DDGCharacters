//
//  CharactersByImageViewController.swift
//  DDG Characters
//
//  Created by MCS on 12/18/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit
import CoreData

class CharactersByImageViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var characterSource: [CharacterSource] = [CharacterSource]()
    let dataRequest = DDGApiService()
    let dataManager = DDGPersistence()
//    var data: (Data)->()?
    var downloadedFinished = false
    var counterFlag = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterImageCell")
        
        downloadingCharacters()
        
    }
    
    func downloadingCharacters() {
        let characterCount = characterCounter()
        characterSource = dataManager.readData()
        
        for characterIndex in 0 ..< characterCount {
            if characterSource[characterIndex].pictureData == nil {
                var characterImageURL = characterSource[characterIndex].pictureURL!
                if characterImageURL.isEmpty {
                    characterImageURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"
                }
                dataRequest.imageDownloader(characterImageURL, completion: { imageData in
                    self.characterSource[characterIndex].pictureData = imageData as NSData
                    let context = UIApplication.shared.delegate as? AppDelegate
                    
                    context?.saveContext()
                    
                    self.counterFlag += 1
                
                    self.updateImages()
                })
            } else {
                self.counterFlag += 1
                self.updateImages()
            }
        }
        
//        for character in characterSource {
//            if character.pictureData == nil {
//                var characterImageURL = character.pictureURL
//
//                if characterImageURL!.isEmpty {
//                    characterImageURL = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
//                }
//
//                dataRequest.imageDownloader(characterImageURL!, completion: { imageData in
//                    character.pictureData = imageData as NSData
//
//                    let delegate = (UIApplication.shared.delegate as? AppDelegate)
//                    delegate?.saveContext()
//
//                    self.counterFlag += 1
//
//                    self.updateImages()
//                })
//            } else {
//                self.counterFlag += 1
//                self.updateImages()
//            }
//        }
        
    }
    
    func updateImages() {
        DispatchQueue.main.async {
            if self.counterFlag == self.characterSource.count {
                self.collectionView.reloadData()
            }
        }
    }

    /// CharacterCounter returns the total number of registers inside an entity.
    func characterCounter() -> Int {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CharacterSource>(entityName: "CharacterSource")
        do {
            count = try context.count(for:fetchRequest)
        } catch {
            print("Error")
        }
        return count
    }

}

extension CharactersByImageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if counterFlag == characterSource.count {
            return characterSource.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "CharacterImageCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setup(character: characterSource[indexPath.row])

        return cell
    }
    
}

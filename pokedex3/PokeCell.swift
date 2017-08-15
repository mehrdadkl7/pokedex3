//
//  PokeCell.swift
//  pokedex3
//
//  Created by mehrdad hooshangi on 5/25/1396 AP.
//  Copyright © 1396 mehrdad hooshangi. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    
    var pokeman: Pokemon!
    
    func configureCell (pokeman: Pokemon){
        self.pokeman = pokeman
        nameLbl.text = self.pokeman.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokeman.pokedexId)")
    }
    
}

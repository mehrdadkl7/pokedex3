//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by mehrdad hooshangi on 5/25/1396 AP.
//  Copyright © 1396 mehrdad hooshangi. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainimg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexidLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized
        pokedexidLbl.text = "\(pokemon.pokedexId)"
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainimg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetials {
            print("after dl process")
            self.updateUI()
        }
        
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func updateUI(){
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        weightLbl.text = pokemon.weight
        heightLbl.text = pokemon.height
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == ""{
            evoLbl.text = "NO Evolutions"
            nextEvoImg.isHidden = true
        }
        else{
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLevel)"
            evoLbl.text = str
        }
        
    }
}

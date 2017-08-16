//
//  ViewController.swift
//  pokedex3
//
//  Created by mehrdad hooshangi on 5/24/1396 AP.
//  Copyright © 1396 mehrdad hooshangi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection : UICollectionView!
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.enablesReturnKeyAutomatically = false
        parsePokemonCsv()
        initAudio()
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            //hamash tekrar mikone ahango
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch{
            print(error)
        }
    }
    
    func parsePokemonCsv (){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows)
            
            for row in rows {
                let pokeid = Int(row["id"]!)!
                let name = row["identifier"]!
                
                
                let poke = Pokemon(name: name, pokedexId: pokeid)
                pokemons.append(poke)
            }
            collection.reloadData()
            //print(pokemons.count)
            
        }catch{
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            let poke: Pokemon!
            if inSearchMode{
                poke = filteredPokemons[indexPath.row]
                cell.configureCell(poke)
            }
            else{
                poke = pokemons[indexPath.row]
                cell.configureCell(poke)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke : Pokemon!
        if inSearchMode{
            poke = filteredPokemons[indexPath.row]
        }
        else{
            poke = pokemons[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //tedade kole itemha
        if inSearchMode{
            return filteredPokemons.count
        }
        else{
            return pokemons.count
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.5
        }
        else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            collection.reloadData()
        }
        else{
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC"{
            if let detalsVC = segue.destination as? PokemonDetailVC{
                if let poke = sender as? Pokemon{
                    detalsVC.pokemon = poke
                }
            }
        }
    }
        
}


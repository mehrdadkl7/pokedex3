//
//  Pokeman.swift
//  pokedex3
//
//  Created by mehrdad hooshangi on 5/24/1396 AP.
//  Copyright © 1396 mehrdad hooshangi. All rights reserved.
//

import Foundation

class Pokemon{
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String{
        return _name
    }
    var pokedexId: Int{
        return _pokedexId
    }
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}

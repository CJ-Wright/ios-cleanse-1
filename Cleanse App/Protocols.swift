//
//  Protocols.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 9/15/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

protocol changeRecipeDelegate {
    func changeMealRecipe(_ recipe:Recipe) -> Recipe
}

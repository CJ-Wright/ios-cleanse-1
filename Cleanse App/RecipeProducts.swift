//
//  RecipeProduct.swift
//  Cleanse App
//
//  Created by Erik Karlsson on 10/30/16.
//  Copyright © 2016 Nano Nimbus. All rights reserved.
//

import Foundation

public struct RecipeSetProducts {
    
    public static let RECIPE_SET_1 = "b4sxjh1xf9f2etljzcys"
    public static let RECIPE_SET_2 = "ikljk47wes24pd1ommc6"
    public static let RECIPE_SET_3 = "c3g3ch7wv0t0bsmr775j"
    public static let RECIPE_SET_4 = "z1svnijdpvocv1wtdbyk"
    public static let RECIPE_SET_5 = "hxtnyqzr4248x6sukmz4"
    public static let RECIPE_SET_6 = "eqmr76e7338s0pxba32y"
    public static let RECIPE_SET_7 = "j07sthayvow5crpmeezx"
    public static let RECIPE_SET_8 = "9z7bmxvuxxm04dnejxjz"
    public static let RECIPE_SET_9 = "odzuipiofggowx837rua"
    public static let RECIPE_SET_10 = "joc7f37ndcjny6zq07f4"
    /*
     public static let RECIPE_SETS = ["b4sxjh1xf9f2etljzcys",
     "ikljk47wes24pd1ommc6",
     "c3g3ch7wv0t0bsmr775j",
     "z1svnijdpvocv1wtdbyk",
     "hxtnyqzr4248x6sukmz4",
     "eqmr76e7338s0pxba32y",
     "j07sthayvow5crpmeezx",
     "9z7bmxvuxxm04dnejxjz",
     "odzuipiofggowx837rua",
     "joc7f37ndcjny6zq07f4"]
     */
    
    fileprivate static let productIdentifiers: Set<ProductIdentifier> = [RecipeSetProducts.RECIPE_SET_1,RecipeSetProducts.RECIPE_SET_2,RecipeSetProducts.RECIPE_SET_3,RecipeSetProducts.RECIPE_SET_4,RecipeSetProducts.RECIPE_SET_5,RecipeSetProducts.RECIPE_SET_6,RecipeSetProducts.RECIPE_SET_7,RecipeSetProducts.RECIPE_SET_8,RecipeSetProducts.RECIPE_SET_9,RecipeSetProducts.RECIPE_SET_10]
    
    public static let store = IAPHelper(productIds: RecipeSetProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}


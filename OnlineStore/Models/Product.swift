//
//  Album.swift
//  OnlineStore
//
//  Created by Ira Paliy on 01.03.23.
//


import Foundation

struct Product: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var brand: String
    var images: Array<String>
    var price: Float
    var currency: String
    var description: String
    
}

let productList: [Product] = [
    .init(name: "Mango", brand: "Columbia", images: ["mango"], price: 1.50, currency: "CHF", description: "Storage\nDo not store in the refrigerator, fruit ripens at room temperature. The color says nothing about maturity. The mango will be fragrant around the stem when ready to eat.\n\nAdditional information\nIts flesh is dark yellow, sweet, fatty and sweet with a false taste of peach and flower. Depending on the variety or when the fruit is too ripe, the flesh sometimes becomes thread-like."),
    .init(name: "Melon", brand: "Spain", images: ["melon"], price: 4.30, currency: "CHF", description: "Useful tips \nThe Piel de Sapo belongs to the melon family and is known for its characteristic appearance. The Spanish name means 'toad skin' because its green marbled, cracked skin is so similar to it. \nAdditional information \nThe white flesh of exceptional quality tastes similar to that of the honeydew melon, but is slightly sweeter. The Piel de Sapo melon should be eaten ripe when the cracks in the skin are well visible. The skin sometimes shows a slightly lighter colored spot, this is completely normal, because this is the spot where it lay on the floor when it was growing."),
    .init(name:"Bananas", brand: "Central America", images: ["bananas"], price: 2.70, currency: "CHF", description: "Storage \nDo not store bananas in the fridge\nUseful tips\nChiquita Banana - The first banana to receive Rainforest Alliance environmental certification The seal with the little frog distinguishes Chiquita's sustainable production methods.\nAdditional information\nStill green bananas can simply be left at room temperature until they are fully ripe. To speed up the ripening process, an apple can be added to the bananas."),
    .init(name: "Watermelon", brand: "Spain", images: ["watermelon"], price: 3.30, currency: "CHF", description: "Storage \nOnce cut open, it keeps for about 6 days, well wrapped in foil, in the refrigerator. \nUseful tips\nWhole watermelons are very hardy. It can be stored at room temperature for at least one week. Make sure that it is not too warm, otherwise it will mature. \nAdditional information \nIf a normal watermelon is too big for you, between June and August you can fall back on the dwarf variant: the seedless mini watermelon is grown for small households. It is sweet and thirsty-quenching, easy to transport and quickly prepared as a snack"),
    .init(name: "Apple", brand: "Switzerland", images: ["apple"], price: 3.45, currency: "CHF", description: "Additional information \nSometimes you only need half an apple. Drizzle the other half with lemon juice or dip it in a bowl of lemon water to keep it from browning."),
    .init(name: "Pomegranate", brand: "Peru", images: ["pomegranate"], price: 1.50, currency: "CHF", description: "Storage \nCan be stored at room temperature for 4-5 days \nPractical tips \nScore the peel all around, break open and remove the flesh including the pits or squeeze out like a citrus fruit. Don't eat the partitions. Be careful, juice and seeds leave permanent stains! \nAdditional information \nThe kernels, covered with pulp, convey tangy acidity and tart sweetness. Cores for fruit salads, ice creams, creams and decoration. The squeezed juice is suitable for punches, cocktails, sorbets as well as for spicy salad dressings and game sauces."),
    .init(name: "Lemon", brand: "Spain", images: ["lemon"], price: 1.35, currency: "CHF", description: "Storage \nHalten Sie es eine Woche bei Raumtemperatur, nicht mehr, da es austrocknet. In der Gemüseschale des Kühlschranks kann es jedoch problemlos zwei Wochen bis zu einem Monat gelagert werden. \nAdditional information \nCounteracts oxidation of certain vegetables and fruits; prevents avocados, pears, bananas and apples from turning brown"),
    .init(name: "Kiwi", brand: "Italy", images: ["kiwi"], price: 0.80, currency: "CHF", description: "Storage \nCan be stored in the refrigerator for 2 weeks and at room temperature for about 1 week. Kiwis ripen at room temperature, preferably close to apples. \nAdditional information \nAlso known as Chinese gooseberry, the fruit has a fine, sweet-sour and refreshing aroma. The flesh of the Kiwi Gold, the yellow sister, tastes sweet and juicy."),
    .init(name: "Grapefruit", brand: "South Africa", images: ["grapefruit"], price: 0.90, currency: "CHF", description: "Storage \nGrapefruit keeps very well for 10 days in the crisper or 8 days at room temperature. Consume immediately after cutting, otherwise the pulp dries out and loses the vitamins that oxidize in the air. \nAdditional information \nWhite-fleshed or non-pigmented grapefruits have a thin and pale yellow skin with the same, mostly seedless flesh. Unlike their coloured sisters, Blondies are refreshingly tart and therefore ideal juicers."),
    .init(name: "Avocado", brand: "Peru", images: ["avocado"], price: 1.60, currency: "CHF", description: "Storage \nKeep cool but not too cold (min. 6°C). To accelerate ripening, store with other fruits, such as apples or bananas, which give off ethylene. \nUseful tips \nCreamy fruit flesh with nutty taste. Guacamole Rápida (3 minutes): 1-2 ripe avocados, 3-5 cloves of garlic, fresh, ripe tomatoes or pelati tomatoes from the can, juice of one lime, pepper, coriander, salt Preparation: Whisk all ingredients together with a blender , possibly season with Tabasco - done. Serve as a sauce with dips, chips and tacos \nAdditional information \nIf you only use half an avocado, you can preserve the other half with the core. Sprinkle them extensively with lemon juice and then wrap them in foil. Store in a cool place to slow down the maturing process and oxidation.")
]

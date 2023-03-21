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
    var price: Int
    var currency: String
    var description: String
    
}

let productList: [Product] = [
    .init(name: "Blazer Low", brand: "Nike", images: ["nike-blazer-0", "nike-blazer-1", "nike-blazer-2", "nike-blazer-3"], price: 125, currency: "CHF", description: "Praised for its classic simplicity and comfort, the Nike Blazer Low Platform elevates the hoops icon. The lifted midsole/outsole lets you step confidently while the upper keeps the proportions you loved from the original."),
    .init(name: "Samba Classic", brand: "Adidas", images: ["samba-classic-0", "samba-classic-1", "samba-classic-2", "samba-classic-3"], price: 160, currency: "CHF", description: "Born on the pitch, the Samba is a timeless icon of street style. These shoes stay true to their legacy with a soft leather upper and suede overlays."),
    .init(name:"MR-530 - Sneaker low", brand: "New Balance", images: ["new-balance-low-0", "new-balance-low-1", "new-balance-low-2", "new-balance-low-3"], price: 110, currency: "CHF", description: "The New Balance 530 sneaker is a throwback to one of our classic running looks. This casual shoe combines everyday style with the modern technology of ABZORB cushioning for superior comfort underfoot. Put a 2000's technical spin on your running style with the 530 sneaker."),
    .init(name: "Campo", brand: "Veja", images: ["veja-campo-0", "veja-campo-1", "veja-campo-2", "veja-campo-3"], price: 170, currency: "CHF", description: "Crafting sneakers differently and 'infusing each stage of production with a positive impact', VEJA's signature low-top designs embrace simplicity and versatility through a streetwear lens. These Campo sneakers are crafted from white ChromeFree leather, boasting a pale green branded heel counter and signature 'V' logo patch to the side."),
    .init(name: "Club C 85 Vintage", brand: "Reebok", images: ["reebok-vintage-0", "reebok-vintage-1", "reebok-vintage-2", "reebok-vintage-3"], price: 115, currency: "CHF", description: "Taking their cue from the '80s court classic, these shoes are all about simplicity. They have a leather upper and a timeless easy-to-wear style. The EVA midsole gives you lightweight cushioning."),
    .init(name: "SK8 LOW", brand: "Vans", images: ["vans-low-0", "vans-low-1", "vans-low-2", "vans-low-3"], price: 90, currency: "CHF", description: "The Sk8-Low, a takedown of the legendary Vans high top shoe, is built with an array of colors and materials to provide a familiar Sk8-Hi aesthetic in a low top shoe. Featuring sturdy canvas and suede uppers just like its taller counterpart, this lace-up style also includes re-enforced toe caps, supportive padded collars, and signature rubber waffle outsoles.")
]

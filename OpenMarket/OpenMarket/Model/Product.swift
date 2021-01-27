//
//  Product.swift
//  OpenMarket
//
//  Created by 임리나 on 2021/01/25.
//

import Foundation

struct Product: Codable {
    let id: Int?
    let title: String?
    let descriptions: String?
    let price: Int?
    let currency: String?
    let stock: Int?
    let discountedPrice: Int?
    let thumbnails: [String]?
    let images: [String]?
    let timeStampDate: Double?
    let password: String?
    
    init(forPostPassword: String, title: String, descriptions: String, price: Int, currency: String, stock: Int, discountedPrice: Int? = nil, images: [String]) {
        self.password = forPostPassword
        self.title = title
        self.descriptions = descriptions
        self.price = price
        self.currency = currency
        self.stock = stock
        self.discountedPrice = discountedPrice
        self.images = images
        
        self.id = nil
        self.thumbnails = nil
        self.timeStampDate = nil
    }
    
    init(forPatchPassword: String, title: String? = nil, descriptions: String? = nil, price: Int? = nil, currency: String? = nil, stock: Int? = nil, discountedPrice: Int? = nil, images: [String]? = nil) {
        self.password = forPatchPassword
        
        self.id = nil
        self.title = title
        self.descriptions = descriptions
        self.price = price
        self.currency = currency
        self.stock = stock
        self.discountedPrice = discountedPrice
        self.thumbnails = nil
        self.images = images
        self.timeStampDate = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, descriptions, price, currency, stock, thumbnails, images, password
        case discountedPrice = "discounted_price"
        case timeStampDate = "registration_date"
    }
    
    func makeRegistrationDate() -> Date? {
        guard let timeStampDate = timeStampDate else {
            return nil
        }
        return Date(timeIntervalSince1970: timeStampDate)
    }
}

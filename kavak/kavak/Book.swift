//
//  Book.swift
//  kavak
//
//  Created by Jorge Chavez on 18/10/21.
//

import Foundation
import SwiftyJSON

typealias Books = [Book]

struct Book: Codable {
  var isbn: String
  var img: String
  var genre: String
  var author: String
  var title: String
  var imported : Bool
  var des: String

  enum CodingKeys: String, CodingKey {
    case isbn
    case img
    case genre
    case author
    case title
    case imported
    case des = "description"
  }
}

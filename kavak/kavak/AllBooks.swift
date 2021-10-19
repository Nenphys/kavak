//
//  AllBooks.swift
//  kavak
//
//  Created by Jorge Chavez on 18/10/21.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias AllBooksCompletion = ([Book]) -> Void

class AllBooks:NSObject {
  private override init() {}
  static let shared = AllBooks()

  var allBooks =  Books()
  var historyBooks = Books()
  var bestSellersBooks = Books()
  var scienceBooks = Books()
  var businessBooks = Books()
  var idBestSellers = [String]()

  func getAllBooks(complition:@escaping AllBooksCompletion) {
    self.getBestSellersiDs()
    let url = "https://raw.githubusercontent.com/ejgteja/files/main/books.json"
    AF.request(url).responseJSON(completionHandler: {
      Response in
      do{
        let json =  try JSON(data: Response.data!)
        let booksData =  json.dictionary
        let a = booksData!["results"]
        let b = a!["books"]

        let dt = try? JSONEncoder().encode(b)
        let books = try JSONDecoder().decode([Book].self, from: dt!)
        books.forEach { book in
          self.allBooks.append(book)
        }
        complition(self.allBooks)
      }catch{
        print("ERROR")
      }
    })
  }
  
  func getBooksForSection(section:String) -> Books {
    var sectionBooks = self.allBooks.filter { book in
      if book.genre == section {
        return true
      }
      return false
    }

    switch section {
    case "History":
      historyBooks.append(contentsOf: sectionBooks)
    case "Science":
      scienceBooks.append(contentsOf: sectionBooks)
    case "Business":
      businessBooks.append(contentsOf: sectionBooks)
    default:
       sectionBooks = getBestSellersBooks()
    }

    return sectionBooks
  }

  func getBestSellersiDs() {
    let url = "https://raw.githubusercontent.com/ejgteja/files/main/best_sellers.json"
    AF.request(url).responseJSON(completionHandler: {
      Response in
      do{
        let json =  try JSON(data: Response.data!)
        let bestSellerData =  json.dictionary
        let result = bestSellerData!["results"]
        let bestSellerId = result!["best_sellers"]
        let dt = try? JSONEncoder().encode(bestSellerId)
        let ids = try JSONDecoder().decode([String].self, from: dt!)
        ids.forEach { id in
          self.idBestSellers.append(id)
        }
      }catch{
        print("ERROR")
      }
    })
  }
  func getBestSellersBooks() -> Books{

    self.bestSellersBooks = self.allBooks.filter({ book in
      if idBestSellers.contains(book.isbn) {

        return true
      }
      return false
    })
    return self.bestSellersBooks
  }
}

//
//  BooksTableViewController.swift
//  kavak
//
//  Created by Jorge Chavez on 18/10/21.
//

import UIKit

class BooksTableViewController: UITableViewController {
        
  @IBOutlet var booksTableView: UITableView!
  var titleSection = ["Best Sellers","History","Science","Business"];
  var allBooks = [Book]()
  override func viewDidLoad() {
    super.viewDidLoad()

    booksTableView.register(UINib(nibName: "BooksTableViewCell", bundle: nil), forCellReuseIdentifier: "books")


  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AllBooks.shared.getAllBooks { books in
      self.allBooks.append(contentsOf: books)
      print(self.allBooks.count)
      self.booksTableView.reloadData()

    }
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return titleSection[section]
  }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      return titleSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return AllBooks.shared.getBooksForSection(section: titleSection[section]).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "books", for: indexPath) as! BooksTableViewCell
      if AllBooks.shared.allBooks.isEmpty {
        cell.bookImage.image = UIImage(named: "")
        cell.bookTitle.text = ""
        cell.bookAuthor.text = ""
      } else {
        if indexPath.section == 0 {
          cell.bookImage.load(url: getImageUrl(url: AllBooks.shared.bestSellersBooks[indexPath.row].img))
          cell.bookTitle.text = AllBooks.shared.bestSellersBooks[indexPath.row].title
          cell.bookAuthor.text = "Author: \(AllBooks.shared.bestSellersBooks[indexPath.row].author)"
        } else if indexPath.section == 1 {
          cell.bookImage.load(url: getImageUrl(url: AllBooks.shared.historyBooks[indexPath.row].img))
          cell.bookTitle.text = AllBooks.shared.historyBooks[indexPath.row].title
          cell.bookAuthor.text = "Author: \(AllBooks.shared.historyBooks[indexPath.row].author)"
        }else if indexPath.section == 2 {
          cell.bookImage.load(url: getImageUrl(url: AllBooks.shared.scienceBooks[indexPath.row].img))
          cell.bookTitle.text = AllBooks.shared.scienceBooks[indexPath.row].title
          cell.bookAuthor.text = "Author: \(AllBooks.shared.scienceBooks[indexPath.row].author)"
        }else if indexPath.section == 3 {
          cell.bookImage.load(url: getImageUrl(url: AllBooks.shared.businessBooks[indexPath.row].img))
          cell.bookTitle.text = AllBooks.shared.businessBooks[indexPath.row].title
          cell.bookAuthor.text = "Author: \(AllBooks.shared.businessBooks[indexPath.row].author)"
        }
      }
        return cell
    }

  private func getImageUrl(url:String) -> URL {
    return URL(string: url) ?? URL(fileURLWithPath:"")
  }
}

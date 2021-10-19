//
//  BooksCellTableViewCell.swift
//  kavak
//
//  Created by Jorge Chavez on 18/10/21.
//

import UIKit

class BooksTableViewCell: UITableViewCell {

  @IBOutlet weak var bookAuthor: UILabel!
  @IBOutlet weak var bookTitle: UILabel!
  @IBOutlet weak var bookImage: UIImageView!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

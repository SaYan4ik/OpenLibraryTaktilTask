//
//  BooksListViewCell.swift
//  OpenLibraryTest
//
//  Created by Александр Янчик on 14.04.23.
//

import UIKit
import SDWebImage

class BooksListViewCell: UICollectionViewCell {
    
    static var id = String(describing: BooksListViewCell.self)
    
    @IBOutlet weak var coverImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    var book: BookModel? {
        didSet {
            guard let title = book?.title,
                  let yaer = book?.firstPublishYear,
                  let coverKey = book?.coverEditKey
            else { return}
            
            self.titleLabel.text = title
            self.yearLabel.text = "\(yaer)"
            
            guard let bookCoverURL = URL(string: "https://covers.openlibrary.org/b/olid/\(coverKey)-M.jpg") else { return }
            
            coverImageview.sd_setImage(
                with: bookCoverURL
            )
            setupStyle()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
    private func setupStyle() {
        self.container.layer.cornerRadius = 12
    }
    
}

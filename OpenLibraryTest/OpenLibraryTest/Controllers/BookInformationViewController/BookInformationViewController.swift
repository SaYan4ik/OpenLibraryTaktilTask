//
//  BookInformationViewController.swift
//  OpenLibraryTest
//
//  Created by Александр Янчик on 15.04.23.
//

import UIKit
import SDWebImage

class BookInformationViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearOfPublishLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    
    private var book: BookModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupStyle()
        getBookDescription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }

    private func setupNavigationBar() {

        let backButton = UIButton()
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        guard let title = book?.title else { return }
        self.navigationItem.title = title
    }
    
    @objc private func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    
    func set(book: BookModel) {
        self.book = book
    }
    
    private func getBookDescription() {
        guard let key = book?.keyWork else { return }
        print(key)
        progressSpinner.startAnimating()
        NetworkManager().getBookDescription(key: key) { description in
            self.descriptionTextView.text = description
            self.progressSpinner.stopAnimating()
        } failure: { errorString in
            self.showAlert(title: "Error", message: errorString)
        }

    }
    
    private func setData() {
        guard let title = book?.title,
              let yaerPublish = book?.firstPublishYear
        else { return}
        self.titleLabel.text = title
        self.yearOfPublishLabel.text = "Year of first piblish: \(yaerPublish)"
        self.averageRatingLabel.text = "\(book?.averageRating ?? 0.0)"
        
        
        if let coverKey = book?.coverId {
            guard let bookCoverURL = URL(string: "https://covers.openlibrary.org/b/id/\(coverKey)-M.jpg") else {
                return
            }
            coverImageView.sd_setImage(
                with: bookCoverURL )
        } else {
            self.coverImageView.image = UIImage(systemName: "book")
        }
    }

    
    private func setupStyle() {
        self.coverImageView.layer.cornerRadius = 12
        self.descriptionTextView.layer.cornerRadius = 12
    }
    
}

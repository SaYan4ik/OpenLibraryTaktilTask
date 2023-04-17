//
//  BooksListViewController.swift
//  OpenLibraryTest
//
//  Created by Александр Янчик on 14.04.23.
//

import UIKit

class BooksListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var booksData = [BookModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registrationCell()
        getBooksData()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    private func registrationCell() {
        let nib = UINib(nibName: BooksListViewCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BooksListViewCell.id)
    }
    
    private func getBooksData() {
        spinner.startAnimating()
        NetworkManager().searchBooks { dockBooks in
            self.booksData =  dockBooks.booksList.sorted(by: { $0.averageRating ?? 0 > $1.averageRating ?? 0 })
            self.collectionView.reloadData()
            self.spinner.stopAnimating()
        } failure: { errorString in
            self.showAlert(title: "Error", message: errorString)
            self.spinner.stopAnimating()
        }

    }
    
}

extension BooksListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BooksListViewCell.id, for: indexPath)
        guard let bookCell = cell as? BooksListViewCell else { return cell }
        bookCell.book = booksData[indexPath.item]
        
        return bookCell
    }
    
}

extension BooksListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nib = String(describing: BookInformationViewController.self)
        let bookInfoVC = BookInformationViewController(nibName: nib, bundle: nil)
        
        print(indexPath.item)
        print(booksData[indexPath.item])
        
        bookInfoVC.set(book: booksData[indexPath.item])
        
        navigationController?.pushViewController(bookInfoVC, animated: true)
    }

    
    
    
}

extension BooksListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 9.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        
        let width = (screen.bounds.width - (inset * (4))) / 2
        return CGSize(width: width, height: 282)
    }
}

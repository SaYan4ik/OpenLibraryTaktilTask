//
//  UIViewController+Extension.swift
//  OpenLibraryTest
//
//  Created by Александр Янчик on 15.04.23.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

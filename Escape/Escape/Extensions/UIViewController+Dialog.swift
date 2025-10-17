//
//  UIViewController+Dialog.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit

extension UIViewController {

    // MARK: - Success Dialog
    func showSuccessDialog(title: String = "Success!", message: String, completion: @escaping () -> Void = {}) {
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: title,
            kandungan: message,
            anNius: [("OK", AppColors.successButton, completion)]
        )
    }

    // MARK: - Error Dialog
    func showErrorDialog(title: String = "Error", message: String) {
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: title,
            kandungan: message,
            anNius: [("OK", AppColors.dangerButton, {})]
        )
    }

    // MARK: - Confirm Dialog
    func showConfirmDialog(title: String, message: String, onConfirm: @escaping () -> Void) {
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: title,
            kandungan: message,
            anNius: [
                ("Cancel", AppColors.secondaryButton, {}),
                ("Confirm", AppColors.dangerButton, onConfirm)
            ]
        )
    }

    // MARK: - Info Dialog
    func showInfoDialog(title: String, message: String) {
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: title,
            kandungan: message,
            anNius: [("OK", AppColors.secondaryButton, {})]
        )
    }

    // MARK: - Custom Dialog
    func showCustomDialog(title: String, message: String, buttons: [(String, UIColor, () -> Void)]) {
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: title,
            kandungan: message,
            anNius: buttons
        )
    }
}

//
//  AlertManager.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 18/04/26.
//

import UIKit

struct AlertManager {
    
    static func showConfirmation(
        on viewController: UIViewController?,
        title: String,
        message: String,
        confirmButtonTitle: String = "Remover",
        cancelButtonTitle: String = "Cancelar",
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            onCancel()
        }
        
        let confirmAction = UIAlertAction(title: confirmButtonTitle, style: .destructive) { _ in
            onConfirm()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        viewController?.present(alert, animated: true)
    }
}

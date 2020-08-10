//
//  ACThirdPartyApp.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 07/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

public class ACThirdPartyApp {
    
    public static func openWhatsApp(phoneNumber: String, message: String = "") {
        let msg = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let appURL = URL(string: "https://wa.me/\(phoneNumber)/?text=\(msg)")
        guard let waUrl = appURL else {
            return
        }
        if UIApplication.shared.canOpenURL(waUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(waUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(waUrl)
            }
        }
    }
    
    public static func openMail(viewController: UIViewController, delegate: MFMailComposeViewControllerDelegate, email: String, subject: String, body: String) -> Bool {
        let isCanSendMail = MFMailComposeViewController.canSendMail()
        if isCanSendMail {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = delegate
            composeVC.setToRecipients([email])
            composeVC.setSubject(subject)
            composeVC.setMessageBody(body, isHTML: false)
            viewController.present(composeVC, animated: true, completion: nil)
        } else {
//            ACSnacky.show(title: "Can't send email")
        }
        
        return isCanSendMail
    }
    
}

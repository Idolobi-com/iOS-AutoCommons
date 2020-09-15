//
//  ACAlert.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 25/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACAlert {
    
    private var alert: UIAlertController
    private var viewController: UIViewController
    
    public init(viewController: UIViewController, preferredStyle: UIAlertController.Style) {
        self.viewController = viewController
        self.alert = UIAlertController(title: nil, message: nil, preferredStyle: preferredStyle)
    }
    
    public func setTitle(title: String) -> ACAlert {
        alert.title = title
        return self
    }
    
    public func setMessage(message: String) -> ACAlert {
        alert.message = message
        return self
    }
    
    public func addAction(title: String, style: UIAlertAction.Style = .default,
                   handler: ((UIAlertAction) -> Void)?) -> ACAlert {
        alert.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    
    public func show() {
        viewController.present(alert, animated: true, completion: nil)
    }
}

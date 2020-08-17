//
//  ACLayout.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation
import UIKit
import WebKit

public var acLayout: ACLayout {
    struct Singleton {
        static let instance = ACLayout()
    }
    return Singleton.instance
}

public class ACLayout {
    
    public func button(id: String, style: ACButtonStyle, title: String?, titleColor: UIColor?, bgColor: UIColor? = nil, borderColor: UIColor? = nil) -> ACButton {
        let button = ACButton(type: .system)
        button.accessibilityIdentifier = "acButton_\(id)"
        button.setTitle(title, for: .normal)
        button.setDecoration(style: style, titleColor: titleColor,
                             bgColor: bgColor, borderColor: borderColor)
        return button
    }
    
    public func collectionView(id: String, layout: ACCollectionViewFlowLayout) -> ACCollectionView {
        let collectionView = ACCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.accessibilityIdentifier = "acCollectionView_\(id)"
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    public func imageView(id: String, image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFit) -> ACImageView {
        let imageView = ACImageView(frame: .zero)
        imageView.accessibilityIdentifier = "acImageView_\(id)"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = contentMode
        return imageView
    }
    
    public func label(id: String, style: ACFontStyle, text: String, color: UIColor?,
    align: NSTextAlignment = NSTextAlignment.left, numberOfLines: Int = 0) -> ACLabel {
        let label = ACLabel(frame: .zero)
        label.accessibilityIdentifier = "acLabel_\(id)"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color
        label.font = UIFont(name: style.font, size: CGFloat(style.size))
        label.numberOfLines = numberOfLines
        label.textAlignment = align
        label.lineBreakMode = .byTruncatingTail
        label.text = text
        return label
    }
    
    public func pageControl(id: String, currentPageColor: UIColor?, pageColor: UIColor?) -> ACPageControl {
        let pageControl = ACPageControl(frame: .zero)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.accessibilityIdentifier = "acPageControl_\(id)"
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = currentPageColor
        pageControl.pageIndicatorTintColor = pageColor
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }
    
    public func refreshControl(id: String, delegate: ACRefreshControlDelegate) -> ACRefreshControl {
        let refreshControl = ACRefreshControl(frame: .zero)
        refreshControl.accessibilityIdentifier = "acRefreshControl_\(id)"
        refreshControl.swipeRefreshDelegate = delegate
        return refreshControl
    }
    
    public func segmentedControl(id: String, titles: [String]) -> ACSegmentedControl {
        let segmentedControl = ACSegmentedControl(items: titles)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.accessibilityIdentifier = "acSegmentedControl_\(id)"
        return segmentedControl
    }
    
    public func textfield(id: String, placeHolder: String? = nil,
               style: ACRoseTextFieldStyle) -> ACTextField {
        let textField = ACTextField(style: style)
        textField.accessibilityIdentifier = "textfield_\(id)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.autocapitalizationType = .sentences
        let style = ACFontStyle.body
        textField.textField.font = UIFont(name: style.font, size: style.size)
        if let placeHolder = placeHolder {
            textField.textField.changePlaceholderColor(placeHolder: placeHolder,
                                                       color: .black40)
        }
        return textField
    }
    
    public func textView(id: String, placeHolder: String = "") -> ACTextView {
        let textView = ACTextView(placeHolder: placeHolder)
        textView.accessibilityIdentifier = "acTextView_\(id)"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autocapitalizationType = .sentences
        let style = ACFontStyle.body
        textView.font = UIFont(name: style.font, size: style.size)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        return textView
    }
    
    public func webView(id: String) -> ACWebView {
        let webConfiguration = WKWebViewConfiguration()
        let webView = ACWebView(frame: .zero, configuration: webConfiguration)
        webView.accessibilityIdentifier = "acWebView_\(id)"
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }
    
    public func stackView(id: String) -> ACStackView {
        let stackView = ACStackView(frame: .zero)
        stackView.accessibilityIdentifier = "acStackview_\(id)"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    public func slider(id: String) -> ACSlider {
        let slider = ACSlider(frame: .zero)
        slider.accessibilityIdentifier = "acSlider_\(id)"
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }
    
    public func switcher(id: String) -> ACSwitcher {
        let switcher = ACSwitcher(frame: .zero)
        switcher.accessibilityIdentifier = "acSwitcher_\(id)"
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }
    
    public func indicatorView(id: String) -> ACIndicatorView {
        let indicatorView = ACIndicatorView(frame: .zero)
        indicatorView.accessibilityIdentifier = "acIndicatorView_\(id)"
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }
    
    public func progressView(id: String) -> ACProgressView {
        let progressView = ACProgressView(frame: .zero)
        progressView.accessibilityIdentifier = "acProgressView_\(id)"
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }
    
    public func qrCode(id: String) -> ACQRCodeView {
        let qrCodeView = ACQRCodeView(frame: .zero)
        qrCodeView.accessibilityIdentifier = "acQrCode_\(id)"
        qrCodeView.translatesAutoresizingMaskIntoConstraints = false
        return qrCodeView
    }
    
    public func imageViewNetwork(id: String, contentMode: UIView.ContentMode = UIView.ContentMode.scaleToFill) -> ACImageViewNetwork {
        let image = ACImageViewNetwork()
        image.accessibilityIdentifier = "acImageLoader_\(id)"
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = contentMode
        return image
    }
    
    public func labelWithIcon(id: String, icon: UIImage?, text: String, size: LabelIconSize, fontStyle: ACFontStyle = .callout, color: UIColor = .black, position: LabelIconPosition = .left) -> LabelIcon {
        let iconLabel = LabelIcon(image: icon, text: text, size: size, position: position)
        iconLabel.accessibilityIdentifier = "acLabelIcon_\(id)"
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.setLabelStyle(style: fontStyle, color: color, align: .left)
        iconLabel.label.numberOfLines = 0
        return iconLabel
    }
    
    public func container(id: String) -> UIView {
        let view = UIView(frame: .zero)
        view.accessibilityIdentifier = "acContainer_\(id)"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }
    
    public func cardView(id: String, cornerRadius: CGFloat = 8.0, shadowRadius: CGFloat = 6.0, shadowOpacity: CGFloat = 0.4) -> UIView {
        let view = UIView(frame: .zero)
        view.accessibilityIdentifier = "acCardView_\(id)"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = Float(shadowOpacity)
        return view
    }
    
    public func fab(id: String, icon: UIImage?, bgColor: UIColor?, size: CGFloat = 72) -> UIButton {
        let button = UIButton(frame: .zero)
        button.accessibilityIdentifier = "fab_\(id)"
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: size),
            button.heightAnchor.constraint(equalToConstant: size)
            ])
        button.setImage(icon, for: .normal)
        button.backgroundColor = bgColor
        button.layer.cornerRadius = size/2.0
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.25
        return button
    }
    
}

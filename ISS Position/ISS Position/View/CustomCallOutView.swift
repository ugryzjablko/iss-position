//
//  CustomCallOutView.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Mapbox

class CustomCallOutView: UIView, MGLCalloutView {
    
    var representedObject: MGLAnnotation

    lazy var leftAccessoryView = UIView()
    lazy var rightAccessoryView = UIView()
    
    weak var delegate: MGLCalloutViewDelegate?
    
    private let spacing: CGFloat = 8.0
    private let height: CGFloat = 100.0
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    }()
    
    let subtitleTextView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 10.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    required init(annotation: MGLAnnotation) {
        self.representedObject = annotation
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width * 0.75, height: height)))
        self.titleLabel.text = self.representedObject.title ?? ""
        self.subtitleTextView.text = self.representedObject.subtitle ?? ""
        setup()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("Not implemented!")
    }
    
    func setup() {
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleTextView)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: spacing).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -spacing).isActive = true
        
        subtitleTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: spacing).isActive = true
        subtitleTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: spacing).isActive = true
        subtitleTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -spacing).isActive = true
        subtitleTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacing).isActive = true
    }
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        self.center = view.center.applying(CGAffineTransform(translationX: 0, y: -self.frame.height))
        view.addSubview(self)
    }
    
    func dismissCallout(animated: Bool) {
        if (animated){
            removeFromSuperview()
        } else {
            removeFromSuperview()
        }
    }
    
}

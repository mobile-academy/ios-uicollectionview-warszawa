//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit


class SeparatorView: UICollectionReusableView {

    let separator: UIView

    let separatorLabel: UILabel

    override init(frame: CGRect) {
        separator = UIView(frame: CGRect.zero)
        separatorLabel = UILabel(frame: frame)

        super.init(frame: frame)

        addSubview(separator)
        addSubview(separatorLabel)

        separatorLabel.font = .systemFont(ofSize: 12)
        separatorLabel.textColor = UIColor(white: 0.14, alpha: 1.0)

        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Setup Helpers

    fileprivate func setupConstraints() {
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.centerYAnchor.constraint(equalTo: centerYAnchor)
        separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 70).isActive = true
        separator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        separatorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        separatorLabel.rightAnchor.constraint(equalTo: separator.rightAnchor, constant: 5).isActive = true
        separatorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    }

    //MARK: UICollectionReusableView

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        // TODO Assignment 3: Apply text and color from custom layout attributes

    }
}

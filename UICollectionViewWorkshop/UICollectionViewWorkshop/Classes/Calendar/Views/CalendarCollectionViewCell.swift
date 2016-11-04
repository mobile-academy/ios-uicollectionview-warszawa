//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    let textLabel: UILabel

    override init(frame: CGRect) {
        textLabel = UILabel(frame: frame)

        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        textLabel = UILabel(frame: CGRect.zero)

        super.init(coder: aDecoder)
    }

    //MARK: Setup

    fileprivate func setupLabel() {
        contentView.addSubview(textLabel)

        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20)
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)

        backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        layer.cornerRadius = 6.0
        layer.masksToBounds = true
    }
}

//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    let textLabel: UILabel
    
    override init(frame: CGRect) {
        textLabel = UILabel(frame: frame)
        
        super.init(frame: frame)
        
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        backgroundColor = .red
        
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

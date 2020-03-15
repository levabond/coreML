//
//  HomeMainCell.swift
//  CoreMLFoundation
//
//  Created by Лев Бондаренко on 15.03.2020.
//  Copyright © 2020 sergdort. All rights reserved.
//

import UIKit
import PinLayout
import Domain
import Kingfisher

class HomeItemCell: UITableViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        [backgroundImageView,
         gradientView,
         titleLabel].forEach { view.addSubview($0) }
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = MainTheme.backgroundColor
        
        return view
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.alpha = 0.2
        
        return imageView
    }()
    
    lazy var gradientView: GradientView = {
        let view = GradientView()
        view.firstColor = MainTheme.accentColor
        view.secondColor = MainTheme.accent2Color
        view.layer.cornerRadius = 5
        view.alpha = 0.8
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titleLabel"
        
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.applyGradient(colors: [UIColor.green, UIColor.red])
        selectionStyle = .none
        backgroundColor = MainTheme.blackColor
        
        
        [containerView].forEach { contentView.addSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {

        // 2) Layout the contentView's controls
        layout()
        
        // 3) Returns a size that contains all controls
        return CGSize(width: Screen.width, height: 20 + titleLabel.frame.maxY + 30)
    }
    
    // MARK: Configure
    
    func configure(_ model: HomeItem) {
        titleLabel.text = model.title
        
        if let image = URL(string: model.image) {
            backgroundImageView.kf.setImage(with: image)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.clipsToBounds = true
        }
    }
    
    func layout() {
        containerView.dropShadow()
        
        containerView.pin
            .top(15)
            .left(15)
            .right(15)
            .height(titleLabel.frame.maxY + 30)
        
        titleLabel.pin
            .top(30)
            .left(15)
            .sizeToFit()
                
        backgroundImageView.pin.all()
        
        gradientView.pin.all()
    }
}

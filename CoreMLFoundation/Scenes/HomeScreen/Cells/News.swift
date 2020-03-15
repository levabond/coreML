//
//  News.swift
//  CoreMLFoundation
//
//  Created by Лев Бондаренко on 15.03.2020.
//  Copyright © 2020 sergdort. All rights reserved.
//

import UIKit
import ScalingCarousel
import PinLayout

class HomeNewsCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New"
        
        return label
    }()
    
    lazy var flowLayout = UICollectionViewFlowLayout()
    var carousel: ScalingCarouselView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [titleLabel].forEach { addSubview($0) }
        
        backgroundColor = MainTheme.blackColor
        carousel = ScalingCarouselView(withFrame: frame, andInset: 0)
        
        carousel?.dataSource = self
        carousel?.delegate = self
//        carousel?.translatesAutoresizingMaskIntoConstraints = false
        
        // Register our custom cell for dequeueing
        carousel?.register(Cell.self, forCellWithReuseIdentifier: "cell")
        
        //        scalingCarousel?.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        //        scalingCarousel?.heightAnchor.constraint(equalToConstant:300).isActive = true
        //        scalingCarousel?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        //        scalingCarousel?.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        // Add our carousel as a subview
        addSubview(carousel!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        titleLabel.pin.topLeft(15).sizeToFit()
        
        carousel?.pin.below(of: titleLabel).all()
        
    }
    
    func configure(_ model: String) {
        titleLabel.text = model
        carousel?.reloadData()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        
        return CGSize(width: Screen.width, height: 300)
    }
}

extension HomeNewsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
    
}

extension HomeNewsCell: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          //carousel.didScroll()
          
          guard let currentCenterIndex = carousel?.currentCenterCellIndex?.row else { return }
          
//          output.text = String(describing: currentCenterIndex)
      }
}

class Cell: UICollectionViewCell {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    //       func configure(_ model: HomeItem) {
    //           titleLabel.text = model.title
    //
    //           if let image = URL(string: model.image) {
    //               backgroundImageView.kf.setImage(with: image)
    //               backgroundImageView.contentMode = .scaleAspectFill
    //               backgroundImageView.clipsToBounds = true
    //           }
    //       }
    
    func layout() {
        titleLabel.pin
            .top(30)
            .left(15)
            .sizeToFit()
        
        containerView.pin.height(200).width(90%).center()
        backgroundImageView.pin.all()
        
        gradientView.pin.all()
    }
}

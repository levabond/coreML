//
//  News.swift
//  CoreMLFoundation
//
//  Created by Лев Бондаренко on 15.03.2020.
//  Copyright © 2020 sergdort. All rights reserved.
//

import UIKit
import ScalingCarousel

class HomeNewsCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New"
        
        return label
    }()
    
    lazy var flowLayout = UICollectionViewFlowLayout()
    var scalingCarousel: ScalingCarouselView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [titleLabel].forEach { addSubview($0) }
        
        scalingCarousel = ScalingCarouselView(withFrame: frame, andInset: 20)

        scalingCarousel?.dataSource = self
        scalingCarousel?.delegate = self
        scalingCarousel?.translatesAutoresizingMaskIntoConstraints = false

        // Register our custom cell for dequeueing
        scalingCarousel?.register(Cell.self, forCellWithReuseIdentifier: "cell")

        // Add our carousel as a subview
        addSubview(scalingCarousel!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        titleLabel.pin.topLeft(15).sizeToFit()
        
        scalingCarousel?.pin.below(of: titleLabel).marginTop(10).all()
        
    }
    
    func configure(_ model: String) {
        titleLabel.text = model
    }
}

extension HomeNewsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}

extension HomeNewsCell: UICollectionViewDelegate {
    
}

class Cell: UICollectionViewCell {
}

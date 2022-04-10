//
//  CollectionviewTableViewCell.swift
//  NetflexClone
//
//  Created by 김희진 on 2022/04/03.
//

import UIKit

class CollectionviewTableViewCell: UITableViewCell {

    static let identifier = "CollectionviewTableViewCell"
    
    private var titles: [Title] = [Title]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TItleCollectionViewCell.self, forCellWithReuseIdentifier: TItleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
    }
    
}

extension CollectionviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TItleCollectionViewCell.identifier, for: indexPath) as? TItleCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
  
        cell.configure(with: model)
        return cell
    }
    
}

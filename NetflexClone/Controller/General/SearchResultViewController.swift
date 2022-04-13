//
//  SearchResultViewController.swift
//  NetflexClone
//
//  Created by 김희진 on 2022/04/13.
//

import UIKit

class SearchResultViewController: UIViewController {

    public var title2: [Title] = [Title]()
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TItleCollectionViewCell.self, forCellWithReuseIdentifier: TItleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }

}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TItleCollectionViewCell.identifier, for: indexPath) as? TItleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = title2[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        
        return cell
    }
}

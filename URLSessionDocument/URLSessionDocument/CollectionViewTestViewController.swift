//
//  CollectionViewTestViewController.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/07/05.
//

import UIKit

class CollectionViewTestViewController: UIViewController {

    private lazy var puzzleCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
    }
    
    private func setDelegate() {
        puzzleCollectionView.delegate = self
        puzzleCollectionView.dataSource = self
    }
    
    private func setUI() {
        view.backgroundColor = .gray
        
        puzzleCollectionView.do {
            $0.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: "test1")
            $0.backgroundColor = .red
        }
    }
    
    private func setLayout() {
        view.addSubview(puzzleCollectionView)
        
        puzzleCollectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(100)
            $0.height.equalTo(240)
        }
    }
}

extension CollectionViewTestViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

extension CollectionViewTestViewController {
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        
        return layout
    }
}

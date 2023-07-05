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
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(100)
            $0.height.equalTo(240)
        }
    }
}

extension CollectionViewTestViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test1", for: indexPath) as? TestCollectionViewCell else { return UICollectionViewCell() }
        var imageNumber: String = ""
        
        switch indexPath.section {
        case 0:
            imageNumber = "puzzleElement\(indexPath.item + 1)"
        case 1:
            imageNumber = "puzzleElement\(indexPath.item + 6)"
        case 2:
            imageNumber = "puzzleElement\(indexPath.item + 11)"
        default:
            break
        }
        
        
        cell.configureCell(imageName: imageNumber)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1, indexPath.section)
    }
}

extension CollectionViewTestViewController {
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        layout.minimumInteritemSpacing = -28.5
        
        return layout
    }
}

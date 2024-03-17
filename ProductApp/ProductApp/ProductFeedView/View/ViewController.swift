//
//  ViewController.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 15.03.2024.
//

import UIKit
//-------------------------------------------------------
// MARK: - Properties -
//-------------------------------------------------------
class ProductFeed: UIViewController {
    
    private var currentPage = 1
    
    private lazy var presenter: ViewPresenter = {
        let presenter = ViewPresenter()
        presenter.controller = self
        return presenter
    }()
    
    private lazy var navigationTitleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60.5, height: 30))
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        return view
    }()
    
    private lazy var rightBarButton: UIBarButtonItem = {
        let image = UIImage(named: "rightBarItem")
        
        let button = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(rightBarItemTapped))
        
        button.tintColor = .Constants.appBackgoundColor
        return button
    }()
    
    private lazy var leftBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(named: "leftBarItem"),
            style: .plain,
            target: self,
            action: #selector(rightBarItemTapped))
        
        button.tintColor = .Constants.appBackgoundColor
        return button
    }()
    
    private lazy var collectionOptionsBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .Constants.appBackgoundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(named: "filter"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filters"
        label.textColor = .Constants.darkBlueColor
        label.font = UIFont.Fonts.mainTextInfo

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(imageView)
        button.addSubview(label)

    
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: button.topAnchor),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            label.topAnchor.constraint(equalTo: button.topAnchor),
        ])
        button.addTarget(self, action: #selector(filterWasTouched), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var listStyleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "listImage"), for: .normal)
        button.imageView?.contentMode = .center
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(listStyleButtonTaped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var gridStyleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "gridImage")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .center
        button.layer.cornerRadius = 5

        button.backgroundColor = .Constants.mainTextColor?.withAlphaComponent(0.4)
    

        
        button.addTarget(self, action: #selector(gridStyleButtonTaped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var collectionViewContainer: UICollectionView = {
        let collectionViewContainer = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewList())
        collectionViewContainer.backgroundColor = .Constants.appBackgoundColor
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.delegate = self
        collectionViewContainer.dataSource = self
        collectionViewContainer.showsHorizontalScrollIndicator = false
        
        collectionViewContainer.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionViewContainer
    }()
    
    private lazy var bottomButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .Constants.firstButtonColor
        
                
        let attributes: [NSAttributedString.Key: Any] =
        [
            .font: UIFont.Fonts.subTitlesMediun
        ]
        
        button.setAttributedTitle(NSAttributedString(string: "MY CART",
                                                     attributes: attributes),
                                  for: .normal)

        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var leftButtonImageView: UIImageView = {
        let image = UIImage(named: "cart")
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textAlignment = .center
        label.layer.cornerRadius = 50
        label.backgroundColor = .Constants.appBackgoundColor
        
        return label
    }()
    
    private lazy var counterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(counterLabel)
        view.backgroundColor = .Constants.appBackgoundColor

        NSLayoutConstraint.activate([
        
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    
        return view
    }()
}
//-------------------------------------------------------
// MARK: - Controller Lifecycle -
//-------------------------------------------------------
extension ProductFeed {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchProducts(page: 1, pageSize: 10)
        setupViews()
    }
}

//-------------------------------------------------------
// MARK: - Helpers -
//-------------------------------------------------------
extension ProductFeed {

    func showNoInternetConnectionAllert() {
        let alert = UIAlertController(title: nil, message: "Can't fetch data", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func rightBarItemTapped() {
        print("Right item was tapped")
    }
    
    @objc
    func leftBaritemTapped() {
        print("Left item was tappped")
    }
    
    @objc
    private func filterWasTouched() {
        presenter.filterByPrice()
    }
    
    @objc
    private func listStyleButtonTaped() {
        gridStyleButton.backgroundColor = .Constants.appBackgoundColor
        
        listStyleButton.backgroundColor = .Constants.mainTextColor?.withAlphaComponent(0.2)
    }
    
    @objc
    private func gridStyleButtonTaped() {
        listStyleButton.backgroundColor = .Constants.appBackgoundColor
        gridStyleButton.backgroundColor = .Constants.mainTextColor?.withAlphaComponent(0.2)
    }
}

//-------------------------------------------------------
// MARK: - Collection View Protocols-
//-------------------------------------------------------
extension ProductFeed: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _ = (collectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell) {
            let id = presenter.getData()[indexPath.row].id
            let controller = ProductViewController(id: id)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension ProductFeed: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        
        cell.configure(with: presenter.getData()[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            currentPage += 1
            presenter.fetchProducts(page: currentPage, pageSize: 10)
        }
    }
}
//-------------------------------------------------------
// MARK: - Style & Layout -
//-------------------------------------------------------

extension ProductFeed {
    func setupViews() {
        view.safeAreaLayoutGuide.owningView?.backgroundColor = .Constants.darkBlueColor
        
        setupNavigationBar()
        setupOptionsBarView()
        setupCollectionView()
        setupBottomButton()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .Constants.darkBlueColor
        self.navigationController?.navigationBar.backgroundColor = .Constants.darkBlueColor
        
        self.navigationItem.titleView = navigationTitleView
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func setupOptionsBarView() {
        view.addSubview(collectionOptionsBarView)
        
        collectionOptionsBarView.addSubview(filterButton)
        collectionOptionsBarView.addSubview(gridStyleButton)
        collectionOptionsBarView.addSubview(listStyleButton)
        
        NSLayoutConstraint.activate([
            
            collectionOptionsBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionOptionsBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionOptionsBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionOptionsBarView.heightAnchor.constraint(equalToConstant: 60),
            
            filterButton.leadingAnchor.constraint(equalTo: collectionOptionsBarView.leadingAnchor, constant: 16),
            filterButton.centerYAnchor.constraint(equalTo: collectionOptionsBarView.centerYAnchor),
            
            gridStyleButton.trailingAnchor.constraint(equalTo: collectionOptionsBarView.trailingAnchor, constant: -16),
            gridStyleButton.centerYAnchor.constraint(equalTo: collectionOptionsBarView.centerYAnchor),
            gridStyleButton.widthAnchor.constraint(equalToConstant: 31),
            gridStyleButton.heightAnchor.constraint(equalToConstant: 31),
            
            listStyleButton.trailingAnchor.constraint(equalTo: gridStyleButton.leadingAnchor, constant: -16),
            listStyleButton.centerYAnchor.constraint(equalTo: collectionOptionsBarView.centerYAnchor),
            listStyleButton.heightAnchor.constraint(equalToConstant: 31),
            listStyleButton.widthAnchor.constraint(equalToConstant: 31),
        ])
    }
    
    func setupCollectionView() {
        view.addSubview(collectionViewContainer)
        
        NSLayoutConstraint.activate([
            collectionViewContainer.topAnchor.constraint(equalTo: collectionOptionsBarView.bottomAnchor),
            collectionViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupCollectionViewList() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.CollectionView.itemWidth),
                                              heightDimension: .absolute(Constants.CollectionView.itemHeight))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(Constants.CollectionView.itemHeight))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func setupBottomButton() {
        view.addSubview(bottomButton)
        
        bottomButton.addSubview(leftButtonImageView)
        let leftDelimeter = UIView()
        leftDelimeter.backgroundColor = .Constants.appBackgoundColor?.withAlphaComponent(0.3)
        leftDelimeter.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.addSubview(leftDelimeter)
        
        bottomButton.addSubview(counterView)
        let rightDelimeter = UIView()
        rightDelimeter.backgroundColor = .Constants.appBackgoundColor?.withAlphaComponent(0.3)
        rightDelimeter.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.addSubview(rightDelimeter)
        
        
        NSLayoutConstraint.activate([
            
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.BottomButton.leading),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.BottomButton.trailing),
            bottomButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.BottomButton.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: Constants.BottomButton.height),
            
            leftButtonImageView.topAnchor.constraint(equalTo: bottomButton.topAnchor),
            leftButtonImageView.bottomAnchor.constraint(equalTo: bottomButton.bottomAnchor),
            leftButtonImageView.leadingAnchor.constraint(equalTo: bottomButton.leadingAnchor, constant: 15),
            leftButtonImageView.centerYAnchor.constraint(equalTo: bottomButton.centerYAnchor),
            
            leftDelimeter.heightAnchor.constraint(equalToConstant: Constants.BottomButton.height),
            leftDelimeter.widthAnchor.constraint(equalToConstant: 1),
            leftDelimeter.leadingAnchor.constraint(equalTo: bottomButton.leadingAnchor, constant: Constants.Delimeters.distance),
            
            rightDelimeter.heightAnchor.constraint(equalToConstant: Constants.BottomButton.height),
            rightDelimeter.widthAnchor.constraint(equalToConstant: 1),
            rightDelimeter.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor, constant: -Constants.Delimeters.distance),
            
            counterView.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor, constant: -15),
            counterView.centerYAnchor.constraint(equalTo: bottomButton.centerYAnchor),
            counterView.heightAnchor.constraint(equalToConstant: 23),
            counterView.widthAnchor.constraint(equalToConstant: 23),
            
        ])
        
        bottomButton.layoutSubviews()
        counterView.layer.cornerRadius = counterView.bounds.size.width / 2
    }
}
//-------------------------------------------------------
// MARK: - Constants -
//-------------------------------------------------------

extension ProductFeed {
    enum Constants {
        enum CollectionView {
            static let itemWidth: CGFloat = 345
            static let itemHeight: CGFloat = 212
            static let itemInsetTop: CGFloat = 20
            static let bottomInsetTop: CGFloat = 20
        }
        
        enum Delimeters {
            static let distance: CGFloat = 50
        }
        
        enum BottomButton {
            static let leading: CGFloat = 15
            static let trailing: CGFloat = -15
            static let height: CGFloat = 50
            static let bottomAnchor: CGFloat = -45
        }
        
        enum LeftButtonImageView {
            static let height: CGFloat = 50
            static let width: CGFloat = 50
        }
    }
}

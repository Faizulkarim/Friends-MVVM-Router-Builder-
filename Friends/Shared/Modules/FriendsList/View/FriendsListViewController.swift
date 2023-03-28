//
//  FriendsListViewController.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

// MARK: FriendsListViewController
final class FriendsListViewController: BaseFriendsListViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    private var router: FriendsListRouter?
    private let viewModel: FriendsListViewModelType
    private let FriendsListApiSubject = PassthroughSubject< Parameters, Never>()
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
     var displayModel = FriendsListDisplayModel()
    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: FriendsListViewModelType,
         router: FriendsListRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(analyticsManager: analyticsManager, theme: theme)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind(to: viewModel)
        setupRouter()
        viewDidLoadSubject.send()
        let params: Parameters = ["results": "20"]
        self.FriendsListApiSubject.send(params)
    }
    
}

// MARK: Private Default Methods
private extension FriendsListViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
        setupFriendsCollectionView()
    }
    
    func setupFriendsCollectionView(){
    
        friendsCollectionView.register(UINib(nibName: "FriendsListCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FriendsListCollectionViewCell")
        friendsCollectionView.delegate = self
        friendsCollectionView.dataSource = self
        friendsCollectionView.showsHorizontalScrollIndicator = false
        friendsCollectionView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        friendsCollectionView.reloadData()
    }

    /// Bind viewmodel
    private func bind(to viewModel: FriendsListViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = FriendsListViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(), friendsListApiSubject: FriendsListApiSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: FriendsListViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        case .apiFailure(customError: let customError):
            print(customError.body)
        case .apiSuccess(response: let response):
            displayModel.friendsListData = response
            friendsCollectionView.reloadData()
        }
    }
    
}

extension FriendsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  displayModel.friendsListData?.results?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: FriendsListCollectionViewCell.self),
                                                         for: indexPath) as? FriendsListCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let userData = displayModel.friendsListData?.results?[indexPath.row]
            let name = String(format: "%@ %@ %@", userData?.name?.title ?? "", userData?.name?.first ?? "", userData?.name?.last ?? "")
            let country = userData?.location?.country ?? ""
            let age = "\(userData?.dob?.age ?? 0) years"
            let profilePic = userData?.picture?.large ?? ""
            cell.configureCell(name: name, country: country, age: age.description, image: profilePic)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = displayModel.friendsListData?.results?[indexPath.row]
        self.router?.routeToFriendsDetailsView(data: data)
        
    }
    
    
}

extension FriendsListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.baseView.frame.width - 40) / 4, height: 250)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }
}

//
//  FriendsDetailsViewController.swift
//  Friends
//
//  Created by Md Faizul karim on 29/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

// MARK: FriendsDetailsViewController
final class FriendsDetailsViewController: BaseFriendsDetailsViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var address : UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile : UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    private var router: FriendsDetailsRouter?
    private let viewModel: FriendsDetailsViewModelType

    var displayModel = FriendsDetailsDisplayModel()
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()

    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: FriendsDetailsViewModelType,
         router: FriendsDetailsRouter) {
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
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.router?.back()
    }
    
}

// MARK: Private Default Methods
private extension FriendsDetailsViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
        let name = String(format: "%@ %@ %@", displayModel.friendData?.name?.title ?? "", displayModel.friendData?.name?.first ?? "", displayModel.friendData?.name?.last ?? "")
        let address = String(format: "%@ %@", displayModel.friendData?.location?.street?.number?.description ?? 0, displayModel.friendData?.location?.street?.name ?? "")
        self.name.text = "Name : \(name)"
        self.address.text = "Address : \(address)"
        self.city.text = "City : \(displayModel.friendData?.location?.city ?? ""), State :  \(displayModel.friendData?.location?.state ?? ""), Country :  \(displayModel.friendData?.location?.country ?? "")"
        self.mobile.text = "Cell phone : \(displayModel.friendData?.cell ?? "")"
        self.profileImage.loadImage(fromURL: displayModel.friendData?.picture?.large ?? "")
        if let email = displayModel.friendData?.email {
           let attributedString = NSMutableAttributedString(string: "Email : \(email)")
           let emailRange = (attributedString.string as NSString).range(of: email)
           attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: emailRange)
           // Set the attributed string to your label
           self.email.attributedText = attributedString
        } else {
           self.email.text = "Email : "
        }
        self.email.handleTapToAction {
            if let url = URL(string: "mailto:\(self.displayModel.friendData?.email ?? "")") {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    }

    /// Bind viewmodel
    private func bind(to viewModel: FriendsDetailsViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = FriendsDetailsViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: FriendsDetailsViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        }
    }
    
}





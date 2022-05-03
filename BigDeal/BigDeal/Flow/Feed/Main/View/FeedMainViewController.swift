import UIKit

class FeedMainViewController: UIViewController {
    // MARK: - Private properties
    
    private let feedMainView = FeedMainView()
    private var output: FeedMainPresenterOutputProtocol?
    
    // MARK: - Protocol properties
    
    var coordinator: FeedBaseCoordinatorProtocol?
    
    // MARK: - Initializers
    
    init(output: FeedMainPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func loadView() {
        view = feedMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Feed"
//        navigationItem.searchController = feedMainView.searchController
    }
}

// MARK: - FeedBaseCoordinatedProtocol

extension FeedMainViewController: FeedBaseCoordinatedProtocol {
}

// MARK: - FeedMainPresenterInputProtocol

extension FeedMainViewController: FeedMainPresenterInputProtocol {
    func updateData(data: [Item]) {
        feedMainView.updateData(data: data)
    }
}

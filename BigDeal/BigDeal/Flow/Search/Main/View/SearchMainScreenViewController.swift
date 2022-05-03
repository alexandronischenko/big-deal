import UIKit

class SearchMainViewController: UIViewController {
    // MARK: - Private properties
    
    private let searchMainView = SearchMainView()
    private var output: SearchMainPresenterOutputProtocol?
    
    // MARK: - Protocol properties
    
    var coordinator: SearchBaseCoordinatorProtocol?
    
    // MARK: - Initializers
    
    init(output: SearchMainPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func loadView() {
        view = searchMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Сatalog"
        navigationItem.searchController = searchMainView.searchController
    }
}

// MARK: - SearchBaseCoordinatedProtocol

extension SearchMainViewController: SearchBaseCoordinatedProtocol {
}

// MARK: - SearchMainPresenterInputProtocol

extension SearchMainViewController: SearchMainPresenterInputProtocol {
    func updateData(data: [Item]) {
        searchMainView.updateData(data: data)
    }
}

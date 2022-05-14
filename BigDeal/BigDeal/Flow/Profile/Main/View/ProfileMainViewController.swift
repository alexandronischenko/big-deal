import UIKit

class ProfileMainViewController: UIViewController {
    // MARK: - Private properties
    
    private let profileMainView = ProfileMainView()
    private var output: ProfileMainPresenterOutputProtocol?
    
    private let reuseIdForHeaderView = ProfileMainCollectionReusableView.customHeaderCollectionReusableViewId
    private let reuseIdForItemCell = CustomItemCollectionViewCell.customItemCollectionViewCellReuseId
    private let sectionHeader = UICollectionView.elementKindSectionHeader
    
    // MARK: - Other data and properties
    
    var data: [Item] = DataManager.shared.data
    
    // MARK: - Initializers
    
    init(output: ProfileMainPresenterOutputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }
    
//    deinit {
//        print("Yo")
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func loadView() {
        view = profileMainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpProfileMainCollectionView()
    }
    
    // MARK: - Private properties
    
    private func setUpProfileMainCollectionView() {
        profileMainView.profileMainCollectionView.delegate = self
        profileMainView.profileMainCollectionView.dataSource = self
        let cellClass = CustomItemCollectionViewCell.self
        let viewClass = ProfileMainCollectionReusableView.self
        profileMainView.profileMainCollectionView.register(cellClass, forCellWithReuseIdentifier: reuseIdForItemCell)
        profileMainView.profileMainCollectionView.register(viewClass, forSupplementaryViewOfKind: sectionHeader, withReuseIdentifier: reuseIdForHeaderView)
    }
    
    private func configureView() {
        let button = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapLogout))
        navigationController?.navigationItem.rightBarButtonItem = button
        navigationItem.rightBarButtonItem = button
        title = "Profile"
    }
    
    @objc func didTapLogout() {
        output?.didTapLogout()
    }
}

// MARK: - HeaderCollectionReusableViewDelegate

extension ProfileMainViewController: HeaderCollectionReusableViewDelegate {
    func moveToSettingsScreen() {
        output?.moveToSettingsScreen()
    }
    func moveToSubscriptionsScreen() {
        output?.moveToSubscriptionsScreen()
    }
}

// MARK: - ProfileMainPresenterInputProtocol

extension ProfileMainViewController: ProfileMainPresenterInputProtocol {
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileMainViewController: UICollectionViewDelegateFlowLayout {    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 175.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 80, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 80
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.3, height: 230)
    }
}

// MARK: - UICollectionViewDataSource

extension ProfileMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdForItemCell, for: indexPath) as? CustomItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: sectionHeader, withReuseIdentifier: reuseIdForHeaderView, for: indexPath)
        guard let header = header as? ProfileMainCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = data[indexPath.row]
        output?.moveToDetailFlow(model: model)
    }
}

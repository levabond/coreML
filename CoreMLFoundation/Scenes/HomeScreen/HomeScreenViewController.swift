import UIKit
import Domain
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator
import SnapKit
import Hero

final class HomeScreenViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.backgroundColor = MainTheme.blackColor
        title = "Home".uppercased()
        
        
        setupConstraintrs()
        setupTable()
        setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    
    private func setupConstraintrs() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Setup Table
    
    private func setupTable() {
        tableView.backgroundColor = MainTheme.blackColor
        tableView.separatorStyle = .none
        
        tableView.register(HomeItemCell.self, forCellReuseIdentifier: "HomeCell")
        tableView.register(HomeNewsCell.self, forCellReuseIdentifier: "NewsCell")
        
        let sections: [HomeSectionModel] = HomeItemFactory.makeItems()
        
        let dataSource = HomeScreenViewController.dataSource()
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: 60 / 2)
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }
}


extension HomeScreenViewController {
    static func dataSource() -> RxTableViewSectionedReloadDataSource<HomeSectionModel> {
        return RxTableViewSectionedReloadDataSource<HomeSectionModel>(
            configureCell: { dataSource, table, idxPath, _ in
                switch dataSource[idxPath] {
                case let .HomeSectionItem(model):
                    let cell: HomeItemCell = table.dequeueReusableCell(withIdentifier: "HomeCell", for: idxPath) as! HomeItemCell
                    
                    cell.configure(model)
                    
                    return cell
                case .NewSectionItem(let model):
                    let cell: HomeNewsCell = table.dequeueReusableCell(withIdentifier: "NewsCell", for: idxPath) as! HomeNewsCell
                    
                    cell.configure(model)
                    
                    return cell
                }
        }
        )
    }
}

enum HomeSectionModel {
    case MainProvidableSection(title: String, items: [SectionItem])
    case NewProvidableSection(items: [SectionItem])
}

enum SectionItem {
    case HomeSectionItem(model: HomeItem)
    case NewSectionItem(model: String)
}

extension HomeSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch  self {
        case .MainProvidableSection(title: _, items: let items):
            return items.map { $0 }
        case .NewProvidableSection(let items):
            return items.map { $0 }
        }
    }
    
    init(original: HomeSectionModel, items: [Item]) {
        switch original {
        case let .MainProvidableSection(title: title, items: _):
            self = .MainProvidableSection(title: title, items: items)
        case .NewProvidableSection(let items):
            self = .NewProvidableSection(items: items)
        }
    }
}

extension HomeSectionModel {
    var title: String {
        switch self {
        case .MainProvidableSection(title: let title, items: _):
            return title
        case .NewProvidableSection(_):
            return ""
        }
    }
}

class HomeItemFactory {
    static func makeItems() -> [HomeSectionModel] {
        return [
            .MainProvidableSection(
                title: "Home",
                items: [
                    .HomeSectionItem(model: HomeItem(
                        title: "Комедии",
                        image: "https://m.media-amazon.com/images/M/MV5BMTQwMDU5NDkxNF5BMl5BanBnXkFtZTcwMjk5OTk4OQ@@._V1_SX300.jpg")),
                    .HomeSectionItem(model: HomeItem(
                        title: "Ужасы",
                        image: "https://m.media-amazon.com/images/M/MV5BMTQwMDU5NDkxNF5BMl5BanBnXkFtZTcwMjk5OTk4OQ@@._V1_SX300.jpg")),
                    .HomeSectionItem(model: HomeItem(
                        title: "Боевики",
                        image: "https://m.media-amazon.com/images/M/MV5BMTQwMDU5NDkxNF5BMl5BanBnXkFtZTcwMjk5OTk4OQ@@._V1_SX300.jpg"))
                ]
            ),
            .NewProvidableSection(items: [
                .NewSectionItem(model: "Test")
            ])
        ]
    }
}

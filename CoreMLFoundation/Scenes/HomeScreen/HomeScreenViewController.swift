import UIKit
import Domain
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator
import SnapKit

struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = Int

    var identity: String {
        return header
    }

    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}


final class HomeScreenViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<MySection>?
    
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        setupConstraintrs()
        setupTable()
    }
    
    
    private func setupConstraintrs() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Setup Table
    
    private func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            configureCell: { ds, tv, _, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "Item \(item)"

                return cell
            },
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
            }
        )

        self.dataSource = dataSource

        let sections = [
            MySection(header: "Core", items: [
                1,
                2
            ]),
            MySection(header: "Second section", items: [
                3,
                4
            ])
        ]

        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension HomeScreenViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        // you can also fetch item
        guard let item = dataSource?[indexPath], dataSource?[indexPath.section] != nil else {
            return 0.0
        }

        return CGFloat(40 + item * 10)
    }
}

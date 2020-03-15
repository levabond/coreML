import UIKit
import Domain
import RxSwift
import RxCocoa
import RxDataSources


enum AuthCellType: String {
  case Headline
  case EmailTextField
  case NameTextField
  case PasswordTextField
  case LoginButton
  case Separator
}

extension AuthCellType: IdentifiableType {
  var identity: String { return rawValue }
}

typealias AuthSection = AnimatableSectionModel<Int, AuthCellType>

final class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()

    var viewModel: LoginViewModel!
    var label = UILabel()
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let input = LoginViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
//
//        output.dismiss.drive()
//            .disposed(by: disposeBag)
//        output.saveEnabled.drive(saveButton.rx.isEnabled)
//            .disposed(by: disposeBag)
    }
}

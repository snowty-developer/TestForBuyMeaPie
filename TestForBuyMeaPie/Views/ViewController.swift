//
//  ViewController.swift
//  TestForBuyMeaPie
//
//  Created by Александр Зубарев on 02.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var loadingProgress: UIActivityIndicatorView!
    var viewModel = ViewModel()
    let disposeBag = DisposeBag()
    let cellID = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Истории"
        loadingProgress.startAnimating()
        viewModel.loadData {
            self.bind()
            self.loadingProgress.stopAnimating()
            self.loadingProgress.isHidden = true
        }
    }
    
    private func bind() {
        Observable<[Story]>.just(self.viewModel.stories)
        .bind(to: table.rx.items) { (tableView, row, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StoryTableViewCell
            cell.initCell(item.title, item.image)
            
            return cell
        }
        .disposed(by: disposeBag)
        
        Observable<Int>.just(viewModel.stories.count).map({"Всего - \($0). Последнее обновление \(self.viewModel.dateString)"}).bind(to: self.countLabel.rx.text).disposed(by: disposeBag)
        
        table.rx.modelSelected(Story.self)
            .subscribe(onNext: { [weak self] value in
                let secondVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SecondView") as! SecondViewController
                secondVC.story = value
                self?.navigationController?.pushViewController(secondVC, animated: true)
            })
            .disposed(by: disposeBag)

    }


}


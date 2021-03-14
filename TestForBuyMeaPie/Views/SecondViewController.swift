//
//  SecondViewController.swift
//  TestForBuyMeaPie
//
//  Created by Александр Зубарев on 02.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var titleHistory: UILabel!
    
    var story: Story?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    private func bind() {
        if story != nil {
            Observable<UIImage>.just(self.story!.image!).bind(to: imageView.rx.image).disposed(by: disposeBag)
            Observable<String>.just(self.story!.author).map({"Автор: \($0)"}).bind(to: authorLabel.rx.text).disposed(by: disposeBag)
            Observable<String>.just(self.story!.description).map({"Описание: \n \($0)"}).bind(to: descriptionText.rx.text).disposed(by: disposeBag)
            Observable<String>.just(self.story!.title).bind(to: titleHistory.rx.text).disposed(by: disposeBag)
        }
        
    }

}

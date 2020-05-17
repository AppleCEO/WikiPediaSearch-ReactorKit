//
//  WikiPediaSearchViewController.swift
//  WikiPediaSearch
//
//  Created by joon-ho kil on 2020/05/17.
//  Copyright © 2020 joon-ho kil. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

class WikiPediaSearchViewController: UIViewController, View {
  @IBOutlet var searchBar: UISearchBar!
  @IBOutlet var tableView: UITableView!
    
  var disposeBag = DisposeBag()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    reactor = WikiPediaSearchViewReactor()
  }
    
  func bind(reactor: WikiPediaSearchViewReactor) {
    searchBar.rx.text
      .map { Reactor.Action.updateQuery($0)}
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.repos }
      .bind(to: tableView.rx.items(cellIdentifier: "cell")) { IndexPath, repo, cell in
      cell.textLabel?.text = repo
    }
    .disposed(by: disposeBag)
  }
}

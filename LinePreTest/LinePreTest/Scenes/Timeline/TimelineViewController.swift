//
//  TimelineViewController.swift
//  LinePreTest
//
//  Created by Thanaphat Suwannikornkul on 28/12/62 BE.
//  Copyright (c) 2562 Thanaphat Suwannikornkul. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import JGProgressHUD

protocol TimelineDisplayLogic: class
{
  func displayNewsFeed(viewModel: Timeline.NewsFeed.ViewModel)
}

class TimelineViewController: UIViewController, TimelineDisplayLogic, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
  var interactor: TimelineBusinessLogic?
  var router: (NSObjectProtocol & TimelineRoutingLogic & TimelineDataPassing)?
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = TimelineInteractor()
    let presenter = TimelinePresenter()
    let router = TimelineRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    initLayout()
    requestTimelineNewsFeed()
  }
  
  // MARK: IBOutlet
  
  @IBOutlet weak var newsfeedTableView: UITableView!
  
  // MARK: IBAction
  
  @IBAction func onPressNewPostButton(_ sender: Any) {
    router?.routeToNewPost(segue: nil)
  }
  
  // MARK: Do something
  
  var newsFeedDatasource:[PostAlbum] = []
  var filteredNewsFeedDatasource:[PostAlbum] = []
  
  let hud = JGProgressHUD(style: .dark)
  
  func initLayout()
  {
    title = "Timeline"
    
    newsfeedTableView.register(UINib(nibName: "TimelineTableViewCell", bundle: nil), forCellReuseIdentifier: "TimelineTableViewCell")
  }
  
  func requestTimelineNewsFeed()
  {
    hud.textLabel.text = "Loading"
    hud.show(in: self.view)
    
    let request = Timeline.NewsFeed.Request(token: "kIRtPjxyscyQoVCyBDfvIkUm1Sci7UW-a-zH")
    interactor?.fetchNewsFeed(request: request)
  }
  
  // MARK: TimelineDisplayLogic
  
  func displayNewsFeed(viewModel: Timeline.NewsFeed.ViewModel)
  {
    newsFeedDatasource = viewModel.postAlbums
    filteredNewsFeedDatasource = viewModel.postAlbums
    
    newsfeedTableView.reloadData()
    
    hud.dismiss()
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredNewsFeedDatasource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell

    let item:PostAlbum = filteredNewsFeedDatasource[indexPath.row]
    cell.displayCell(postAlbum: item)

    return cell
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    self.view.endEditing(true)
  }
  
  // MARK: UISearchBarDelegate
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.count > 0 {
      filteredNewsFeedDatasource = newsFeedDatasource.filter { (album) -> Bool in
        return album.title.lowercased().contains(searchText.lowercased())
      }
    } else {
      filteredNewsFeedDatasource = newsFeedDatasource
    }
    
    newsfeedTableView.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.view.endEditing(true)
  }
}

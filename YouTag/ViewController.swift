//
//  ViewController.swift
//  YouTag
//
//  Created by Youstanzr on 8/12/19.
//  Copyright © 2019 Youstanzr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FilterPickerViewDelegate, YYTTagViewDelegate, PlaylistManagerDelegate {
	
	var tagsView: YYTFilterTagView!
	var playlistManager = PlaylistManager()
	var filterPickerView: FilterPickerView!
	var menuButton: UIButton = {
		let btn = UIButton()
		btn.imageView!.contentMode = .scaleAspectFit
		btn.setImage(UIImage(named: "list"), for: UIControl.State.normal)
		return btn
	}()
	var filterButton: UIButton = {
		let btn = UIButton()
		btn.setImage(UIImage(named: "filter"), for: UIControl.State.normal)
		return btn
	}()
	var settingButton: UIButton = {
		let btn = UIButton()
		btn.setImage(UIImage(named: "settings"), for: UIControl.State.normal)
		return btn
	}()
	let titleLabel: UILabel = {
		let lbl = UILabel()
		lbl.text = "YouTag"
		lbl.font = UIFont.init(name: "DINCondensed-Bold", size: 28)
		lbl.textAlignment = .left
		return lbl
	}()
	let versionLabel: UILabel = {
		let lbl = UILabel()
		lbl.text = "v" + UIApplication.shared.buildNumber!
		lbl.font = UIFont.init(name: "DINCondensed-Bold", size: 14)
		lbl.textAlignment = .right
		lbl.textColor = .lightGray
		return lbl
	}()
	let logoImageView: UIImageView = {
		let imgView = UIImageView(image: UIImage(named: "logo"))
		imgView.contentMode = .scaleAspectFit
		return imgView
	}()
	let logoView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = GraphicColors.backgroundWhite
		
		self.view.addSubview(logoView)
		logoView.translatesAutoresizingMaskIntoConstraints = false
		logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		logoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 44).isActive = true
		logoView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.29).isActive = true
		logoView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.09).isActive = true
		
		logoView.addSubview(logoImageView)
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.leadingAnchor.constraint(equalTo: logoView.leadingAnchor).isActive = true
		logoImageView.centerYAnchor.constraint(equalTo: logoView.centerYAnchor).isActive = true
		logoImageView.widthAnchor.constraint(equalTo: logoView.widthAnchor, multiplier: 0.4).isActive = true
		logoImageView.heightAnchor.constraint(equalTo: logoView.heightAnchor).isActive = true

		logoView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.trailingAnchor.constraint(equalTo: logoView.trailingAnchor).isActive = true
		titleLabel.centerYAnchor.constraint(equalTo: logoView.centerYAnchor, constant: 3).isActive = true
		titleLabel.widthAnchor.constraint(equalTo: logoView.widthAnchor, multiplier: 0.58).isActive = true
		titleLabel.heightAnchor.constraint(equalTo: logoView.heightAnchor).isActive = true
		
		menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
		self.view.addSubview(menuButton)
		menuButton.translatesAutoresizingMaskIntoConstraints = false
		menuButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
		menuButton.topAnchor.constraint(equalTo: self.logoView.topAnchor).isActive = true
		menuButton.widthAnchor.constraint(equalTo: self.logoView.heightAnchor, multiplier: 0.8).isActive = true
		menuButton.heightAnchor.constraint(equalTo: self.logoView.heightAnchor).isActive = true
		
		settingButton.addTarget(self, action: #selector(settingButtonAction), for: .touchUpInside)
		self.view.addSubview(settingButton)
		settingButton.translatesAutoresizingMaskIntoConstraints = false
		settingButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
		settingButton.topAnchor.constraint(equalTo: self.logoView.topAnchor).isActive = true
		settingButton.widthAnchor.constraint(equalTo: self.logoView.heightAnchor, multiplier: 0.9).isActive = true
		settingButton.heightAnchor.constraint(equalTo: self.logoView.heightAnchor, multiplier: 0.9).isActive = true

		filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
		self.view.addSubview(filterButton)
		filterButton.translatesAutoresizingMaskIntoConstraints = false
		filterButton.trailingAnchor.constraint(equalTo: self.menuButton.trailingAnchor).isActive = true
		filterButton.topAnchor.constraint(equalTo: self.menuButton.bottomAnchor, constant: 15).isActive = true
		filterButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
		filterButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
		
		tagsView = YYTFilterTagView(frame: .zero, tagsList: NSMutableArray(), isDeleteEnabled: true)
		tagsView.yytdelegate = self
		self.view.addSubview(tagsView)
		tagsView.translatesAutoresizingMaskIntoConstraints = false
		tagsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
		tagsView.trailingAnchor.constraint(equalTo: self.filterButton.leadingAnchor, constant: -10).isActive = true
		tagsView.topAnchor.constraint(equalTo: filterButton.topAnchor).isActive = true
		tagsView.heightAnchor.constraint(equalTo: filterButton.heightAnchor).isActive = true
		
		self.view.addSubview(versionLabel)
		versionLabel.translatesAutoresizingMaskIntoConstraints = false
		versionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
		versionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25).isActive = true
		versionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1).isActive = true
		versionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
        playlistManager.plmDelegate = self
		playlistManager.nowPlayingView.backgroundColor = .clear
		playlistManager.nowPlayingView.addBorder(side: .top, color: .lightGray, width: 1.0)
		playlistManager.nowPlayingView.addBorder(side: .bottom, color: .lightGray, width: 1.0)
		self.view.addSubview(playlistManager.nowPlayingView)
		playlistManager.nowPlayingView.translatesAutoresizingMaskIntoConstraints = false
		playlistManager.nowPlayingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		playlistManager.nowPlayingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		playlistManager.nowPlayingView.topAnchor.constraint(equalTo: tagsView.bottomAnchor, constant: 15).isActive = true
		playlistManager.nowPlayingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
		
		playlistManager.playlistLibraryView.backgroundColor = .clear
		self.view.addSubview(playlistManager.playlistLibraryView)
		playlistManager.playlistLibraryView.translatesAutoresizingMaskIntoConstraints = false
		playlistManager.playlistLibraryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		playlistManager.playlistLibraryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		playlistManager.playlistLibraryView.topAnchor.constraint(equalTo: playlistManager.nowPlayingView.bottomAnchor, constant: 5).isActive = true
		playlistManager.playlistLibraryView.bottomAnchor.constraint(equalTo: versionLabel.topAnchor).isActive = true
		
		filterPickerView = FilterPickerView()
		filterPickerView.delegate = self
		self.view.addSubview(filterPickerView)
		filterPickerView.translatesAutoresizingMaskIntoConstraints = false
		filterPickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		filterPickerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		filterPickerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		filterPickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
	}
    
    func didPressedEditAction(url: URL) {
        //Set the link to share.
        let objectsToShare = [url] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		playlistManager.computePlaylist()
		playlistManager.playlistLibraryView.scrollToTop()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		playlistManager.audioPlayer.pause()
	}
	
	@objc func menuButtonAction(sender: UIButton!) {
		print("Menu Button tapped")
		let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let LVC: LibraryViewController = storyboard.instantiateViewController(withIdentifier: "LibraryViewController") as! LibraryViewController
		LVC.modalPresentationStyle = .fullScreen
		LVC.modalTransitionStyle = .coverVertical
		self.present(LVC, animated: true, completion: {
			self.tagsView.removeAllTags()
		})
	}
	
	@objc func settingButtonAction(sender: UIButton!) {
		print("Setting Button tapped")
		let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let SVC: SettingViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
		SVC.modalPresentationStyle = .fullScreen
		SVC.modalTransitionStyle = .coverVertical
		self.present(SVC, animated: true, completion: {
			self.tagsView.removeAllTags()
		})
	}

	
	@objc func filterButtonAction(sender: UIButton!) {
		print("Filter Button tapped")
		filterPickerView.show(animated: true)
	}
	
	// MARK: YYTTagViewDelegate
	//For tag list that shows the chosen tags
	func tagsListChanged(newTagsList: NSMutableArray) {
		let filtersArr = playlistManager.playlistFilters.getFilters()
		let deletedFilters = NSMutableArray()
		for i in 0 ..< filtersArr.count {
			if !newTagsList.contains(filtersArr.object(at: i)) {
				deletedFilters.add(filtersArr.object(at: i))
			}
		}
		playlistManager.playlistFilters.deleteFilter(using: deletedFilters)
		playlistManager.computePlaylist()
	}
	
	// MARK: FilterPickerViewDelegate
	//For the tag list the are added
	func processNewFilter(type: String, filters: NSMutableArray) {
		playlistManager.playlistFilters.addUniqueFilter(filters, type: PlaylistFilters.FilterType(rawValue: type)!)
		playlistManager.computePlaylist()
		tagsView.tagsList = playlistManager.playlistFilters.getFilters()
		tagsView.reloadData()
	}
	
}

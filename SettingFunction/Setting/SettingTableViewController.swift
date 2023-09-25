//
//  SettingTableViewController.swift
//  SimpleCounter
//
//  Created by 村中令 on 2023/01/25.
//

import UIKit
import MediaPlayer
import AVFoundation

class SettingTableViewController: UITableViewController {
    @IBOutlet weak private var darkModeLabel: UILabel!
    @IBOutlet weak private var darkModeSegmentedControl: UISegmentedControl!
    private var userDefaults: UserDefaultsSetting = UserDefaultsSetting()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewSegmentControl()
        configureViewDarkMode()
        showNavigationBar(isHidden: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func showNavigationBar(isHidden: Bool){
        self.navigationController?.setNavigationBarHidden(isHidden, animated: false)
    }

    @IBAction func changeDarkModeONOFF(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.overrideUserInterfaceStyle = .dark
            userDefaults.save(setting: .darkMode(true))
        } else if sender.selectedSegmentIndex == 1 {
            self.overrideUserInterfaceStyle = .light
            userDefaults.save(setting: .darkMode(false))
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0
        {
            // review
            showReviewAppStore(
                appURL: <#T##Set Arguments#>
            )
        }
        if indexPath.section == 1 && indexPath.row == 1
        {
            // share
            showShareSheet(
                appURL: <#T##Set Arguments#>
            )

        }
        if indexPath.section == 1 && indexPath.row == 2
        {
            // Other Apps
            showAppList()

        }
    }

    // MARK: - View関係
    private func configureViewSegmentControl() {
        if userDefaults.loadBool(setting: .darkMode) {
            darkModeSegmentedControl.selectedSegmentIndex = 0
        } else {
            darkModeSegmentedControl.selectedSegmentIndex = 1
        }
    }

    private func showReviewAppStore(appURL: String) {
        guard let url = URL(
            string: "\(appURL)?action=write-review") else { return }
        UIApplication.shared.open(url)
    }

    private func showShareSheet(appURL: String) {
        let items = URL(string: appURL)!
          let activityVC = UIActivityViewController(activityItems: [items], applicationActivities: nil)
          // 追加ここから
          if UIDevice.current.userInterfaceIdiom == .pad {
              if let popPC = activityVC.popoverPresentationController {
                     popPC.sourceView = activityVC.view
                     popPC.barButtonItem = .none
                     popPC.sourceRect = activityVC.accessibilityFrame
              }
          }
          // 追加ここまで
          let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
          let rootVC = windowScene?.windows.first?.rootViewController
          rootVC?.present(activityVC, animated: true,completion: {})
    }
    private func showAppList() {
        guard let url = URL(string: "https://sites.google.com/view/muranakar") else { return }
            UIApplication.shared.open(url)
    }



    private func configureViewDarkMode() {
        if userDefaults.loadBool(setting: .darkMode) {
            self.overrideUserInterfaceStyle = .dark
        } else {
            self.overrideUserInterfaceStyle = .light
        }
    }
}

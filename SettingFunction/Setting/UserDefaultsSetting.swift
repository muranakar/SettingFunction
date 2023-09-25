//
//  UserDefaultsSetting.swift
//  SimpleCounter
//
//  Created by 村中令 on 2023/01/27.
//

import Foundation

struct UserDefaultsSetting {
    let userDefaults = UserDefaults.standard

    init() {
        // 初期設定
        userDefaults.register(
            defaults: [
                "darkMode" : false,
            ]
        )
    }
    func removeAll() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }

    func initialize(isDarkMode: Bool) {
        userDefaults.register(
            defaults: [
                "darkMode" : isDarkMode,
            ]
        )
    }


    func save(setting: SettingSave){
        switch setting {
        case .darkMode(let value):
            userDefaults.set(value, forKey: setting.key)
        }
    }

    func loadBool(setting: SettingLoad) -> Bool  {
        if setting == .darkMode {
            let loadedValue = UserDefaults.standard.bool(forKey: setting.key)
            return loadedValue
        }
        fatalError()
    }
}

enum SettingLoad {
    case darkMode
    var key: String {
        switch self {
        case .darkMode:
            return "darkMode"
        }
    }
}

enum SettingSave {
    case darkMode(Bool)
    var key: String {
        switch self {

        case .darkMode(_):
            return "darkMode"

        }
    }
}


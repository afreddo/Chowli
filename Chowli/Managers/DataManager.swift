//
//  DataManager.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import Foundation

struct DataManager {
    let saveKey = "Profile"
    
    @MainActor func loadProfile() -> Profile {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Profile.self, from: data) {
                return decoded
            }
        }
        
        return Profile.newProfile
    }
    
    @MainActor func saveProfile(_ profile: Profile) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}

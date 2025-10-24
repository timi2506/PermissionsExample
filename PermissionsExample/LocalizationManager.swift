//
//  LocalizationManager.swift
//  PermissionsExample
//
//  Created by Tim on 24.10.25.
//

import SwiftUI
import Permissions

struct LocalizationProvider: PermissionsLocalizationProvider {
    func makeLocalizedTitle(for type: Permissions.PermissionType) -> LocalizedStringKey {
        switch type {
            case .camera:
                "Camera"
            case .microphone:
                "Microphone"
            case .locationWhenInUse:
                "Location when in Use"
            case .locationAlways:
                "Location at all Times"
            case .notifications:
                "Notifications"
            case .photoLibrary:
                "Photo Library"
            case .contacts:
                "Contacts"
            case .bluetooth:
                "Bluetooth"
        }
    }
    
    func makeLocalizedDescription(for type: Permissions.PermissionType) -> LocalizedStringKey {
        DefaultPermissionsLocalizationProvider.defaultProvider.makeLocalizedDescription(for: type)
    }
    
    var sheetHeader: LocalizedStringKey = ""
    
    var allSetTitle: LocalizedStringKey
    
    var allSetDescription: LocalizedStringKey
    
    var grantedTitle: LocalizedStringKey
    
    var notGrantedTitle: LocalizedStringKey
    
    var grantButtonTitle: LocalizedStringKey
    
    var continueButtonTitle: LocalizedStringKey
    
    var doneButtonTitle: LocalizedStringKey
    
    var waitingTitle: LocalizedStringKey
    
    var tapHereToSkipButtonTitle: LocalizedStringKey
    
    var skipNoticeText: LocalizedStringKey
    
    var helpNavigationTitle: LocalizedStringKey
    
    var whatDoesThisPermissionDoSectionTitle: LocalizedStringKey
    
    var permissionsTitle: LocalizedStringKey
    
    var cantGrantSectionTitle: LocalizedStringKey
    
    var cantGrantHelpText: LocalizedStringKey
    
    var needHelpButtonTitle: LocalizedStringKey
    
    
}

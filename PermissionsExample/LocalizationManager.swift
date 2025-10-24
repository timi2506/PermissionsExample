//
//  LocalizationManager.swift
//  PermissionsExample
//
//  Created by Tim on 24.10.25.
//

import SwiftUI
import Permissions

struct LocalizationProvider: PermissionsLocalizationProvider {
    public var needHelpButtonTitle: LocalizedStringKey = "Need help?"
    public var cantGrantHelpText: LocalizedStringKey = "Don't worry! This usally happens when the Permission Prompt was dismissed too early or you declined this Permission before, tap this Message to open Settings and Grant the Permission manually there"
    public var cantGrantSectionTitle: LocalizedStringKey = "I can't grant this Permission!"
    public var permissionsTitle: LocalizedStringKey = "Permissions"
    public var whatDoesThisPermissionDoSectionTitle: LocalizedStringKey = "What does this Permission do?"
    public var helpNavigationTitle: LocalizedStringKey = "Help"
    public var tapHereToSkipButtonTitle: LocalizedStringKey = "Tap here to Skip"
    public var skipNoticeText: LocalizedStringKey = "If you do not want to grant this Permission, you can"
    public var grantButtonTitle: LocalizedStringKey = "Grant"
    public var continueButtonTitle: LocalizedStringKey = "Continue"
    public var doneButtonTitle: LocalizedStringKey = "Done"
    public var waitingTitle: LocalizedStringKey = "Waiting"
    public var grantedTitle: LocalizedStringKey = "Granted"
    public var notGrantedTitle: LocalizedStringKey = "Not Granted"
    public var allSetDescription: LocalizedStringKey = "Tap Done below to start using this App"
    public var allSetTitle: LocalizedStringKey = "All Set!"
    public func makeLocalizedTitle(for type: PermissionType) -> LocalizedStringKey {
        return switch type {
            case .camera:
                "Camera"
            case .microphone:
                "Microphone"
            case .locationWhenInUse:
                "Location while in Use"
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
    public func makeLocalizedDescription(for type: PermissionType) -> LocalizedStringKey {
        return switch type {
            case .camera:
                "The \"Camera\" permission allows this app to access your camera to take photos or record videos.\n\nExample: A camera app that lets you capture photos and videos directly within the app."
            case .microphone:
                "The \"Microphone\" permission allows this app to access your microphone to record audio.\n\nExample: A voice memos app that lets you record audio notes."
            case .locationWhenInUse:
                "The \"Location While in Use\" permission allows this app to access your location only while you are actively using it.\n\nExample: A weather app that shows your current weather based on your precise location while the app is open."
            case .locationAlways:
                "The \"Location Always\" permission allows this app to access your location even when it is running in the background.\n\nExample: A navigation app that provides turn-by-turn directions even when you switch to another app."
            case .notifications:
                "The \"Notifications\" permission allows this app to send you alerts and updates.\n\nExample: A messaging app that notifies you of new messages in your chats."
            case .photoLibrary:
                "The \"Photo Library\" permission allows this app to access and modify your photos.\n\nExample: A photo viewer app that lets you browse, edit, and organize your photos."
            case .contacts:
                "The \"Contacts\" permission allows this app to access your contacts.\n\nExample: A messaging app that helps you find friends and connect with people in your contact list."
            case .bluetooth:
                "The \"Bluetooth\" permission allows this app to connect to nearby devices using Bluetooth.\n\nExample: A fitness app that syncs data with a Bluetooth heart rate monitor."
        }
    }
    public var sheetHeader: LocalizedStringKey = "This App Requires Access to"
}

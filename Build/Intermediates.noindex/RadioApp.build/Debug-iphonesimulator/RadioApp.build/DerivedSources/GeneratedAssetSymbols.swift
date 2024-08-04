import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

    /// The "darkBlueApp" asset catalog color resource.
    static let darkBlueApp = ColorResource(name: "darkBlueApp", bundle: resourceBundle)

    /// The "lightBlueApp" asset catalog color resource.
    static let lightBlueApp = ColorResource(name: "lightBlueApp", bundle: resourceBundle)

    /// The "neonBlueApp" asset catalog color resource.
    static let neonBlueApp = ColorResource(name: "neonBlueApp", bundle: resourceBundle)

    /// The "pinkApp" asset catalog color resource.
    static let pinkApp = ColorResource(name: "pinkApp", bundle: resourceBundle)

    /// The "tealApp" asset catalog color resource.
    static let tealApp = ColorResource(name: "tealApp", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "AML1708" asset catalog image resource.
    static let AML_1708 = ImageResource(name: "AML1708", bundle: resourceBundle)

    /// The "Back" asset catalog image resource.
    static let back = ImageResource(name: "Back", bundle: resourceBundle)

    /// The "DmitriyLubov" asset catalog image resource.
    static let dmitriyLubov = ImageResource(name: "DmitriyLubov", bundle: resourceBundle)

    /// The "NatalyaLuzyanina" asset catalog image resource.
    static let natalyaLuzyanina = ImageResource(name: "NatalyaLuzyanina", bundle: resourceBundle)

    /// The "ShapovalovIlya" asset catalog image resource.
    static let shapovalovIlya = ImageResource(name: "ShapovalovIlya", bundle: resourceBundle)

    /// The "alert" asset catalog image resource.
    static let alert = ImageResource(name: "alert", bundle: resourceBundle)

    /// The "arrow-back" asset catalog image resource.
    static let arrowBack = ImageResource(name: "arrow-back", bundle: resourceBundle)

    /// The "arrow-ios-downward" asset catalog image resource.
    static let arrowIosDownward = ImageResource(name: "arrow-ios-downward", bundle: resourceBundle)

    /// The "audio" asset catalog image resource.
    static let audio = ImageResource(name: "audio", bundle: resourceBundle)

    /// The "backButton" asset catalog image resource.
    static let backButton = ImageResource(name: "backButton", bundle: resourceBundle)

    /// The "bgLogin" asset catalog image resource.
    static let bgLogin = ImageResource(name: "bgLogin", bundle: resourceBundle)

    /// The "bgOnboarding" asset catalog image resource.
    static let bgOnboarding = ImageResource(name: "bgOnboarding", bundle: resourceBundle)

    /// The "bg_nontransparent" asset catalog image resource.
    static let bgNontransparent = ImageResource(name: "bg_nontransparent", bundle: resourceBundle)

    /// The "calendar" asset catalog image resource.
    static let calendar = ImageResource(name: "calendar", bundle: resourceBundle)

    /// The "clock" asset catalog image resource.
    static let clock = ImageResource(name: "clock", bundle: resourceBundle)

    /// The "close_1" asset catalog image resource.
    static let close1 = ImageResource(name: "close_1", bundle: resourceBundle)

    /// The "closed_caption" asset catalog image resource.
    static let closedCaption = ImageResource(name: "closed_caption", bundle: resourceBundle)

    /// The "devices" asset catalog image resource.
    static let devices = ImageResource(name: "devices", bundle: resourceBundle)

    /// The "download" asset catalog image resource.
    static let download = ImageResource(name: "download", bundle: resourceBundle)

    /// The "download_for_offline_black_24dp 1" asset catalog image resource.
    static let downloadForOfflineBlack24Dp1 = ImageResource(name: "download_for_offline_black_24dp 1", bundle: resourceBundle)

    /// The "dr4gons1ayer01" asset catalog image resource.
    static let dr4Gons1Ayer01 = ImageResource(name: "dr4gons1ayer01", bundle: resourceBundle)

    /// The "edit" asset catalog image resource.
    static let edit = ImageResource(name: "edit", bundle: resourceBundle)

    /// The "eye-off" asset catalog image resource.
    static let eyeOff = ImageResource(name: "eye-off", bundle: resourceBundle)

    /// The "favOff" asset catalog image resource.
    static let favOff = ImageResource(name: "favOff", bundle: resourceBundle)

    /// The "favOn" asset catalog image resource.
    static let favOn = ImageResource(name: "favOn", bundle: resourceBundle)

    /// The "film" asset catalog image resource.
    static let film = ImageResource(name: "film", bundle: resourceBundle)

    /// The "finish" asset catalog image resource.
    static let finish = ImageResource(name: "finish", bundle: resourceBundle)

    /// The "fullscreen" asset catalog image resource.
    static let fullscreen = ImageResource(name: "fullscreen", bundle: resourceBundle)

    /// The "globe" asset catalog image resource.
    static let globe = ImageResource(name: "globe", bundle: resourceBundle)

    /// The "googlePlus" asset catalog image resource.
    static let googlePlus = ImageResource(name: "googlePlus", bundle: resourceBundle)

    /// The "hd" asset catalog image resource.
    static let hd = ImageResource(name: "hd", bundle: resourceBundle)

    /// The "heart" asset catalog image resource.
    static let heart = ImageResource(name: "heart", bundle: resourceBundle)

    /// The "highlight" asset catalog image resource.
    static let highlight = ImageResource(name: "highlight", bundle: resourceBundle)

    /// The "home" asset catalog image resource.
    static let home = ImageResource(name: "home", bundle: resourceBundle)

    /// The "iconNoBg" asset catalog image resource.
    static let iconNoBg = ImageResource(name: "iconNoBg", bundle: resourceBundle)

    /// The "mockPic" asset catalog image resource.
    static let mockPic = ImageResource(name: "mockPic", bundle: resourceBundle)

    /// The "notification" asset catalog image resource.
    static let notification = ImageResource(name: "notification", bundle: resourceBundle)

    /// The "onboarding" asset catalog image resource.
    static let onboarding = ImageResource(name: "onboarding", bundle: resourceBundle)

    /// The "padlock" asset catalog image resource.
    static let padlock = ImageResource(name: "padlock", bundle: resourceBundle)

    /// The "pause" asset catalog image resource.
    static let pause = ImageResource(name: "pause", bundle: resourceBundle)

    /// The "person" asset catalog image resource.
    static let person = ImageResource(name: "person", bundle: resourceBundle)

    /// The "play" asset catalog image resource.
    static let play = ImageResource(name: "play", bundle: resourceBundle)

    /// The "playerBack" asset catalog image resource.
    static let playerBack = ImageResource(name: "playerBack", bundle: resourceBundle)

    /// The "playerNext" asset catalog image resource.
    static let playerNext = ImageResource(name: "playerNext", bundle: resourceBundle)

    /// The "playerPause" asset catalog image resource.
    static let playerPause = ImageResource(name: "playerPause", bundle: resourceBundle)

    /// The "playerPlay" asset catalog image resource.
    static let playerPlay = ImageResource(name: "playerPlay", bundle: resourceBundle)

    /// The "profileTab" asset catalog image resource.
    static let profileTab = ImageResource(name: "profileTab", bundle: resourceBundle)

    /// The "puzzle" asset catalog image resource.
    static let puzzle = ImageResource(name: "puzzle", bundle: resourceBundle)

    /// The "questionIcon" asset catalog image resource.
    static let questionIcon = ImageResource(name: "questionIcon", bundle: resourceBundle)

    /// The "realeti" asset catalog image resource.
    static let realeti = ImageResource(name: "realeti", bundle: resourceBundle)

    /// The "remove_i" asset catalog image resource.
    static let removeI = ImageResource(name: "remove_i", bundle: resourceBundle)

    /// The "ridebyhorse" asset catalog image resource.
    static let ridebyhorse = ImageResource(name: "ridebyhorse", bundle: resourceBundle)

    /// The "search" asset catalog image resource.
    static let search = ImageResource(name: "search", bundle: resourceBundle)

    /// The "settings" asset catalog image resource.
    static let settings = ImageResource(name: "settings", bundle: resourceBundle)

    /// The "settingsGear" asset catalog image resource.
    static let settingsGear = ImageResource(name: "settingsGear", bundle: resourceBundle)

    /// The "share" asset catalog image resource.
    static let share = ImageResource(name: "share", bundle: resourceBundle)

    /// The "shield" asset catalog image resource.
    static let shield = ImageResource(name: "shield", bundle: resourceBundle)

    /// The "star" asset catalog image resource.
    static let star = ImageResource(name: "star", bundle: resourceBundle)

    /// The "trash-bin" asset catalog image resource.
    static let trashBin = ImageResource(name: "trash-bin", bundle: resourceBundle)

    /// The "voteOff" asset catalog image resource.
    static let voteOff = ImageResource(name: "voteOff", bundle: resourceBundle)

    /// The "voteOn" asset catalog image resource.
    static let voteOn = ImageResource(name: "voteOn", bundle: resourceBundle)

    /// The "wishlist" asset catalog image resource.
    static let wishlist = ImageResource(name: "wishlist", bundle: resourceBundle)

    /// The "workspace_premium_black" asset catalog image resource.
    static let workspacePremiumBlack = ImageResource(name: "workspace_premium_black", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "darkBlueApp" asset catalog color.
    static var darkBlueApp: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .darkBlueApp)
#else
        .init()
#endif
    }

    /// The "lightBlueApp" asset catalog color.
    static var lightBlueApp: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightBlueApp)
#else
        .init()
#endif
    }

    /// The "neonBlueApp" asset catalog color.
    static var neonBlueApp: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .neonBlueApp)
#else
        .init()
#endif
    }

    /// The "pinkApp" asset catalog color.
    static var pinkApp: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pinkApp)
#else
        .init()
#endif
    }

    /// The "tealApp" asset catalog color.
    static var tealApp: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tealApp)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "darkBlueApp" asset catalog color.
    static var darkBlueApp: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .darkBlueApp)
#else
        .init()
#endif
    }

    /// The "lightBlueApp" asset catalog color.
    static var lightBlueApp: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .lightBlueApp)
#else
        .init()
#endif
    }

    /// The "neonBlueApp" asset catalog color.
    static var neonBlueApp: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .neonBlueApp)
#else
        .init()
#endif
    }

    /// The "pinkApp" asset catalog color.
    static var pinkApp: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .pinkApp)
#else
        .init()
#endif
    }

    /// The "tealApp" asset catalog color.
    static var tealApp: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .tealApp)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// The "darkBlueApp" asset catalog color.
    static var darkBlueApp: SwiftUI.Color { .init(.darkBlueApp) }

    /// The "lightBlueApp" asset catalog color.
    static var lightBlueApp: SwiftUI.Color { .init(.lightBlueApp) }

    /// The "neonBlueApp" asset catalog color.
    static var neonBlueApp: SwiftUI.Color { .init(.neonBlueApp) }

    /// The "pinkApp" asset catalog color.
    static var pinkApp: SwiftUI.Color { .init(.pinkApp) }

    /// The "tealApp" asset catalog color.
    static var tealApp: SwiftUI.Color { .init(.tealApp) }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "darkBlueApp" asset catalog color.
    static var darkBlueApp: SwiftUI.Color { .init(.darkBlueApp) }

    /// The "lightBlueApp" asset catalog color.
    static var lightBlueApp: SwiftUI.Color { .init(.lightBlueApp) }

    /// The "neonBlueApp" asset catalog color.
    static var neonBlueApp: SwiftUI.Color { .init(.neonBlueApp) }

    /// The "pinkApp" asset catalog color.
    static var pinkApp: SwiftUI.Color { .init(.pinkApp) }

    /// The "tealApp" asset catalog color.
    static var tealApp: SwiftUI.Color { .init(.tealApp) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "AML1708" asset catalog image.
    static var AML_1708: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .AML_1708)
#else
        .init()
#endif
    }

    /// The "Back" asset catalog image.
    static var back: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .back)
#else
        .init()
#endif
    }

    /// The "DmitriyLubov" asset catalog image.
    static var dmitriyLubov: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dmitriyLubov)
#else
        .init()
#endif
    }

    /// The "NatalyaLuzyanina" asset catalog image.
    static var natalyaLuzyanina: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .natalyaLuzyanina)
#else
        .init()
#endif
    }

    /// The "ShapovalovIlya" asset catalog image.
    static var shapovalovIlya: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shapovalovIlya)
#else
        .init()
#endif
    }

    /// The "alert" asset catalog image.
    static var alert: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .alert)
#else
        .init()
#endif
    }

    /// The "arrow-back" asset catalog image.
    static var arrowBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .arrowBack)
#else
        .init()
#endif
    }

    /// The "arrow-ios-downward" asset catalog image.
    static var arrowIosDownward: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .arrowIosDownward)
#else
        .init()
#endif
    }

    /// The "audio" asset catalog image.
    static var audio: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .audio)
#else
        .init()
#endif
    }

    /// The "backButton" asset catalog image.
    static var backButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .backButton)
#else
        .init()
#endif
    }

    /// The "bgLogin" asset catalog image.
    static var bgLogin: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bgLogin)
#else
        .init()
#endif
    }

    /// The "bgOnboarding" asset catalog image.
    static var bgOnboarding: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bgOnboarding)
#else
        .init()
#endif
    }

    /// The "bg_nontransparent" asset catalog image.
    static var bgNontransparent: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bgNontransparent)
#else
        .init()
#endif
    }

    /// The "calendar" asset catalog image.
    static var calendar: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .calendar)
#else
        .init()
#endif
    }

    /// The "clock" asset catalog image.
    static var clock: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clock)
#else
        .init()
#endif
    }

    /// The "close_1" asset catalog image.
    static var close1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .close1)
#else
        .init()
#endif
    }

    /// The "closed_caption" asset catalog image.
    static var closedCaption: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .closedCaption)
#else
        .init()
#endif
    }

    /// The "devices" asset catalog image.
    static var devices: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .devices)
#else
        .init()
#endif
    }

    /// The "download" asset catalog image.
    static var download: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .download)
#else
        .init()
#endif
    }

    /// The "download_for_offline_black_24dp 1" asset catalog image.
    static var downloadForOfflineBlack24Dp1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .downloadForOfflineBlack24Dp1)
#else
        .init()
#endif
    }

    /// The "dr4gons1ayer01" asset catalog image.
    static var dr4Gons1Ayer01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dr4Gons1Ayer01)
#else
        .init()
#endif
    }

    /// The "edit" asset catalog image.
    static var edit: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .edit)
#else
        .init()
#endif
    }

    /// The "eye-off" asset catalog image.
    static var eyeOff: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .eyeOff)
#else
        .init()
#endif
    }

    /// The "favOff" asset catalog image.
    static var favOff: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .favOff)
#else
        .init()
#endif
    }

    /// The "favOn" asset catalog image.
    static var favOn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .favOn)
#else
        .init()
#endif
    }

    /// The "film" asset catalog image.
    static var film: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .film)
#else
        .init()
#endif
    }

    /// The "finish" asset catalog image.
    static var finish: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .finish)
#else
        .init()
#endif
    }

    /// The "fullscreen" asset catalog image.
    static var fullscreen: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fullscreen)
#else
        .init()
#endif
    }

    /// The "globe" asset catalog image.
    static var globe: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .globe)
#else
        .init()
#endif
    }

    /// The "googlePlus" asset catalog image.
    static var googlePlus: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .googlePlus)
#else
        .init()
#endif
    }

    /// The "hd" asset catalog image.
    static var hd: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .hd)
#else
        .init()
#endif
    }

    /// The "heart" asset catalog image.
    static var heart: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .heart)
#else
        .init()
#endif
    }

    /// The "highlight" asset catalog image.
    static var highlight: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .highlight)
#else
        .init()
#endif
    }

    /// The "home" asset catalog image.
    static var home: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .home)
#else
        .init()
#endif
    }

    /// The "iconNoBg" asset catalog image.
    static var iconNoBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconNoBg)
#else
        .init()
#endif
    }

    /// The "mockPic" asset catalog image.
    static var mockPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mockPic)
#else
        .init()
#endif
    }

    /// The "notification" asset catalog image.
    static var notification: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .notification)
#else
        .init()
#endif
    }

    /// The "onboarding" asset catalog image.
    static var onboarding: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .onboarding)
#else
        .init()
#endif
    }

    /// The "padlock" asset catalog image.
    static var padlock: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .padlock)
#else
        .init()
#endif
    }

    /// The "pause" asset catalog image.
    static var pause: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pause)
#else
        .init()
#endif
    }

    /// The "person" asset catalog image.
    static var person: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .person)
#else
        .init()
#endif
    }

    /// The "play" asset catalog image.
    static var play: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .play)
#else
        .init()
#endif
    }

    /// The "playerBack" asset catalog image.
    static var playerBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .playerBack)
#else
        .init()
#endif
    }

    /// The "playerNext" asset catalog image.
    static var playerNext: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .playerNext)
#else
        .init()
#endif
    }

    /// The "playerPause" asset catalog image.
    static var playerPause: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .playerPause)
#else
        .init()
#endif
    }

    /// The "playerPlay" asset catalog image.
    static var playerPlay: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .playerPlay)
#else
        .init()
#endif
    }

    /// The "profileTab" asset catalog image.
    static var profileTab: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileTab)
#else
        .init()
#endif
    }

    /// The "puzzle" asset catalog image.
    static var puzzle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .puzzle)
#else
        .init()
#endif
    }

    /// The "questionIcon" asset catalog image.
    static var questionIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .questionIcon)
#else
        .init()
#endif
    }

    /// The "realeti" asset catalog image.
    static var realeti: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .realeti)
#else
        .init()
#endif
    }

    /// The "remove_i" asset catalog image.
    static var removeI: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .removeI)
#else
        .init()
#endif
    }

    /// The "ridebyhorse" asset catalog image.
    static var ridebyhorse: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ridebyhorse)
#else
        .init()
#endif
    }

    /// The "search" asset catalog image.
    static var search: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .search)
#else
        .init()
#endif
    }

    /// The "settings" asset catalog image.
    static var settings: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .settings)
#else
        .init()
#endif
    }

    /// The "settingsGear" asset catalog image.
    static var settingsGear: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .settingsGear)
#else
        .init()
#endif
    }

    /// The "share" asset catalog image.
    static var share: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .share)
#else
        .init()
#endif
    }

    /// The "shield" asset catalog image.
    static var shield: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shield)
#else
        .init()
#endif
    }

    /// The "star" asset catalog image.
    static var star: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .star)
#else
        .init()
#endif
    }

    /// The "trash-bin" asset catalog image.
    static var trashBin: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .trashBin)
#else
        .init()
#endif
    }

    /// The "voteOff" asset catalog image.
    static var voteOff: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .voteOff)
#else
        .init()
#endif
    }

    /// The "voteOn" asset catalog image.
    static var voteOn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .voteOn)
#else
        .init()
#endif
    }

    /// The "wishlist" asset catalog image.
    static var wishlist: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wishlist)
#else
        .init()
#endif
    }

    /// The "workspace_premium_black" asset catalog image.
    static var workspacePremiumBlack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .workspacePremiumBlack)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "AML1708" asset catalog image.
    static var AML_1708: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .AML_1708)
#else
        .init()
#endif
    }

    /// The "Back" asset catalog image.
    static var back: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .back)
#else
        .init()
#endif
    }

    /// The "DmitriyLubov" asset catalog image.
    static var dmitriyLubov: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dmitriyLubov)
#else
        .init()
#endif
    }

    /// The "NatalyaLuzyanina" asset catalog image.
    static var natalyaLuzyanina: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .natalyaLuzyanina)
#else
        .init()
#endif
    }

    /// The "ShapovalovIlya" asset catalog image.
    static var shapovalovIlya: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shapovalovIlya)
#else
        .init()
#endif
    }

    /// The "alert" asset catalog image.
    static var alert: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .alert)
#else
        .init()
#endif
    }

    /// The "arrow-back" asset catalog image.
    static var arrowBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .arrowBack)
#else
        .init()
#endif
    }

    /// The "arrow-ios-downward" asset catalog image.
    static var arrowIosDownward: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .arrowIosDownward)
#else
        .init()
#endif
    }

    /// The "audio" asset catalog image.
    static var audio: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .audio)
#else
        .init()
#endif
    }

    /// The "backButton" asset catalog image.
    static var backButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .backButton)
#else
        .init()
#endif
    }

    /// The "bgLogin" asset catalog image.
    static var bgLogin: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bgLogin)
#else
        .init()
#endif
    }

    /// The "bgOnboarding" asset catalog image.
    static var bgOnboarding: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bgOnboarding)
#else
        .init()
#endif
    }

    /// The "bg_nontransparent" asset catalog image.
    static var bgNontransparent: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bgNontransparent)
#else
        .init()
#endif
    }

    /// The "calendar" asset catalog image.
    static var calendar: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .calendar)
#else
        .init()
#endif
    }

    /// The "clock" asset catalog image.
    static var clock: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clock)
#else
        .init()
#endif
    }

    /// The "close_1" asset catalog image.
    static var close1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .close1)
#else
        .init()
#endif
    }

    /// The "closed_caption" asset catalog image.
    static var closedCaption: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .closedCaption)
#else
        .init()
#endif
    }

    /// The "devices" asset catalog image.
    static var devices: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .devices)
#else
        .init()
#endif
    }

    /// The "download" asset catalog image.
    static var download: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .download)
#else
        .init()
#endif
    }

    /// The "download_for_offline_black_24dp 1" asset catalog image.
    static var downloadForOfflineBlack24Dp1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .downloadForOfflineBlack24Dp1)
#else
        .init()
#endif
    }

    /// The "dr4gons1ayer01" asset catalog image.
    static var dr4Gons1Ayer01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dr4Gons1Ayer01)
#else
        .init()
#endif
    }

    /// The "edit" asset catalog image.
    static var edit: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .edit)
#else
        .init()
#endif
    }

    /// The "eye-off" asset catalog image.
    static var eyeOff: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .eyeOff)
#else
        .init()
#endif
    }

    /// The "favOff" asset catalog image.
    static var favOff: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .favOff)
#else
        .init()
#endif
    }

    /// The "favOn" asset catalog image.
    static var favOn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .favOn)
#else
        .init()
#endif
    }

    /// The "film" asset catalog image.
    static var film: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .film)
#else
        .init()
#endif
    }

    /// The "finish" asset catalog image.
    static var finish: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .finish)
#else
        .init()
#endif
    }

    /// The "fullscreen" asset catalog image.
    static var fullscreen: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fullscreen)
#else
        .init()
#endif
    }

    /// The "globe" asset catalog image.
    static var globe: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .globe)
#else
        .init()
#endif
    }

    /// The "googlePlus" asset catalog image.
    static var googlePlus: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .googlePlus)
#else
        .init()
#endif
    }

    /// The "hd" asset catalog image.
    static var hd: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .hd)
#else
        .init()
#endif
    }

    /// The "heart" asset catalog image.
    static var heart: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .heart)
#else
        .init()
#endif
    }

    /// The "highlight" asset catalog image.
    static var highlight: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .highlight)
#else
        .init()
#endif
    }

    /// The "home" asset catalog image.
    static var home: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .home)
#else
        .init()
#endif
    }

    /// The "iconNoBg" asset catalog image.
    static var iconNoBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconNoBg)
#else
        .init()
#endif
    }

    /// The "mockPic" asset catalog image.
    static var mockPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mockPic)
#else
        .init()
#endif
    }

    /// The "notification" asset catalog image.
    static var notification: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .notification)
#else
        .init()
#endif
    }

    /// The "onboarding" asset catalog image.
    static var onboarding: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .onboarding)
#else
        .init()
#endif
    }

    /// The "padlock" asset catalog image.
    static var padlock: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .padlock)
#else
        .init()
#endif
    }

    /// The "pause" asset catalog image.
    static var pause: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pause)
#else
        .init()
#endif
    }

    /// The "person" asset catalog image.
    static var person: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .person)
#else
        .init()
#endif
    }

    /// The "play" asset catalog image.
    static var play: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .play)
#else
        .init()
#endif
    }

    /// The "playerBack" asset catalog image.
    static var playerBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .playerBack)
#else
        .init()
#endif
    }

    /// The "playerNext" asset catalog image.
    static var playerNext: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .playerNext)
#else
        .init()
#endif
    }

    /// The "playerPause" asset catalog image.
    static var playerPause: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .playerPause)
#else
        .init()
#endif
    }

    /// The "playerPlay" asset catalog image.
    static var playerPlay: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .playerPlay)
#else
        .init()
#endif
    }

    /// The "profileTab" asset catalog image.
    static var profileTab: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileTab)
#else
        .init()
#endif
    }

    /// The "puzzle" asset catalog image.
    static var puzzle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .puzzle)
#else
        .init()
#endif
    }

    /// The "questionIcon" asset catalog image.
    static var questionIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .questionIcon)
#else
        .init()
#endif
    }

    /// The "realeti" asset catalog image.
    static var realeti: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .realeti)
#else
        .init()
#endif
    }

    /// The "remove_i" asset catalog image.
    static var removeI: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .removeI)
#else
        .init()
#endif
    }

    /// The "ridebyhorse" asset catalog image.
    static var ridebyhorse: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ridebyhorse)
#else
        .init()
#endif
    }

    /// The "search" asset catalog image.
    static var search: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .search)
#else
        .init()
#endif
    }

    /// The "settings" asset catalog image.
    static var settings: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .settings)
#else
        .init()
#endif
    }

    /// The "settingsGear" asset catalog image.
    static var settingsGear: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .settingsGear)
#else
        .init()
#endif
    }

    /// The "share" asset catalog image.
    static var share: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .share)
#else
        .init()
#endif
    }

    /// The "shield" asset catalog image.
    static var shield: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shield)
#else
        .init()
#endif
    }

    /// The "star" asset catalog image.
    static var star: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .star)
#else
        .init()
#endif
    }

    /// The "trash-bin" asset catalog image.
    static var trashBin: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .trashBin)
#else
        .init()
#endif
    }

    /// The "voteOff" asset catalog image.
    static var voteOff: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .voteOff)
#else
        .init()
#endif
    }

    /// The "voteOn" asset catalog image.
    static var voteOn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .voteOn)
#else
        .init()
#endif
    }

    /// The "wishlist" asset catalog image.
    static var wishlist: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .wishlist)
#else
        .init()
#endif
    }

    /// The "workspace_premium_black" asset catalog image.
    static var workspacePremiumBlack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .workspacePremiumBlack)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Hashable {

    /// An asset catalog color resource name.
    fileprivate let name: String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Hashable {

    /// An asset catalog image resource name.
    fileprivate let name: String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif
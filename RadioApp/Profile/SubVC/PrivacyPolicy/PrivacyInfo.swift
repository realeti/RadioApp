//
//  PrivacyInfo.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

struct PrivacyInfo {

    // MARK: - Private Properties
    private let aboutUs =
    """
    Welcome to RadioApp, your premier destination for enjoying music and radio. RadioApp is committed to protecting your privacy and keeping your personal information secure. This Privacy Policy describes how we collect, use, and protect your information. By using RadioApp, you agree to the terms set out in this policy.
    """.localized
    
    private let informationWeCollect =
    """
    Account Information: To enhance your experience, we collect registration information, including your name, email, and profile information.
    Usage Information: We collect data about your interactions with RadioApp, such as listening history and preferences.
    Device Information: We may collect information about your device, operating system, and unique identifiers.
    """.localized
    
    private let howWeUseYourInformation =
    """
    We use the collected data to provide, personalize and improve RadioApp services.
    The information is processed to complete transactions, provide customer support and analyze usage patterns to improve features.
    """.localized
    
    private let security =
    """
    Industry standard measures are used to protect your information from unauthorized access, alteration or disclosure.
    """.localized
    
    private let childrensPrivacy =
    """
    RadioApp is not intended for use by users under the age of 13, and we do not knowingly collect information from children.
    """.localized
    
    private let contactUs =
    """
    If you have any questions or concerns about this Privacy Policy, please contact us at [https://github.com/ridebyhorse]
    """.localized
    
    private let thankYou =
    """
    Thank you for choosing RadioApp. We are committed to providing you with an exceptional and safe radio listening experience.
    """.localized
    
    func getSectionsInfo() -> [PrivacyInfoModel] {
        let about = PrivacyInfoModel(title: "About Us".localized, description: aboutUs)
        let info =  PrivacyInfoModel(title: "Information we collect".localized, description: informationWeCollect)
        let howWeUse = PrivacyInfoModel(title: "How we use your information".localized, description: howWeUseYourInformation)
        let security = PrivacyInfoModel(title: "Security".localized, description: security)
        let childrensPrivacy = PrivacyInfoModel(title: "Children's privacy".localized, description: childrensPrivacy)
        let contactUs = PrivacyInfoModel(title: "Contact Us".localized, description: contactUs)
        let thankYou = PrivacyInfoModel(title: "Thank you".localized, description: thankYou)
        return [about, info, howWeUse, security, childrensPrivacy, contactUs, thankYou]
    }
}

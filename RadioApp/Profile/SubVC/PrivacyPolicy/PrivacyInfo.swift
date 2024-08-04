//
//  PrivacyInfo.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

struct PrivacyInfo {

//    // MARK: - Private Properties
//    private let aboutUs =
//    """
//    Добро пожаловать в RadioApp — ваше главное место для наслаждения музыкой и радиопередачами. RadioApp привержен защите вашей конфиденциальности и обеспечению безопасности ваших личных данных. Эта Политика конфиденциальности описывает, как мы собираем, используем и защищаем вашу информацию. Используя RadioApp, вы соглашаетесь с условиями, изложенными в этой политике.
//    """.localized
//    
//    private let informationWeCollect =
//    """
//    Информация об учетной записи: Для улучшения вашего опыта мы собираем регистрационные данные, включая ваше имя, электронную почту и профильную информацию.
//    Информация об использовании: Мы собираем данные о ваших взаимодействиях с RadioApp, таких как история прослушивания и предпочтения.
//    Информация об устройстве: Мы можем собирать информацию о вашем устройстве, операционной системе и уникальных идентификаторах.
//    """.localized
//    
//    private let howWeUseYourInformation =
//    """
//    Мы используем собранные данные для предоставления, персонализации и улучшения услуг RadioApp.
//    Информация обрабатывается для выполнения транзакций, поддержки клиентов и анализа шаблонов использования для улучшения функций.
//    """.localized
//    
//    private let security =
//    """
//    Применяются стандартные в отрасли меры для защиты вашей информации от несанкционированного доступа, изменения или раскрытия.
//    """.localized
//    
//    private let childrensPrivacy =
//    """
//    RadioApp не предназначен для пользователей младше 13 лет, и мы сознательно не собираем информацию от детей.
//    """.localized
//    
//    private let contactUs =
//    """
//    Если у вас есть вопросы или сомнения по поводу этой Политики конфиденциальности, пожалуйста, свяжитесь с нами по адресу  [https://github.com/ridebyhorse].
//    """.localized
//    
//    private let thankYou =
//    """
//    Благодарим вас за выбор RadioApp. Мы стремимся предоставить вам исключительный и безопасный опыт прослушивания радио.
//    """.localized
    
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
        let about = PrivacyInfoModel(title: "О нас".localized, description: aboutUs)
        let info =  PrivacyInfoModel(title: "Информация, которую мы собираем".localized, description: informationWeCollect)
        let howWeUse = PrivacyInfoModel(title: "Как мы используем вашу информацию".localized, description: howWeUseYourInformation)
        let security = PrivacyInfoModel(title: "Безопасность".localized, description: security)
        let childrensPrivacy = PrivacyInfoModel(title: "Конфиденциальность детей".localized, description: childrensPrivacy)
        let contactUs = PrivacyInfoModel(title: "Связаться с нами".localized, description: contactUs)
        let thankYou = PrivacyInfoModel(title: "Спасибо".localized, description: thankYou)
        return [about, info, howWeUse, security, childrensPrivacy, contactUs, thankYou]
    }
}

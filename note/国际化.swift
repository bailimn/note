private class func getLanguage() -> String {
    var language = "en"
    
    switch ZLCustomLanguageDeploy.language {
    case .system:
        language = Locale.preferredLanguages.first ?? "en"
        
        if language.hasPrefix("zh") {
            if language.range(of: "Hans") != nil {
                language = "zh-Hans"
            } else {
                language = "zh-Hant"
            }
        } else if language.hasPrefix("ja") {
            language = "ja-US"
        } else if language.hasPrefix("fr") {
            language = "fr"
        } else if language.hasPrefix("de") {
            language = "de"
        } else if language.hasPrefix("ru") {
            language = "ru"
        } else if language.hasPrefix("vi") {
            language = "vi"
        } else if language.hasPrefix("ko") {
            language = "ko"
        } else if language.hasPrefix("ms") {
            language = "ms"
        } else if language.hasPrefix("it") {
            language = "it"
        } else {
            language = "en"
        }
    case .chineseSimplified:
        language = "zh-Hans"
    case .chineseTraditional:
        language = "zh-Hant"
    case .english:
        language = "en"
    case .japanese:
        language = "ja-US"
    case .french:
        language = "fr"
    case .german:
        language = "de"
    case .russian:
        language = "ru"
    case .vietnamese:
        language = "vi"
    case .korean:
        language = "ko"
    case .malay:
        language = "ms"
    case .italian:
        language = "it"
    }
    
    return language
}

ZLPhotoConfiguration.single.languageType
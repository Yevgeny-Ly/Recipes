// Strings+Generated.swift
// Copyright © RoadMap. All rights reserved.

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum Local {
    enum AutorizationViewController {
        /// Enter Email Address
        static let loginPlaceholderTitle = Local.tr(
            "Localizable",
            "AutorizationViewController.loginPlaceholderTitle",
            fallback: "Enter Email Address"
        )
        /// Localizable.strings
        ///   MVP-UI
        static let loginTitle = Local.tr(
            "Localizable",
            "AutorizationViewController.loginTitle",
            fallback: "Email Address"
        )
        /// Enter Password
        static let passwordPlaceholderTitle = Local.tr(
            "Localizable",
            "AutorizationViewController.passwordPlaceholderTitle",
            fallback: "Enter Password"
        )
        /// Password
        static let passwordTitle = Local.tr(
            "Localizable",
            "AutorizationViewController.passwordTitle",
            fallback: "Password"
        )
        /// Login
        static let title = Local.tr("Localizable", "AutorizationViewController.title", fallback: "Login")
    }

    enum BonusViewController {
        /// 100
        static let titleBonusPayment = Local.tr("Localizable", "BonusViewController.titleBonusPayment", fallback: "100")
        /// Your bonuses
        static let titleYourBonuses = Local.tr(
            "Localizable",
            "BonusViewController.titleYourBonuses",
            fallback: "Your bonuses"
        )
    }

    enum OurPartnersViewController {
        /// You can get gifts and discounts from our partners
        static let giftsDiscountsTitle = Local.tr(
            "Localizable",
            "OurPartnersViewController.giftsDiscountsTitle ",
            fallback: "You can get gifts and discounts from our partners"
        )
    }

    enum RecipesDetailsViewController {
        /// isFavorite
        static let isFavorite = Local.tr(
            "Localizable",
            "RecipesDetailsViewController.isFavorite",
            fallback: "isFavorite"
        )
        /// arrowBackward
        static let titleArrowBackward = Local.tr(
            "Localizable",
            "RecipesDetailsViewController.titleArrowBackward",
            fallback: "arrowBackward"
        )
        /// noFavorite
        static let titleNoFavorites = Local.tr(
            "Localizable",
            "RecipesDetailsViewController.titleNoFavorites",
            fallback: "noFavorite"
        )
        /// shared
        static let titleShared = Local.tr("Localizable", "RecipesDetailsViewController.titleShared", fallback: "shared")
    }

    enum RecipesViewController {
        /// Recipes
        static let titleRecipesItem = Local.tr(
            "Localizable",
            "RecipesViewController.titleRecipesItem",
            fallback: "Recipes"
        )
    }

    enum TermsPrivatePolicyView {
        /// Terms of Use
        static let titleTermsOfUse = Local.tr(
            "Localizable",
            "TermsPrivatePolicyView.titleTermsOfUse",
            fallback: "Terms of Use"
        )
    }

    enum UserProfileViewController {
        /// Change your name and surname
        static let alertTitle = Local.tr(
            "Localizable",
            "UserProfileViewController.alertTitle",
            fallback: "Change your name and surname"
        )
        /// Cancel
        static let cancelAlertButton = Local.tr(
            "Localizable",
            "UserProfileViewController.cancelAlertButton",
            fallback: "Cancel"
        )
        /// Ok
        static let doneButton = Local.tr("Localizable", "UserProfileViewController.doneButton", fallback: "Ok")
        /// Name Surname
        static let placeholderAlert = Local.tr(
            "Localizable",
            "UserProfileViewController.placeholderAlert",
            fallback: "Name Surname"
        )
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Local {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type

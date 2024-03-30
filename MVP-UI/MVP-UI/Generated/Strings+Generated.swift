// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Local {
  internal enum AutorizationViewController {
    /// Enter Email Address
    internal static let loginPlaceholderTitle = Local.tr("Localizable", "AutorizationViewController.loginPlaceholderTitle", fallback: "Enter Email Address")
    /// Localizable.strings
    ///   MVP-UI
    internal static let loginTitle = Local.tr("Localizable", "AutorizationViewController.loginTitle", fallback: "Email Address")
    /// Enter Password
    internal static let passwordPlaceholderTitle = Local.tr("Localizable", "AutorizationViewController.passwordPlaceholderTitle", fallback: "Enter Password")
    /// Password
    internal static let passwordTitle = Local.tr("Localizable", "AutorizationViewController.passwordTitle", fallback: "Password")
    /// Login
    internal static let title = Local.tr("Localizable", "AutorizationViewController.title", fallback: "Login")
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

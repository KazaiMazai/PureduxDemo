// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Errors {
    internal enum Alert {
      /// Oops
      internal static let title = L10n.tr("Localizable", "Errors.Alert.title")
      internal enum Actions {
        /// Ok
        internal static let defaultOk = L10n.tr("Localizable", "Errors.Alert.Actions.defaultOk")
      }
    }
  }

  internal enum Login {
    /// Login
    internal static let title = L10n.tr("Localizable", "Login.Title")
    internal enum MainButton {
      /// Login
      internal static let title = L10n.tr("Localizable", "Login.MainButton.title")
    }
    internal enum Placeholder {
      /// Password
      internal static let password = L10n.tr("Localizable", "Login.Placeholder.password")
      /// Username
      internal static let username = L10n.tr("Localizable", "Login.Placeholder.username")
    }
  }

  internal enum MoviesFeed {
    internal enum NavBar {
      /// Discover Movies
      internal static let title = L10n.tr("Localizable", "MoviesFeed.NavBar.title")
      internal enum Buttons {
        /// Logout
        internal static let logout = L10n.tr("Localizable", "MoviesFeed.NavBar.Buttons.logout")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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

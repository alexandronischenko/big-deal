import Foundation

enum AppFlow {
    case authProfile(AppSubflow)
    case feed(FeedScreen)
    case search(SearchScreen)
}

enum AppSubflow {
    case profile(ProfileScreen)
    case authentication(AuthenticationScreen)
}

enum ProfileScreen {
    case main
    case settings
    case subscriptions
    case detail(Item)
}

enum AuthenticationScreen {
    case greeting
    case login
    case register
}

enum FeedScreen {
    case main
    case detail(Item)
}

enum SearchScreen {
    case main
    case filter
    case results
    case detail(Item)
}

enum DetailScreen {
    case main(Item)
}

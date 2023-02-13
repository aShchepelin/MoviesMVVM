// Constants.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

/// Идентификаторы
enum Identifier {
    static let moviesListCellIdentifier = "MoviesList"
    static let movieInfoCellIdentifier = "MovieInfo"
    static let mainStoryboardIdentifier = "Main"
}

/// Константы с для работы с Api
enum URLRequest {
    static let moviesCompilation = ["Топ Фильмов", "Популярные", "Скоро"]
    static let topRatedRequest = "top_rated"
    static let popularRequest = "popular"
    static let upcomingRequest = "upcoming"
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "api_key"
    static let languageKey = "language"
    static let languageValue = "ru-RU"

    static let baseImdbURL = "https://www.imdb.com/title/"
    static let imdbTrailerURL = "/?ref_=nv_sr_srsg_0"
    static let creditsURL = "/credits"
}

/// Константы кор даты сервиса
enum CoreDataConstants {
    static let movieInfoData = "MovieInfoData"
    static let movieData = "MovieData"
    static let genresData = "GenresData"
    static let productionCountriesData = "ProductionCountriesData"
    static let movieIDPredicate = "movieId = %i"
    static let movieDataPredicate = "movieType = %@"
    static let movieDataModel = "MovieDataModel"
}

/// Цвета из ассетов
enum Colors {
    static let greenColorName = "green"
    static let whiteColorName = "white"
    static let grayColorName = "gray"
    static let redColorName = "red"
}

/// Константы
enum Constants {
    static let errorTitle = "Ошибка"
    static let actionTitle = "Ok"
    static let keyChainKey = "api"
    static let alertTitleText = "Вход в приложение"
    static let alertMessageText = "Введите ключ"
    static let emptyString = ""
    static let launchScreen = "Launch Screen"
}

/// Константы Unit Test
enum UnitTest {
    static let foo = "foo"
    static let keyChainForKey = "key"
    static let mockMovieJSON = "MockMovie"
    static let jsonType = "json"
    static let mockMovieInfoJSON = "MockMovieInfo"
}

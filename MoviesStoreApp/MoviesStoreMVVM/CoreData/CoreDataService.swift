// CoreDataService.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import CoreData

/// Сервис по обрабокте данных в CoreData
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Public Properties

    var errorHandler: CoreDataHandler?

    // MARK: - Private Properties

    private lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    private let modelName: String
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                self.errorHandler?(error.localizedDescription)
            }
        }
        return container
    }()

    // MARK: - Init

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Public Methods

    func saveMovieDataContext(movies: [Movie], movieType: String) {
        guard let newMovie = NSEntityDescription.entity(forEntityName: CoreDataConstants.movieData, in: managedContext)
        else { return }
        for movie in movies {
            let movieContainer = MovieData(
                entity: newMovie,
                insertInto: managedContext
            )
            movieContainer.title = movie.title
            movieContainer.overview = movie.overview
            movieContainer.voteCount = Int64(movie.voteCount)
            movieContainer.voteAverage = movie.voteAverage
            movieContainer.movieId = Int64(movie.movieId)
            movieContainer.poster = movie.poster
            movieContainer.originalTitle = movie.originalTitle
            movieContainer.adult = movie.adult
            movieContainer.popularity = movie.popularity
            movieContainer.releaseDate = movie.releaseDate
            movieContainer.movieType = movieType
            movieContainer.id = UUID()
            do {
                try managedContext.save()
            } catch let error as NSError {
                errorHandler?(error.localizedDescription)
            }
        }
    }

    func saveMovieInfoDataContext(movieInfo: MovieInfo) {
        guard let newMovieInfo = NSEntityDescription.entity(
            forEntityName: CoreDataConstants.movieInfoData,
            in: managedContext
        )
        else { return }
        guard let genreDataEntity = NSEntityDescription.entity(
            forEntityName: CoreDataConstants.genresData,
            in: managedContext
        )
        else { return }
        guard let productionCountryDataEntity = NSEntityDescription.entity(
            forEntityName: CoreDataConstants.productionCountriesData,
            in: managedContext
        )
        else { return }
        let movieInfoContainer = MovieInfoData(
            entity: newMovieInfo,
            insertInto: managedContext
        )
        let genreData = GenresData(
            entity: genreDataEntity,
            insertInto: managedContext
        )
        let countryData = ProductionCountriesData(
            entity: productionCountryDataEntity,
            insertInto: managedContext
        )
        movieInfoContainer.poster = movieInfo.poster
        movieInfoContainer.releaseDate = movieInfo.releaseDate
        movieInfoContainer.popularity = movieInfo.popularity
        movieInfoContainer.adult = movieInfo.adult
        movieInfoContainer.originalTitle = movieInfo.originalTitle
        movieInfoContainer.movieId = Int64(movieInfo.movieId)
        movieInfoContainer.imdbId = movieInfo.imdbId
        movieInfoContainer.overview = movieInfo.overview
        movieInfoContainer.runtime = Int64(movieInfo.runtime)
        movieInfoContainer.title = movieInfo.title
        movieInfoContainer.voteAverage = movieInfo.voteAverage
        movieInfoContainer.voteCount = Int64(movieInfo.voteCount)
        for genre in movieInfo.genres {
            genreData.name = genre.name
            movieInfoContainer.addToGenres(genreData)
        }
        for country in movieInfo.productionCountries {
            countryData.name = country.name
            movieInfoContainer.addToProductionCountry(countryData)
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            errorHandler?(error.localizedDescription)
        }
    }

    func getMovieInfoData(movieID: Int) -> MovieInfo? {
        let predicate = NSPredicate(format: CoreDataConstants.movieIDPredicate, movieID)
        var movieInfo: MovieInfo
        var genres: [Genre] = []
        var countries: [ProductionCountry] = []
        let fetchRequest: NSFetchRequest<MovieInfoData> = MovieInfoData.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            guard let movieInfoObject = try? managedContext.fetch(fetchRequest).first else { return nil }
            guard let genresData = movieInfoObject.genres?.allObjects as? [GenresData] else { return nil }
            guard let countryData = movieInfoObject.productionCountry?.allObjects as? [ProductionCountriesData]
            else { return nil }
            for genreData in genresData {
                let genre = Genre(name: genreData.name ?? "")
                genres.append(genre)
            }
            for countryData in countryData {
                let country = ProductionCountry(name: countryData.name ?? "")
                countries.append(country)
            }
            movieInfo = MovieInfo(
                poster: movieInfoObject.poster ?? "",
                adult: movieInfoObject.adult,
                originalTitle: movieInfoObject.originalTitle ?? "",
                overview: movieInfoObject.overview ?? "",
                releaseDate: movieInfoObject.releaseDate ?? "",
                genres: genres,
                movieId: Int(movieInfoObject.movieId),
                title: movieInfoObject.title ?? "",
                popularity: movieInfoObject.popularity,
                voteCount: Int(movieInfoObject.voteCount),
                voteAverage: movieInfoObject.voteAverage,
                productionCountries: countries,
                runtime: Int(movieInfoObject.runtime),
                imdbId: movieInfoObject.imdbId ?? ""
            )
        } catch let error as NSError {
            errorHandler?(error.localizedDescription)
        }
        return movieInfo
    }

    func getMovieData(movieType: String) -> [Movie] {
        let predicate = NSPredicate(format: CoreDataConstants.movieDataPredicate, movieType)
        var movieObject: [MovieData] = []
        var movies: [Movie] = []
        let fetchRequest: NSFetchRequest<MovieData> = MovieData.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            movieObject = try managedContext.fetch(fetchRequest)
            for movie in movieObject {
                let item = Movie(
                    poster: movie.poster ?? "",
                    adult: movie.adult,
                    originalTitle: movie.originalTitle ?? "",
                    overview: movie.overview ?? "",
                    releaseDate: movie.releaseDate ?? "",
                    movieId: Int(movie.movieId),
                    title: movie.title ?? "",
                    popularity: movie.popularity,
                    voteCount: Int(movie.voteCount),
                    voteAverage: movie.voteAverage
                )
                movies.append(item)
            }
        } catch let error as NSError {
            errorHandler?(error.localizedDescription)
        }
        return movies
    }
}

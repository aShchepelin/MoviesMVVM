// MovieInfoTableViewCell.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import SafariServices
import UIKit

/// Делегат для вызова Safari
protocol ShowSafaryDelegate: AnyObject {
    func showMovieInfo()
}

/// Ячейка с информацией о фильме
final class MovieInfoTableViewCell: UITableViewCell {
    // MARK: - Private Enum

    private enum Constants {
        static let imdbLogoName = "IMDBLogo"
        static let hoursText = "ч"
        static let minutesText = "мин"
        static let separator = "-"
        static let oneMinuteInSeconds = 60
    }

    // MARK: - Private Visual Components

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10)
        return label
    }()

    private let yearAndGenresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(named: Colors.grayColorName)
        label.textAlignment = .center
        return label
    }()

    private let countryAndRuntimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(named: Colors.grayColorName)
        label.textAlignment = .center
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()

    private let imdbButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.imdbLogoName), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    // MARK: - Public Properties

    weak var delegate: ShowSafaryDelegate?
    weak var alertDelegate: AlertDelegateProtocol?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(_ model: MovieInfo, movieInfoViewModel: MovieInfoViewModelProtocol) {
        titleLabel.text = model.title
        fetchImage(
            url: model.poster,
            movieInfoViewModel: movieInfoViewModel
        )
        originalTitleLabel.text = "\(model.originalTitle)"
        overviewLabel.text = model.overview
        getGenres(model)
        getCountryAndRuntime(model)
    }

    // MARK: - Private Methods

    private func getCountryAndRuntime(_ model: MovieInfo) {
        var countries = ""
        for item in model.productionCountries {
            countries += " \(item.name)"
        }
        countryAndRuntimeLabel.text = "\(countries), \(Int(model.runtime) / Constants.oneMinuteInSeconds) " +
            "\(Constants.hoursText) \(Int(model.runtime) % Constants.oneMinuteInSeconds) \(Constants.minutesText)"
    }

    private func getGenres(_ model: MovieInfo) {
        var genres = ""
        for item in model.genres {
            genres += " \(item.name)"
        }
        let year = model.releaseDate.components(separatedBy: Constants.separator)
        yearAndGenresLabel.text = "\(year.first ?? "") \(genres)"
    }

    private func fetchImage(url: String, movieInfoViewModel: MovieInfoViewModelProtocol) {
        movieInfoViewModel.fetchImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.posterImageView.image = UIImage(data: data)
            case let .failure(error):
                self.alertDelegate?.showAlert(error: error)
            }
        }
    }

    @objc private func showImdbInfoAction() {
        delegate?.showMovieInfo()
    }

    private func setupUI() {
        setupVisualComponents()
        setupConstraints()
        imdbButton.addTarget(self, action: #selector(showImdbInfoAction), for: .touchUpInside)
    }

    private func setupVisualComponents() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(originalTitleLabel)
        contentView.addSubview(yearAndGenresLabel)
        contentView.addSubview(countryAndRuntimeLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(imdbButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            posterImageView.heightAnchor.constraint(equalToConstant: 400),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),

            originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            originalTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            originalTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            originalTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),

            yearAndGenresLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor),
            yearAndGenresLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            yearAndGenresLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            yearAndGenresLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),

            countryAndRuntimeLabel.topAnchor.constraint(equalTo: yearAndGenresLabel.bottomAnchor),
            countryAndRuntimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countryAndRuntimeLabel.widthAnchor.constraint(equalToConstant: 200),
            countryAndRuntimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),

            overviewLabel.topAnchor.constraint(equalTo: countryAndRuntimeLabel.bottomAnchor),
            overviewLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            overviewLabel.widthAnchor.constraint(equalToConstant: 350),
            overviewLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),

            imdbButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10),
            imdbButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imdbButton.widthAnchor.constraint(equalToConstant: 140),
            imdbButton.heightAnchor.constraint(equalToConstant: 60),
            imdbButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

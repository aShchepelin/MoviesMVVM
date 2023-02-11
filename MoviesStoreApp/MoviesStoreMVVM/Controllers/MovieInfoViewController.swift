// MovieInfoViewController.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import SafariServices
import UIKit

/// Экран с описанием фильма
final class MovieInfoViewController: UIViewController {
    // MARK: - Private Visual Components

    private let movieInfoTableView = UITableView()

    // MARK: - Public Properties

    var movieInfoViewModel: MovieInfoViewModelProtocol?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupTableView()
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self
        fetchMovieInfo()
        setupConstraints()
        updateView()
        showErrorAlert()
    }

    private func fetchMovieInfo() {
        movieInfoViewModel?.loadMovieInfo()
    }

    private func setupTableView() {
        view.addSubview(movieInfoTableView)
        movieInfoTableView.register(
            MovieInfoTableViewCell.self,
            forCellReuseIdentifier: Identifier.movieInfoCellIdentifier
        )
        movieInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoTableView.allowsSelection = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieInfoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            movieInfoTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            movieInfoTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            movieInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func updateView() {
        movieInfoViewModel?.updateView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movieInfoTableView.reloadData()
            }
        }
    }

    private func showErrorAlert() {
        movieInfoViewModel?.showErrorAlert = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(error: error)
            }
        }
    }
}

/// UITableViewDelegate, UITableViewDataSource

extension MovieInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Identifier.movieInfoCellIdentifier,
            for: indexPath
        ) as? MovieInfoTableViewCell,
            let model = movieInfoViewModel?.movieInfo,
            let movieInfoViewModel = movieInfoViewModel
        else {
            return UITableViewCell()
        }
        cell.configure(model, movieInfoViewModel: movieInfoViewModel)
        cell.delegate = self
        return cell
    }
}

/// ShowSafaryDelegate
extension MovieInfoViewController: ShowSafaryDelegate {
    func showMovieInfo() {
        guard let model = movieInfoViewModel?.movieInfo else { return }
        let imdbLink = "\(URLRequest.baseImdbURL)\(model.imdbId)\(URLRequest.imdbTrailerURL)"
        if let url = URL(string: imdbLink) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

/// AlertDelegateProtocol
extension MovieInfoViewController: AlertDelegateProtocol {
    func showAlert(error: Error) {
        showAlert(
            title: Constants.errorTitle,
            message: error.localizedDescription,
            actionTitle: Constants.actionTitle,
            handler: nil
        )
    }
}

// MoviesListViewController.swift
// Copyright © Aleksandr Shchepelin. All rights reserved.

import UIKit

/// Экран списка фильмов
final class MoviesListViewController: UIViewController {
    // MARK: - Private Visual Components

    private let moviesListTableView = UITableView()

    private let moviesCompilationSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: URLRequest.moviesCompilation)
        return segmentControl
    }()

    private let activityIndicatorView = UIActivityIndicatorView()

    // MARK: - Public Properties

    var moviesListViewModel: MoviesListViewModelProtocol?
    var onMovieInfoModule: IntHandler?
    var moviesListState: MoviesListStates = .initial {
        didSet {
            DispatchQueue.main.async {
                self.view.setNeedsLayout()
            }
        }
    }

    // MARK: - Lifeсycle

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        switch moviesListState {
        case .initial:
            initialStateView()
        case .success:
            successStateView()
        case let .failure(error):
            showAlert(error: error)
        }
    }

    // MARK: - Private methods

    private func keyChainAlert() {
        showKeyChainAlert(
            title: Constants.alertTitleText,
            message: Constants.alertMessageText,
            actionTitle: Constants.actionTitle
        ) { [weak self] apiKey in
            guard let self = self else { return }
            self.moviesListViewModel?.keyChainInfo()?.setValue(
                apiKey,
                forKey: Constants.keyChainKey
            )
            self.fetchMoviesList()
            self.moviesListTableView.reloadData()
        }
    }

    private func showCoreDataErrorAlert() {
        moviesListViewModel?.coreDataErrorHandler = { [weak self] error in
            DispatchQueue.main.async {
                self?.showCoreDataAlert(error: error)
            }
        }
    }

    private func initialStateView() {
        if moviesListViewModel?.keyChainInfo()?.getValue(Constants.keyChainKey) == Constants.emptyString {
            keyChainAlert()
        }
        setupUI()
        activityIndicatorView.startAnimating()
        moviesListTableView.isHidden = true
    }

    private func successStateView() {
        moviesListTableView.isHidden = false
        activityIndicatorView.isHidden = true
        moviesListTableView.reloadData()
    }

    private func activityIndicator() {
        activityIndicatorView.startAnimating()
    }

    private func setupMoviesListState() {
        moviesListViewModel?.moviesListState = { [weak self] state in
            self?.moviesListState = state
        }
    }

    @objc private func segmentControlAction(_ segmentedControl: UISegmentedControl) {
        moviesListViewModel?.fetchTypeMovies(index: segmentedControl.selectedSegmentIndex)
    }

    private func setupUI() {
        fetchMoviesList()
        setupMoviesListState()
        addSegmentControl()
        setupTableView()
        setupConstraints()
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        showCoreDataErrorAlert()
    }

    private func addSegmentControl() {
        view.addSubview(moviesCompilationSegmentControl)
        moviesCompilationSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        moviesCompilationSegmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        moviesCompilationSegmentControl.selectedSegmentIndex = 1
    }

    private func setupTableView() {
        view.addSubview(moviesListTableView)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        moviesListTableView.register(
            MoviesListTableViewCell.self,
            forCellReuseIdentifier: Identifier.moviesListCellIdentifier
        )
        moviesListTableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesListTableView.topAnchor.constraint(
                equalTo: moviesCompilationSegmentControl.bottomAnchor, constant: 10
            ),
            moviesListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            moviesListTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            moviesListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            moviesCompilationSegmentControl.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            moviesCompilationSegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            moviesCompilationSegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            moviesCompilationSegmentControl.heightAnchor.constraint(equalToConstant: 50),
            moviesCompilationSegmentControl.widthAnchor.constraint(equalToConstant: 250),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func fetchMoviesList() {
        moviesListViewModel?.fetchMoviesData()
    }
}

/// UITableViewDelegate, UITableViewDataSource

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        moviesListViewModel?.movies.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Identifier.moviesListCellIdentifier,
            for: indexPath
        ) as? MoviesListTableViewCell,
            let model = moviesListViewModel?.movies[indexPath.row],
            let moviesListViewModel = moviesListViewModel
        else { return UITableViewCell() }
        cell.configure(model, moviesListViewModel: moviesListViewModel)
        cell.alertDelegate = self
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = moviesListViewModel?.movies[indexPath.row].movieId else { return }
        onMovieInfoModule?(Int(movieID))
    }
}

/// AlertDelegateProtocol
extension MoviesListViewController: AlertDelegateProtocol {
    func showAlert(error: Error) {
        showAlert(
            title: Constants.errorTitle,
            message: error.localizedDescription,
            actionTitle: Constants.actionTitle,
            handler: nil
        )
    }

    func showCoreDataAlert(error: String) {
        showAlert(
            title: Constants.errorTitle,
            message: error,
            actionTitle: Constants.actionTitle,
            handler: nil
        )
    }
}

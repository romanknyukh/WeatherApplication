//
//  ViewController.swift
//  Weather
//
//  Created by Roman Kniukh on 19.02.21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    // MARK: - Variables
    
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    var currentLocation: CLLocation?
    var items: [WeeklyWeatherEntry] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var items2: [HourlyWeatherEntry] = []
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    private lazy var dateFormatterForTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter
    }()
    
    private lazy var dateFormatterForHourly: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter
    }()
    
    // MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .cyan
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let scrollContentView = UIView()
    
    private lazy var tableView: WeeklyWeatherTableView = {
        let table = WeeklyWeatherTableView()
        table.separatorStyle = .none
        table.backgroundColor = .cyan
        
        return table
    }()
        
    private lazy var currentWeatherView: CurrentWeatherView = {
       let view = CurrentWeatherView()
        view.backgroundColor = .cyan
        return view
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.backgroundColor = .cyan
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .equalCentering
        stack.spacing = 30
        return stack
    }()
    
    private lazy var humidityView = DetailedCurrentWeatherView()
    private lazy var feelLikeView = DetailedCurrentWeatherView()
    private lazy var visibilityView = DetailedCurrentWeatherView()
    private lazy var pressureView = DetailedCurrentWeatherView()
    private lazy var windSpeedView = DetailedCurrentWeatherView()
    private lazy var sunriseView = DetailedCurrentWeatherView()
    private lazy var sunsetView = DetailedCurrentWeatherView()
    
    private var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: self.collectionLayout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.register(HourlyWeatherCell.self,
                      forCellWithReuseIdentifier: HourlyWeatherCell.reuseIdentifier)

        return view
    }()
    
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
        self.view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.scrollContentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.scrollContentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.scrollContentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.scrollContentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
        
        scrollContentView.addSubview(currentWeatherView)
        
        currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            currentWeatherView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            currentWeatherView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            currentWeatherView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        ])
        
        networkWeatherManager.onCompletionCurrentWeather = { [weak self] currentWeather in
            guard let self = self else { return }
            
            self.configureCurrentWeatherView(weather: currentWeather)
        }
        
        scrollContentView.addSubview(self.collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.currentWeatherView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        scrollContentView.addSubview(self.tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
        
        // 1 - UI
        // 2 - Data from storage
        func save() {
            Swift.debugPrint(WeatherFileManager.shared.writeDataWithNSCodable(with: "userKey", model: self.items))
        }
        
        func read() {
            if let values = WeatherFileManager.shared.readDataWithCodable(with: "userKey") {
                self.items = values
            }
        }
        // 3 - Get request
        
        // TODO: - Roman - get data from storage and
        
        // Networking
        networkWeatherManager.onCompletionHourlyWeather = { [weak self] weather in
            DispatchQueue.main.async {
                self?.items2 = weather.hourlyWeatherEntry
                self?.collectionView.reloadData()
            }
        }

        networkWeatherManager.onCompletionWeeklyWeather = { [weak self] weather in
            DispatchQueue.main.async {
                save()
                self?.items = weather.weeklyWeatherEntry
                self?.tableView.reloadData()
            }
        }
        
        scrollContentView.addSubview(self.stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.scrollContentView.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.scrollContentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.scrollContentView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        self.stackView.addSubview(self.humidityView)
        
        self.humidityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            humidityView.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: 10),
            humidityView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            humidityView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            
        ])
        
        self.stackView.addSubview(self.feelLikeView)
        
        self.feelLikeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            feelLikeView.topAnchor.constraint(equalTo: self.humidityView.bottomAnchor, constant: 10),
            feelLikeView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            feelLikeView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),

        ])
        
        self.stackView.addSubview(self.visibilityView)
        
        self.visibilityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            visibilityView.topAnchor.constraint(equalTo: self.feelLikeView.bottomAnchor, constant: 10),
            visibilityView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            visibilityView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),

        ])
        
        self.stackView.addSubview(self.pressureView)
        
        self.pressureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pressureView.topAnchor.constraint(equalTo: self.visibilityView.bottomAnchor, constant: 10),
            pressureView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            pressureView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        ])
        
        self.stackView.addSubview(self.windSpeedView)
        
        self.windSpeedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            windSpeedView.topAnchor.constraint(equalTo: self.pressureView.bottomAnchor, constant: 10),
            windSpeedView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            windSpeedView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        ])
        
        self.stackView.addSubview(self.sunriseView)
        
        self.sunriseView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sunriseView.topAnchor.constraint(equalTo: self.windSpeedView.bottomAnchor, constant: 10),
            sunriseView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            sunriseView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        ])
        
        self.stackView.addSubview(self.sunsetView)
        
        self.sunsetView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sunsetView.topAnchor.constraint(equalTo: self.sunriseView.bottomAnchor, constant: 10),
            sunsetView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            sunsetView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        ])
    }
   
    // MARK: - Methods
    func configureCurrentWeatherView(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.currentWeatherView.set(location: weather.location,
                                        descriptionOfWeather: weather.description,
                                        currentTemperature: "\(Int(weather.temperature))°")
            
            self.humidityView.set(nameOfParametr: "Humidity",
                                  description: "\(weather.humidity)")
            self.feelLikeView.set(nameOfParametr: "Feels like", description: "\(Int(weather.feelLike))°")
            self.visibilityView.set(nameOfParametr: "Visibility", description: "\(weather.visibility)")
            self.pressureView.set(nameOfParametr: "Pressure", description: "\(weather.pressure)")
            self.windSpeedView.set(nameOfParametr: "Wind Speed", description: "\(weather.windSpeed)")
            self.sunriseView.set(nameOfParametr: "Sunrise", description: self.dateFormatterForTime.string(from: weather.sunrise))
            self.sunsetView.set(nameOfParametr: "Sunset", description: self.dateFormatterForTime.string(from: weather.sunset))
        }
    }
    
//    func save() {
//        Swift.debugPrint("Save data")
//
//        Swift.debugPrint(WeatherFileManager.shared.archiveWithNSCoding(with: "userKey", model: self.items))
//    }
//
//    func read() {
//        Swift.debugPrint("Read data")
//
//        let text = WeatherFileManager.shared.unarchiveWithNSCoding(with: "userKey")
//        Swift.debugPrint(text?.forEach {
//            print($0.date)
//        })
//    }
} 

// MARK: - UITableViewDataSource implementation
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyWeatherCell.identifier, for: indexPath)
        guard indexPath.row < items.count else { return cell }
        let item = items[indexPath.row]
        if let cell = cell as? WeeklyWeatherCell {
            let dayOfWeek = dateFormatter.string(from: item.date)
            cell.set(dayOfWeek: dayOfWeek, tempMin: String(Int(item.tempMin))+"°", tempMax: String(Int(item.tempMax))+"°", icon: item.systemIconNameString)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
        }
        return cell
    }
}

// MARK: - UITableViewDelegate implementation
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchWeeklyAndCurrentWeather(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HourlyWeatherCell.reuseIdentifier,
                for: indexPath) as? HourlyWeatherCell else { return UICollectionViewCell() }
        let item = items2[indexPath.row]
        let time = dateFormatterForHourly.string(from: item.date)
        cell.set(time: time, temperature: String(Int(item.temperature)), icon: item.systemIconNameString)
        
        return cell
    }
}


    
    





//
//  APIService.swift
//  DSDInfo
//
//  Created by Joe Chan on 10/12/2025.
//

import Foundation
import SwiftUI

class APIService {
    private var config: AppConfig

    init(config: AppConfig) {
        self.config = config
    }

    // Generic function to fetch data
    private func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        guard let url = URL(string: "\(urlString)/?device_uuid=\(deviceId)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let session: URLSession
        
        if config.enableMutualAuthentication {
            session = URLSession(configuration: .default, delegate: URLSessionClientCertificateHandling(appConfig: config), delegateQueue: nil)
            if config.debugMode {
                let _ = print("\(timestamp()) [Debug] \(#function) Mutual Authentication is enabled.")
            }
        } else {
            session = URLSession.shared
            if config.debugMode {
                let _ = print("\(timestamp()) [Debug] \(#function) Mutual Authentication is disabled.")
            }
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Decoding error: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // Fetch organization charts
    func fetchOrganizationCharts(completion: @escaping (Result<[OrganizationChart], Error>) -> Void) {
        let urlString = config.baseApiUrl + config.organizationChartApiPath
        fetchData(from: urlString) { [weak self] (result: Result<[OrganizationChart], Error>) in
            switch result {
            case .success(let organizationCharts):
                // Update webUrl and fileUrl for each chart
                let updatedCharts = self?.updateWebUrlsAndFileUrls(organizationCharts) ?? []
                completion(.success(updatedCharts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Fetch vehicle reservation reports
    func fetchVehicleReservationReports(completion: @escaping (Result<[VehicleReservationReport], Error>) -> Void) {
        let urlString = config.baseApiUrl + config.vehicleReservationReportsApiPath
        fetchData(from: urlString) { [weak self] (result: Result<[VehicleReservationReport], Error>) in
            switch result {
            case .success(let reports):
                // Update webUrl and fileUrl for each report
                let updatedReports = self?.updateWebUrlsAndFileUrls(reports) ?? []
                completion(.success(updatedReports))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Function to update web URLs and file URLs in the models
    private func updateWebUrlsAndFileUrls(_ charts: [OrganizationChart]) -> [OrganizationChart] {
        return charts.map { chart in
            var updatedChart = chart
            // Update webUrl if it matches the domain
            if let url = URL(string: updatedChart.webUrl),
               let host = url.host,
               host.hasSuffix(config.domainName) {
                updatedChart.webUrl = config.baseApiUrl + url.path
            }
            // Update fileUrl if it matches the domain
            if let fileUrl = URL(string: updatedChart.fileUrl),
               let host = fileUrl.host,
               host.hasSuffix(config.domainName) {
                updatedChart.fileUrl = config.baseApiUrl + fileUrl.path
            }
            return updatedChart
        }
    }

    private func updateWebUrlsAndFileUrls(_ reports: [VehicleReservationReport]) -> [VehicleReservationReport] {
        return reports.map { report in
            var updatedReport = report
            // Update webUrl if it matches the domain
            if let url = URL(string: updatedReport.webUrl),
               let host = url.host,
               host.hasSuffix(config.domainName) {
                updatedReport.webUrl = config.baseApiUrl + url.path
            }
            // Update fileUrl if it matches the domain
            if let fileUrl = URL(string: updatedReport.fileUrl),
               let host = fileUrl.host,
               host.hasSuffix(config.domainName) {
                updatedReport.fileUrl = config.baseApiUrl + fileUrl.path
            }
            return updatedReport
        }
    }
}

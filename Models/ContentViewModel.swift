//
//  ContentViewModel.swift
//  DSDInfo
//
//  Created by Joe Chan on 10/12/2025.
//

import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var organizationCharts: [OrganizationChart] = []
    @Published var vehicleReservationReports: [VehicleReservationReport] = []
    @Published var errorMessage: String?

    private var apiService: APIService

    public init(config: AppConfig) {
        self.apiService = APIService(config: config)
    }

    func fetchOrganizationCharts() {
        apiService.fetchOrganizationCharts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let charts):
                    self?.organizationCharts = charts
                case .failure(let error):
                    self?.errorMessage = "Error fetching organization charts: \(error.localizedDescription)"
                }
            }
        }
    }

    func fetchVehicleReservationReports() {
        apiService.fetchVehicleReservationReports { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let reports):
                    self?.vehicleReservationReports = reports
                case .failure(let error):
                    self?.errorMessage = "Error fetching vehicle reservation reports: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func resetOrganizationCharts() {
        organizationCharts.removeAll()
    }

    func resetVehicleReservationReports() {
        vehicleReservationReports.removeAll()
    }
}

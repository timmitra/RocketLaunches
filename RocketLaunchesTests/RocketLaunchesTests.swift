/// Copyright (c) 2022 Razeware LLC

import XCTest
@testable import RocketLaunches

class RocketLaunchesTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

//  func testGetAllCapsules() async throws {
//    let all = try await SpaceXAPI.getAllCapsules()
//    for item in all {
//      print("capsule is \(item)")
//    }
//  }
//
//  func testGetAllCores() async {
//    do {
//      let all = try await SpaceXAPI.getAllCores()
//      for item in all {
//        print("core is \(item.id)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllCrew() async {
//    do {
//      let all = try await SpaceXAPI.getAllCrew()
//      for item in all {
//        print("crew is \(item.name!)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllDragons() async throws {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    // Any test you write for XCTest can be annotated as throws and async.
//    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    do {
//      let allDragons = try await SpaceXAPI.getAllDragons()
//      for dragon in allDragons {
//        print("dragon is \(dragon.name)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }

  func testGetAllLaunches() async throws {
    do {
      let all = try await SpaceXAPI.getAllLaunches()
      for item in all {
        print("launch is \(item.name)")
      }
    } catch {
      print("error \(error)")
    }
  }

//  func testGetAllLaunchPads() async throws {
//    do {
//      let all = try await SpaceXAPI.getAllLaunchPads()
//      for item in all {
//        print("launchpad is \(item.name)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllPayload() async throws {
//    do {
//      let all = try await SpaceXAPI.getAllPayloads()
//      for item in all {
//        print("payload is \(item.name!)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllRocket() async throws {
//    do {
//      let all = try await SpaceXAPI.getAllRockets()
//      for item in all {
//        print("rocket is \(item.name)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllShips() async throws {
//    do {
//      let all = try await SpaceXAPI.getAllShips()
//      for item in all {
//        print("ship is \(item.name)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
}

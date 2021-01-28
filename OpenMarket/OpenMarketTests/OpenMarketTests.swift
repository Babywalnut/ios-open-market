//
//  OpenMarketTests.swift
//  OpenMarketTests
//
//  Created by 임리나 on 2021/01/25.
//

import XCTest
@testable import OpenMarket

class OpenMarketTests: XCTestCase {
    func testLoadFirstPageFromMockSuccessCase() {
        let productList = loadPageFromMock(1, success: true)
        dump(productList)
        XCTAssertNotNil(productList)
        XCTAssertEqual(productList?.page, 1)
        XCTAssertEqual(productList?.items.count, 20)
    }

    func testLoadFirstPageFromMockFailureCase() {
        let productList = loadPageFromMock(1, success: false)
        dump(productList)
        XCTAssertNil(productList)
    }
    
    func testLoadProductFromMockSuccessCase() {
        let product = loadProductFromMock(1, success: true)
        dump(product)
        XCTAssertNotNil(product)
        XCTAssertEqual(product?.id, 1)
    }

    func testLoadProductFromMockFailureCase() {
        let product = loadProductFromMock(1, success: false)
        dump(product)
        XCTAssertNil(product)
    }
    
    func testLoadFirstPage() {
        let productList = loadPage(1)
        dump(productList)
        XCTAssertNotNil(productList)
        XCTAssertEqual(productList?.page, 1)
        XCTAssertEqual(productList?.items.count, 20)
    }
    
    func testLoadSecondPage() {
        let productList = loadPage(2)
        XCTAssertNotNil(productList)
        XCTAssertEqual(productList?.page, 2)
        XCTAssertEqual(productList?.items.count, 20)
    }
    
    func testLoadThridPage() {
        let productList = loadPage(3)
        XCTAssertNotNil(productList)
        XCTAssertEqual(productList?.page, 3)
        print(productList?.items.count ?? 0)
    }
    
    func testLoadFourthPage() {
        let productList = loadPage(4)
        XCTAssertNotNil(productList)
        XCTAssertEqual(productList?.page, 4)
        print(productList?.items.count ?? 0)
    }
    
    func testLoadItem1() {
        let item = loadItem(32)
        dump(item)
        XCTAssertNotNil(item)
        XCTAssertEqual(item?.id, 32)
    }
    
    func testLoadItem2() {
        let item = loadItem(42)
        dump(item)
        XCTAssertNotNil(item)
        XCTAssertEqual(item?.id, 42)
    }
    
    func testPatchItem1() {
        patchItem(148)
    }
    
    func testPatchItem2() {
        patchItem(141)
    }
    
    func testPostItem1() {
        postItem()
    }
    
    func testPostItem2() {
        postItem()
    }
    
    func testPatchItem() {
        patchItem(158)
    }
}

extension OpenMarketTests {
    func loadPageFromMock(_ number: Int, success: Bool) -> ProductList? {
        let expectation = XCTestExpectation(description: "pageLoad")
        var productList: ProductList?
        let networkHandler = NetworkHandler(session: MockURLSession(makeRequestSuccess: success))
        
        OpenMarketJSONDecoder<ProductList>.decodeData(about: .page, specificNumer: number, networkHandler: networkHandler) { result in
            switch result {
            case .success(let data):
                productList = data
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        return productList
    }
    
    func loadProductFromMock(_ number: Int, success: Bool) -> Product? {
        let expectation = XCTestExpectation(description: "pageLoad")
        var Product: Product?
        let networkHandler = NetworkHandler(session: MockURLSession(makeRequestSuccess: success, apiType: .product))
        
        OpenMarketJSONDecoder<Product>.decodeData(about: .product, specificNumer: number, networkHandler: networkHandler) { result in
            switch result {
            case .success(let data):
                Product = data
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        return Product
    }
    
    func loadPage(_ number: Int) -> ProductList? {
        let expectation = XCTestExpectation(description: "pageLoad")
        var productList: ProductList?
        
        OpenMarketJSONDecoder<ProductList>.decodeData(about: .page, specificNumer: number) { result in
            switch result {
            case .success(let data):
                productList = data
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        return productList
    }
    
    func loadItem(_ id: Int) -> Product? {
        let expectation = XCTestExpectation(description: "itemLoad")
        var product: Product?
        
        OpenMarketJSONDecoder<Product>.decodeData(about: .product, specificNumer: id) { result in
            switch result {
            case .success(let data):
                product = data
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        return product
    }
    
    func patchItem(_ id: Int) {
        let expectation = XCTestExpectation(description: "itemPatch")
        
        let product = Product(forPostPassword: "12345", title: "변해라 얍! 타이틀 수정해보기", descriptions: "password 1234567890", price: 20000, currency: "KRW", stock: 1, discountedPrice: nil, images: [""])
        
        Uploader.uploadData(by: .patch, product: product, specificNumer: id) { result in
            switch result {
            case .success(let data):
                dump(data)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func postItem() {
        let expectation = XCTestExpectation(description: "itemPatch")
        
        let product = Product(forPostPassword: "12345", title: "업로드1", descriptions: "password 12345", price: 20000, currency: "KRW", stock: 1, discountedPrice: nil, images: [""])
        
        Uploader.uploadData(by: .post, product: product) { result in
            switch result {
            case .success(let data):
                dump(data)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

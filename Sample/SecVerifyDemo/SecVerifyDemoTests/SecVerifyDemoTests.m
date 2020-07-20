//
//  SecVerifyDemoTests.m
//  SecVerifyDemoTests
//
//  Created by yoozoo on 2019/9/2.
//  Copyright © 2019 yoozoo. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <SecVerify/SecVerify.h>

#import <MOBFoundation/MOBFoundation.h>

@interface SecVerifyDemoTests : XCTestCase

@end

@implementation SecVerifyDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testProLogin
{
    
    __block XCTestExpectation *exp = [self expectationWithDescription:@"testProLogin"];
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        
        sleep(5);
        [SecVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
            XCTAssertNil(error, @"预区号成功");
           
            [exp fulfill];
            exp = nil;
        }];
    });
    
    [self waitForExpectationsWithTimeout:50 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testLogin_NilModel
{
    __block XCTestExpectation *exp = [self expectationWithDescription:@"testLogin_Model"];
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        
        sleep(5);
        [SecVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
            XCTAssertNil(error, @"预区号成功");
            
            [SecVerify loginWithModel:nil completion:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
                XCTAssertNotNil(error, @"登录失败");
                
                [exp fulfill];
                exp = nil;
            }];
            
        }];
    });
    
    [self waitForExpectationsWithTimeout:50 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)testLogin_Model
{
    __block XCTestExpectation *exp = [self expectationWithDescription:@"testLogin_Model"];
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        sleep(5);
        [SecVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
            XCTAssertNil(error, @"预区号成功");
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                SecVerifyCustomModel *model = [[SecVerifyCustomModel alloc] init];
                model.currentViewController = [MOBFViewController currentViewController];
                [SecVerify loginWithModel:model completion:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
                    XCTAssertNil(error, @"登录成功");
                    NSLog(@"登录成功1：%@",resultDic);
                    
                    
                    [exp fulfill];
                    exp = nil;
                }];
            });
            
            
        }];
    });
    
    [self waitForExpectationsWithTimeout:50 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];

}

- (void)testPreLogin
{
//    sleep(2);
    
    __block XCTestExpectation *exp = [self expectationWithDescription:@"testProLogin"];
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    
    for (int i = 0; i < 1; i++)
    {
        dispatch_async(queue, ^{
            
            [SecVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
                //            XCTAssertNotNil(error,@"预取号不会成功的");
                //            NSLog(@"预取号失败：%@",error);
                NSLog(@"预取号成功：%@",resultDic);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    SecVerifyCustomModel *model = [[SecVerifyCustomModel alloc] init];
                    model.currentViewController = [MOBFViewController currentViewController];
                    [SecVerify loginWithModel:model completion:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
                        NSLog(@"登录成功1：%@",resultDic);
                        
                        [SecVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
                            
                            [SecVerify loginWithModel:model completion:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
                                NSLog(@"登录成功2：%@",resultDic);
                                
                                [exp fulfill];
                                exp = nil;
                            }];
                            
                        }];
                    }];
                    
                });

               
                
            }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100 handler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}


@end

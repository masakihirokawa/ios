//
//  DCURLSession.h
//
//  Created by Dolice on 2016/07/26.
//  Copyright © 2016 Dolice. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TIME_OUT_REQUEST  10.0
#define TIME_OUT_RESOURCE 20.0

@interface DCURLSession : NSURLSession <NSURLSessionDataDelegate>

#pragma mark - property
@property (nonatomic, retain) NSURLSession  *session;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSString      *responseStr;
@property (nonatomic, retain) NSString      *alternateStr;

#pragma mark - public method
- (void)start:(NSString *)url httpMethod:(NSString *)httpMethod alternateStr:(NSString *)alternateStr;

@end

//
//  DCAsyncImageView.h
//
//  Created by Dolice on 2014/05/27.
//  Copyright (c) 2014 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DC_AIV_TIME_OUT_REQUEST  10.0
#define DC_AIV_TIME_OUT_RESOURCE 20.0
#define DC_AIV_AI_SMALL_RECT     CGRectMake(0, 0, 20.0, 20.0)
#define DC_AIV_AI_LARGE_RECT     CGRectMake(0, 0, 50.0, 50.0)

@interface DCAsyncImageView : UIImageView <NSURLSessionDataDelegate>

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, indicatorType) {
    DC_AIV_AI_GRAY        = 1,
    DC_AIV_AI_WHITE_SMALL = 2,
    DC_AIV_AI_WHITE_LARGE = 3
};

#pragma mark - property
@property (nonatomic, retain) NSURLSession            *session;
@property (nonatomic, retain) NSMutableData           *responseData;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

#pragma mark - public method
- (void)loadImage:(NSString *)url backgroundColor:(UIColor *)backgroundColor showIndicator:(BOOL)showIndicator indicatorType:(NSUInteger)indicatorType delegate:(id)delegate;
- (void)abort;

@end

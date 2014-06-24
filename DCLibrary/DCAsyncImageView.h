//
//  DCAsyncImageView.h
//
//  Created by Dolice on 2014/05/27.
//  Copyright (c) 2014 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCAsyncImageView : UIImageView {
    @private  NSURLConnection *conn;
    NSMutableData             *data;
}

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, indicatorType) {
    AI_GRAY        = 1,
    AI_WHITE_SMALL = 2,
    AI_WHITE_LARGE = 3
};

#pragma mark - property
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

#pragma mark - public method
- (void)loadImage:(NSString *)url backgroundColor:(UIColor *)backgroundColor showIndicator:(BOOL)showIndicator indicatorType:(NSUInteger)indicatorType;
- (void)abort;

@end

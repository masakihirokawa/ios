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

#pragma mark - property
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

#pragma mark - public method
- (void)loadImage:(NSString *)url backgroundColor:(UIColor *)backgroundColor showIndicator:(BOOL)showIndicator indicatorType:(NSUInteger)indicatorType;
- (void)abort;

@end

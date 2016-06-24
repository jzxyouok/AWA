//
//  BTGlassScrollView.h
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 14-11-10.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageEffects.h"

#define DEFAULT_BLUR_RADIUS 14
#define DEFAULT_BLUR_TINT_COLOR [UIColor colorWithWhite:0 alpha:.3]
#define DEFAULT_BLUR_DELTA_FACTOR 1.4

#define DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL 30
#define DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL 150


#define DEFAULT_TOP_FADING_HEIGHT_HALF 10

@protocol BTGlassScrollViewDelegate;

@interface BTGlassScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *blurredBackgroundImage;
@property (nonatomic, strong, readonly) UIScrollView *foregroundScrollView;
@property (nonatomic, weak) id<BTGlassScrollViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
    backgroundImage:(UIImage *)backgroundImage
foregroundScrollView:(UIScrollView *)foregroundView;

- (void)scrollHorizontalRatio:(CGFloat)ratio;

- (void)setBackgroundImage:(UIImage *)backgroundImage
             overWriteBlur:(BOOL)overWriteBlur
                  animated:(BOOL)animated
                  duration:(NSTimeInterval)interval;

- (void)blurBackground:(BOOL)shouldBlur;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end


@protocol BTGlassScrollViewDelegate <NSObject>

@optional
- (void)glassScrollView:(BTGlassScrollView *)glassScrollView didChangedToFrame:(CGRect)frame;

- (UIImage*)glassScrollView:(BTGlassScrollView *)glassScrollView blurForImage:(UIImage *)image;


@end

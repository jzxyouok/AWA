//
//  BTGlassScrollView.m
//  AWA
//
//  Created by Suteki(67111677@qq.com) on 14-11-10.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "BTGlassScrollView.h"

@implementation BTGlassScrollView {
    UIScrollView *_backgroundScrollView;
    UIView *_constraitView;
    UIImageView *_backgroundImageView;
    UIImageView *_blurredBackgroundImageView;
    
    UIView *_foregroundContainerView;
}

- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage foregroundScrollView:(UIScrollView *)foregroundScrollView
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundImage = backgroundImage;
        
        if ([_delegate respondsToSelector:@selector(glassScrollView:blurForImage:)]) {
            _blurredBackgroundImage = [_delegate glassScrollView:self blurForImage:_backgroundImage];
        } else {
            _blurredBackgroundImage = [backgroundImage applyBlurWithRadius:DEFAULT_BLUR_RADIUS tintColor:DEFAULT_BLUR_TINT_COLOR saturationDeltaFactor:DEFAULT_BLUR_DELTA_FACTOR maskImage:nil];
        }
        
        _foregroundScrollView = foregroundScrollView;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self createBackgroundView];
        [self configForegroundView];
    }
    return self;
}

#pragma mark - Public Functions

- (void)scrollHorizontalRatio:(CGFloat)ratio {
    [_backgroundScrollView setContentOffset:CGPointMake(DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL + ratio * DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, _backgroundScrollView.contentOffset.y)];
}

#pragma mark - Setters

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGRect bounds = CGRectOffset(frame, -frame.origin.x, -frame.origin.y);
    
    [_backgroundScrollView setFrame:bounds];
    [_backgroundScrollView setContentSize:CGSizeMake(bounds.size.width + 2*DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.bounds.size.height + DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL)];
    [_backgroundScrollView setContentOffset:CGPointMake(DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, 0)];
    
    [_constraitView setFrame:CGRectMake(0, 0, bounds.size.width + 2*DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, bounds.size.height + DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL)];
    
    [_foregroundContainerView setFrame:bounds];
    [_foregroundScrollView setFrame:bounds];
    
    if (_delegate && [_delegate respondsToSelector:@selector(glassScrollView:didChangedToFrame:)]) {
        [_delegate glassScrollView:self didChangedToFrame:frame];
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
             overWriteBlur:(BOOL)overWriteBlur
                  animated:(BOOL)animated
                  duration:(NSTimeInterval)interval {
    _backgroundImage = backgroundImage;
    if (overWriteBlur) {
        _blurredBackgroundImage = [backgroundImage applyBlurWithRadius:DEFAULT_BLUR_RADIUS tintColor:DEFAULT_BLUR_TINT_COLOR saturationDeltaFactor:DEFAULT_BLUR_DELTA_FACTOR maskImage:nil];
    }
    
    if (animated) {
        UIImageView *previousBackgroundImageView = _backgroundImageView;
        UIImageView *previousBlurredBackgroundImageView = _blurredBackgroundImageView;
        [self createBackgroundImageView];
        
        [_backgroundImageView setAlpha:0];
        [_blurredBackgroundImageView setAlpha:0];
        
        if (previousBlurredBackgroundImageView.alpha == 1) {
            [UIView animateWithDuration:interval animations:^{
                [_blurredBackgroundImageView setAlpha:previousBlurredBackgroundImageView.alpha];
            } completion:^(BOOL finished) {
                [_backgroundImageView setAlpha:previousBackgroundImageView.alpha];
                [previousBackgroundImageView removeFromSuperview];
                [previousBlurredBackgroundImageView removeFromSuperview];
            }];
        } else {
            [UIView animateWithDuration:interval animations:^{
                [_backgroundImageView setAlpha:previousBackgroundImageView.alpha];
                [_blurredBackgroundImageView setAlpha:previousBlurredBackgroundImageView.alpha];
            } completion:^(BOOL finished) {
                [previousBackgroundImageView removeFromSuperview];
                [previousBlurredBackgroundImageView removeFromSuperview];
            }];
        }
    } else {
        [_backgroundImageView setImage:_backgroundImage];
        [_blurredBackgroundImageView setImage:_blurredBackgroundImage];
    }
}


- (void)blurBackground:(BOOL)shouldBlur
{
    [_blurredBackgroundImageView setAlpha:shouldBlur?1:0];
}

#pragma mark - ScrollViews

- (void)createBackgroundView {
    _backgroundScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _backgroundScrollView.scrollsToTop = NO;
    [_backgroundScrollView setUserInteractionEnabled:NO];
    [_backgroundScrollView setContentSize:CGSizeMake(self.frame.size.width + 2*DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.frame.size.height + DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL)];
    [_backgroundScrollView setContentOffset:CGPointMake(DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, 0)];
    [self addSubview:_backgroundScrollView];
    
    _constraitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width + 2*DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.frame.size.height + DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL)];
    [_backgroundScrollView addSubview:_constraitView];
    
    [self createBackgroundImageView];
}

- (void)createBackgroundImageView {
    _backgroundImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backgroundImageView.left = DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL;
    _backgroundImageView.image = _backgroundImage;
    [_backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_constraitView addSubview:_backgroundImageView];
    
    _blurredBackgroundImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _blurredBackgroundImageView.left = DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL;
    _blurredBackgroundImageView.image = _blurredBackgroundImage;
    
    [_blurredBackgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_blurredBackgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_blurredBackgroundImageView setAlpha:0];
    [_constraitView addSubview:_blurredBackgroundImageView];
}


- (void)configForegroundView {
    _foregroundContainerView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_foregroundContainerView];
    
    [_foregroundScrollView setShowsVerticalScrollIndicator:NO];
    [_foregroundScrollView setShowsHorizontalScrollIndicator:NO];
    [_foregroundContainerView addSubview:_foregroundScrollView];
}

#pragma mark - Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat ratio = (scrollView.contentOffset.y + _foregroundScrollView.contentInset.top)/(_foregroundScrollView.frame.size.height - _foregroundScrollView.contentInset.top);
    ratio = ratio < 0 ? 0 : ratio;
    ratio = ratio > 1 ? 1 : ratio;
    
    [_backgroundScrollView setContentOffset:CGPointMake(DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, ratio * DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL)];
    
    [_blurredBackgroundImageView setAlpha:ratio];
}

@end

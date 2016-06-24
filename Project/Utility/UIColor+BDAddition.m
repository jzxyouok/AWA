//
//  UIColor+BDAddition.m
//  BDKit
//
//  Created by Suteki(67111677@qq.com) on 14-2-19.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "UIColor+BDAddition.h"

@implementation UIColor (BDAddition)

+ (UIColor *)colorWithHexValue:(NSUInteger)hex {
	NSUInteger a = ((hex >> 24) & 0x000000FF);
	float fa = ((0 == a) ? 1.0f : (a * 1.0f) / 255.0f);
    
	return [UIColor colorWithHexValue:hex alpha:fa];
}

+ (UIColor *)colorWithHexValue:(NSUInteger)hex alpha:(CGFloat)alpha {
	NSUInteger r = ((hex >> 16) & 0x000000FF);
	NSUInteger g = ((hex >> 8) & 0x000000FF);
	NSUInteger b = ((hex >> 0) & 0x000000FF);
	
	float fr = (r * 1.0f) / 255.0f;
	float fg = (g * 1.0f) / 255.0f;
	float fb = (b * 1.0f) / 255.0f;
	
	return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)colorWithShortHexValue:(NSUInteger)hex {
	return [UIColor colorWithShortHexValue:hex alpha:1.0f];
}

+ (UIColor *)colorWithShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha {
	NSUInteger r = ((hex >> 8) & 0x0000000F);
	NSUInteger g = ((hex >> 4) & 0x0000000F);
	NSUInteger b = ((hex >> 0) & 0x0000000F);
	
	float fr = (r * 1.0f) / 15.0f;
	float fg = (g * 1.0f) / 15.0f;
	float fb = (b * 1.0f) / 15.0f;
	
	return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)colorWithString:(NSString *)string {
	if (nil == string || 0 == string.length) {
		return [UIColor clearColor];
    }
    
	NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSString *colorStr = [array objectAtIndex:0];
    CGFloat alpha = 1.0f;
    
	if (array.count == 2) {
        alpha = [[array objectAtIndex:1] floatValue];
    }
    
    UIColor *ret = nil;
    if ([colorStr hasPrefix:@"#"]) // #FFF
    {
		colorStr = [colorStr substringFromIndex:1];
        
		if (colorStr.length == 3) {
			NSUInteger hexRGB = strtol(colorStr.UTF8String , nil, 16);
			ret = [UIColor colorWithShortHexValue:hexRGB alpha:alpha];
		}else if (colorStr.length == 6) {
			NSUInteger hexRGB = strtol(colorStr.UTF8String , nil, 16);
			ret = [UIColor colorWithHexValue:hexRGB];
		}
    }
    else if ([colorStr hasPrefix:@"0x"] || [colorStr hasPrefix:@"0X"]) // #FFF
    {
		colorStr = [colorStr substringFromIndex:2];
		
		if (colorStr.length == 8) {
			NSUInteger hexRGB = strtol(colorStr.UTF8String , nil, 16);
			ret = [UIColor colorWithHexValue:hexRGB];
		}else if (colorStr.length == 6) {
			NSUInteger hexRGB = strtol(colorStr.UTF8String , nil, 16);
			ret = [UIColor colorWithHexValue:hexRGB alpha:1.0f];
		}
	}
    else if (colorStr.length == 3) {
        NSUInteger hexRGB = strtol(colorStr.UTF8String , nil, 16);
        ret = [UIColor colorWithShortHexValue:hexRGB alpha:alpha];
    }else if (colorStr.length == 6) {
        NSUInteger hexRGB = strtol(colorStr.UTF8String , nil, 16);
        ret = [UIColor colorWithHexValue:hexRGB];
    }
    else
    {
        static NSMutableDictionary * __colors = nil;
        
        if (nil == __colors)
        {
            __colors = [[NSMutableDictionary alloc] init];
            [__colors setObject:[UIColor clearColor] forKey:@"clear"];
            [__colors setObject:[UIColor clearColor] forKey:@"transparent"];
            [__colors setObject:[UIColor redColor] forKey:@"red"];
            [__colors setObject:[UIColor blackColor] forKey:@"black"];
            [__colors setObject:[UIColor darkGrayColor] forKey:@"darkGray"];
            [__colors setObject:[UIColor lightGrayColor] forKey:@"lightGray"];
            [__colors setObject:[UIColor whiteColor] forKey:@"white"];
            [__colors setObject:[UIColor grayColor] forKey:@"gray"];
            [__colors setObject:[UIColor redColor] forKey:@"red"];
            [__colors setObject:[UIColor greenColor] forKey:@"green"];
            [__colors setObject:[UIColor blueColor] forKey:@"blue"];
            [__colors setObject:[UIColor cyanColor] forKey:@"cyan"];
            [__colors setObject:[UIColor yellowColor] forKey:@"yellow"];
            [__colors setObject:[UIColor magentaColor] forKey:@"magenta"];
            [__colors setObject:[UIColor orangeColor] forKey:@"orange"];
            [__colors setObject:[UIColor purpleColor] forKey:@"purple"];
            [__colors setObject:[UIColor brownColor] forKey:@"brown"];
        }
        ret = [__colors objectForKey:colorStr.lowercaseString];
    }
    return ret ? ret : [UIColor clearColor];
}

@end

//
//  SNHPageScrollViewModel.m
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "SNHPageScrollViewModel.h"

@implementation SNHPageScrollViewModel

+ (instancetype)pageScrollViewModelWithTitle:(NSString *)title className:(NSString *)className {
    SNHPageScrollViewModel * model = [[SNHPageScrollViewModel alloc] init];
    model.title = title;
    model.viewControllerClassName = className;
    model.didSelect = NO;
    return model;
}

@end

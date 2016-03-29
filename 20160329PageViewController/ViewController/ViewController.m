//
//  ViewController.m
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

static NSString * kTitle = @"title";
static NSString * kClassName = @"className";

@interface ViewController ()

@property (nonatomic,strong) NSMutableArray * dataSourceArrayM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;

    _dataSourceArrayM = [NSMutableArray new];
    [_dataSourceArrayM addObject:@{kTitle : @"视频",
                                   kClassName : [FirstViewController class]}];
    [_dataSourceArrayM addObject:@{kTitle : @"娱乐",
                                   kClassName : [SecondViewController class]}];
    [_dataSourceArrayM addObject:@{kTitle : @"夜谈",
                                   kClassName : [ThirdViewController class]}];
    [_dataSourceArrayM addObject:@{kTitle : @"游戏",
                                   kClassName : [FourthViewController class]}];
}

/*!
 *  数量
 */
- (NSInteger)numberOfItemForPageViewController:(SNHScrollPageViewController *)viewController {
    return self.dataSourceArrayM.count;
}
/*!
 *  标题
 */
- (NSString *)pageViewController:(SNHScrollPageViewController *)viewController titleAtIndex:(NSUInteger)index {
    return self.dataSourceArrayM[index][kTitle];
}
/*!
 *  对应的类
 */
- (Class)pageViewController:(SNHScrollPageViewController *)viewController
               classAtIndex:(NSUInteger)index {
    return self.dataSourceArrayM[index][kClassName];
}
/*!
 *  实例化
 */
- (UIViewController *)pageViewController:(SNHScrollPageViewController *)viewController instanceForClass:(NSString *)className atIndex:(NSUInteger)index {
    UIViewController * resultViewController = nil;
    switch (index) {
        case 0:
            resultViewController = [[FirstViewController alloc] init];
            break;
            case 1:
            resultViewController = [SecondViewController secondViewController];
            break;
            case 2:
            resultViewController = [[ThirdViewController alloc] init];
            break;
            case 3:
            resultViewController = [[FourthViewController alloc] init];
            break;
        default:
            break;
    }
    
    return resultViewController;
}

@end











/*SNHPageScrollViewModel.h

@abstract <#abstract#>

@author Created by majian on 16/3/29.

@version <#version#> 16/3/29 Creation

Copyright © 2016年 majian. All rights reserved.

*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!

@class SNHPageScrollViewModel

@abstract 存放滑动页的一些属性

*/
@interface SNHPageScrollViewModel : NSObject

+ (instancetype)pageScrollViewModelWithTitle:(NSString *)title
                                   className:(NSString *)className;

/*!
 *  标题
 */
@property (nonatomic,copy) NSString * title;
/*!
 *  对应的ViewController的类型
 */
@property (nonatomic,copy) NSString * viewControllerClassName;

/*!
 *  实例化的viewController
 */
@property (nonatomic,strong) UIViewController * viewController;

@property (nonatomic,assign) BOOL didSelect;

@end














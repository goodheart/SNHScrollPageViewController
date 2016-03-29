//
//  SNHScrollPageViewController.h
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNHScrollPageViewController : UIViewController

/*!
 *  提供滚动到指定页的方法
 */
- (void)scrollToRow:(NSUInteger)row;

/*!
 *  重新刷新界面
 */
- (void)reloadPage;

#pragma mark - 抽象方法，由子类实现
/*!
 *  顶部view的高度 默认30.0f
 */
- (CGFloat)pageViewControllerForHeightForTopView:(SNHScrollPageViewController *)pageViewController;
/*!
 *  底部view的高度 默认整个view的高度 减 顶部view的高度30
 */
- (CGFloat)pageViewControllerForHeightForBottomView:(SNHScrollPageViewController *)pageViewController;
/*!
 *  数量
 */
- (NSInteger)numberOfItemForPageViewController:(SNHScrollPageViewController *)viewController;
/*!
 *  标题
 */
- (NSString *)pageViewController:(SNHScrollPageViewController *)viewController titleAtIndex:(NSUInteger)index;
/*!
 *  对应的类
 */
- (Class)pageViewController:(SNHScrollPageViewController *)viewController
               classAtIndex:(NSUInteger)index;
/*!
 *  实例化
 */
- (UIViewController *)pageViewController:(SNHScrollPageViewController *)viewController instanceForClass:(NSString *)className atIndex:(NSUInteger)index;

/*!
 *  自定义的cell 默认：SNHIndicatorCollectionViewCell
 */
- (NSString *)indicatorCollectionViewCellForPageViewController:(SNHScrollPageViewController *)viewController;

/*!
 *  自定义的layout default is SNHScrollPageIndicatorCollectionViewLayout
 */
- (UICollectionViewFlowLayout *)indicatorCollectionViewLayoutForPageViewController:(SNHScrollPageViewController *)viewController;

@end







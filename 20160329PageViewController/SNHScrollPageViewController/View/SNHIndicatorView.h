//
//  SNHIndicatorView.h
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNHPageScrollViewModel.h"
#import "SNHIndicatorCollectionViewCell.h"
#import "SNHScrollPageIndicatorCollectionViewLayout.h"

@class SNHIndicatorView;
@protocol SNHIndicatorViewDelegate <NSObject>

@optional
- (void)indicatorView:(SNHIndicatorView *)indicatorView
  didSelectTitleAtRow:(NSUInteger)row;

@end

@interface SNHIndicatorView : UIView

@property (nonatomic,strong) UICollectionViewFlowLayout * collectionViewFlowLayout;
@property (nonatomic,strong) NSString * collectionViewCellClass;
@property (nonatomic,weak) id<SNHIndicatorViewDelegate> delegate;
@property (nonatomic,strong) NSMutableArray<SNHPageScrollViewModel *> * dataSource;

- (void)selectItemAtRow:(NSInteger)row;

@end

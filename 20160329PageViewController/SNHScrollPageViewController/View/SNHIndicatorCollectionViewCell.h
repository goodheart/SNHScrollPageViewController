//
//  SNHIndicatorCollectionViewCell.h
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNHIndicatorPageCollectionViewCellProtocol.h"

/*!
 *  指示条显示cell 可以自定义
 */
@interface SNHIndicatorCollectionViewCell : UICollectionViewCell<SNHIndicatorPageCollectionViewCellProtocol>

@property (nonatomic,strong) SNHPageScrollViewModel * model;

@end

//
//  SNHIndicatorPageCollectionViewCellProtocol.h
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNHPageScrollViewModel.h"

@protocol SNHIndicatorPageCollectionViewCellProtocol <NSObject>

@property (nonatomic,strong) SNHPageScrollViewModel * model;

@end

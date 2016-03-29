//
//  SNHScrollPageIndicatorCollectionViewLayout.m
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "SNHScrollPageIndicatorCollectionViewLayout.h"

@implementation SNHScrollPageIndicatorCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(80, 20);
    self.minimumLineSpacing = 0;
}

@end

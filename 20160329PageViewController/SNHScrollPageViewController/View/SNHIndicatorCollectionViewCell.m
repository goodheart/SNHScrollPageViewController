//
//  SNHIndicatorCollectionViewCell.m
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "SNHIndicatorCollectionViewCell.h"

@interface SNHIndicatorCollectionViewCell ()

@property (nonatomic,strong) UILabel * titleLabel;

@end

@implementation SNHIndicatorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)setModel:(SNHPageScrollViewModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    UIColor * color = [UIColor blackColor];
    if (model.didSelect) {
        color = [UIColor grayColor];
    }
    self.titleLabel.textColor = color;
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return _titleLabel;
}

@end

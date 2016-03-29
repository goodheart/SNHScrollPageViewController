//
//  SNHIndicatorView.m
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "SNHIndicatorView.h"


@interface SNHIndicatorView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
> {
    BOOL _isRefresh; //标识collectionView是否重新刷新
    SNHPageScrollViewModel * _lastSelectedModel;
}

@property (nonatomic,strong) UICollectionView * indicatorCollectionView;

@end

@implementation SNHIndicatorView

- (void)setDataSource:(NSMutableArray<SNHPageScrollViewModel *> *)dataSource {
    _dataSource = dataSource;
    
    _isRefresh = YES;
    if (dataSource.count > 0) {
        _lastSelectedModel = dataSource.firstObject;
    }
    
    _indicatorCollectionView = nil;
    [self addSubview:self.indicatorCollectionView];
    [self.indicatorCollectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.indicatorCollectionView.frame = self.bounds;
}

#pragma mark - Public Method
- (void)selectItemAtRow:(NSInteger)row {
    [self _selectItemAtRow:row];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell<SNHIndicatorPageCollectionViewCellProtocol> * cell = [collectionView dequeueReusableCellWithReuseIdentifier:_indicatorCellID forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self _selectItemAtRow:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(indicatorView:didSelectTitleAtRow:)]) {
        [self.delegate indicatorView:self
                 didSelectTitleAtRow:indexPath.row];
    }
}

#pragma mark - Private Method
- (void)_selectItemAtRow:(NSInteger)row {
    if (row < 0 || row >= self.dataSource.count) {
        return;
    }
    
    _lastSelectedModel.didSelect = NO;
    SNHPageScrollViewModel * currentModel = self.dataSource[row];
    currentModel.didSelect = YES;
    _lastSelectedModel = currentModel;
    
    [_indicatorCollectionView reloadData];
}

#pragma mark - Lazy Initialization
static NSString * _indicatorCellID = nil;
- (UICollectionView *)indicatorCollectionView {
    if (_isRefresh == NO &&
        _indicatorCollectionView) {
        return _indicatorCollectionView;
    }
    
    SNHScrollPageIndicatorCollectionViewLayout * laoyut = [[SNHScrollPageIndicatorCollectionViewLayout alloc] init];
    laoyut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _indicatorCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:laoyut];
    _indicatorCollectionView.showsHorizontalScrollIndicator = NO;
    _indicatorCollectionView.backgroundColor = [UIColor whiteColor];
    _indicatorCollectionView.delegate = self;
    _indicatorCollectionView.dataSource = self;
    _indicatorCellID = self.collectionViewCellClass;
    
    NSString * path = [[NSBundle mainBundle] pathForResource:self.collectionViewCellClass ofType:@"nib"];
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        [_indicatorCollectionView registerNib:[UINib nibWithNibName:self.collectionViewCellClass bundle:nil] forCellWithReuseIdentifier:_indicatorCellID];
    } else {
        [_indicatorCollectionView registerClass:NSClassFromString(self.collectionViewCellClass)
                     forCellWithReuseIdentifier:_indicatorCellID];
    }

    _isRefresh = NO;
    
    return _indicatorCollectionView;
}

@end

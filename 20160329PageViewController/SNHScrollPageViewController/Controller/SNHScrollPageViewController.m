//
//  SNHScrollPageViewController.m
//  20160329PageViewController
//
//  Created by majian on 16/3/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "SNHScrollPageViewController.h"
#import "SNHIndicatorView.h"
#import "SNHPageScrollViewModel.h"

static CGFloat kSNHScrollPageTopViewHeight = 30.0f;

@interface SNHScrollPageViewController ()
<
UIPageViewControllerDelegate,
UIPageViewControllerDataSource,
SNHIndicatorViewDelegate> {
    SNHIndicatorView * _indicatorView;
    UIPageViewController * _pageViewController;
    BOOL _isFirstReload;
}

@property (nonatomic,strong) NSMutableArray<SNHPageScrollViewModel *> * modelDataSource;
@property (nonatomic,strong) SNHIndicatorView * indicatorView;
@property (nonatomic,strong) UIPageViewController * pageViewController;

@end

@implementation SNHScrollPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    _isFirstReload = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_isFirstReload) {
        _isFirstReload = NO;
        [self _reloadData];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _indicatorView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), [self pageViewControllerForHeightForTopView:self]);
    _pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(_indicatorView.frame), CGRectGetWidth(self.view.bounds), [self pageViewControllerForHeightForBottomView:self]);
}

#pragma mark - Public Method
- (void)scrollToRow:(NSUInteger)row {
    [self _showPageAtIndex:row];
}

- (void)reloadPage {
    [self _reloadData];
}

#pragma mark - UIPageViewControllerDataSource UIPageViewControllerDelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (self.modelDataSource.count <= 1) {
        return nil;
    }
    
    NSUInteger index = [self _rowForViewController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    return [self _viewControllerAtRow:(self.modelDataSource.count + index - 1) % self.modelDataSource.count];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.modelDataSource.count <= 1) {
        return nil;
    }
    
    NSUInteger index = [self _rowForViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    return [self _viewControllerAtRow:(index + 1 % self.modelDataSource.count)];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (finished && completed) {
        UIViewController * currentViewController = [_pageViewController.viewControllers firstObject];
        NSUInteger index = [self _rowForViewController:currentViewController];
        [self.indicatorView selectItemAtRow:index];
    }
}

#pragma mark - SNHIndicatorViewDelegate
- (void)indicatorView:(SNHIndicatorView * __nullable)indicatorView
  didSelectTitleAtRow:(NSUInteger)row {
    [self _showPageAtIndex:row];
}

#pragma mark - Private Method
- (void)_reloadData {
    [_modelDataSource removeAllObjects];
    _modelDataSource = nil;
    
    self.indicatorView.dataSource = self.modelDataSource;
    [self.view addSubview:self.indicatorView];
    
    [_pageViewController removeFromParentViewController];
    _pageViewController = nil;
    [self.view addSubview:self.pageViewController.view];
    [self _showPageAtIndex:0]; //默认显示第0页
    [self addChildViewController:self.pageViewController];
}

- (void)_showPageAtIndex:(NSInteger)row {
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (row < [self _rowForViewController:_pageViewController.viewControllers.firstObject]) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    [_pageViewController setViewControllers:@[[self _viewControllerAtRow:row]] direction:direction animated:YES completion:nil];
}

- (UIViewController *)_viewControllerAtRow:(NSInteger)row {
    if (row >= self.modelDataSource.count || row < 0) {
        return nil;
    }
    
    SNHPageScrollViewModel * model = self.modelDataSource[row];
    
    if (nil == model.viewController) {
        model.viewController = [self pageViewController:self instanceForClass:model.viewControllerClassName atIndex:row];
    }
    
    return model.viewController;
}

- (NSUInteger)_rowForViewController:(UIViewController *)viewController {
    
    if (viewController == nil) {
        return 0;
    }
    
    __block NSUInteger index = 0;
    [self.modelDataSource enumerateObjectsUsingBlock:^(SNHPageScrollViewModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.viewController == viewController) {
            index = idx;
        }
    }];
    
    return index;
}

#pragma mark - Lazy Initializatio
- (NSMutableArray<SNHPageScrollViewModel *> *)modelDataSource {
    if (_modelDataSource) {
        return _modelDataSource;
    }
    
    NSUInteger count = [self numberOfItemForPageViewController:self];
    
    NSMutableArray * tempDataSourceArrayM = [NSMutableArray new];
    for (NSUInteger index = 0; index < count; index++) {
        NSString * title = [self pageViewController:self titleAtIndex:index];
        NSString * className = NSStringFromClass([self pageViewController:self classAtIndex:index]);
        SNHPageScrollViewModel * model = [SNHPageScrollViewModel pageScrollViewModelWithTitle:title className:className];
        [tempDataSourceArrayM addObject:model];
        
        //第一次获取数据时 默认第0条数据被选中
        if (0 == index) {
            model.didSelect = YES;
        }
    }
    
    _modelDataSource = tempDataSourceArrayM;
    
    return _modelDataSource;
}

- (SNHIndicatorView *)indicatorView {
    if (_indicatorView) {
        return _indicatorView;
    }
    
    SNHIndicatorView * indicatorView = [[SNHIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kSNHScrollPageTopViewHeight)];
    indicatorView.delegate = self;
    indicatorView.collectionViewCellClass = [self indicatorCollectionViewCellForPageViewController:self];
    indicatorView.collectionViewFlowLayout = [self indicatorCollectionViewLayoutForPageViewController:self];
    _indicatorView = indicatorView;
    
    return _indicatorView;
}

- (UIPageViewController *)pageViewController {
    if (_pageViewController) {
        return _pageViewController;
    }
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.view.frame = CGRectMake(0, kSNHScrollPageTopViewHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kSNHScrollPageTopViewHeight);
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    return _pageViewController;
}

#pragma mark - 抽象方法
/*!
 *  顶部view的高度 默认30.0f
 */
- (CGFloat)pageViewControllerForHeightForTopView:(SNHScrollPageViewController *)pageViewController {
    return kSNHScrollPageTopViewHeight;
}
/*!
 *  底部view的高度 默认整个view的高度 减 顶部view的高度30
 */
- (CGFloat)pageViewControllerForHeightForBottomView:(SNHScrollPageViewController *)pageViewController {
    return CGRectGetHeight(self.view.bounds) - kSNHScrollPageTopViewHeight;
}
/*!
 *  数量
 */
- (NSInteger)numberOfItemForPageViewController:(SNHScrollPageViewController * __nullable)viewController {
    return 0;
}
/*!
 *  标题
 */
- (NSString *)pageViewController:(SNHScrollPageViewController * __nullable)viewController titleAtIndex:(NSUInteger)index {
    return @"";
}
/*!
 *  对应的类
 */
- (Class)pageViewController:(SNHScrollPageViewController *__nullable)viewController
               classAtIndex:(NSUInteger)index {
    return nil;
}
/*!
 *  实例化
 */
- (UIViewController *)pageViewController:(SNHScrollPageViewController *)viewController instanceForClass:(NSString *)className atIndex:(NSUInteger)index {
    return nil;
}

/*!
 *  自定义的cell
 */
- (NSString *)indicatorCollectionViewCellForPageViewController:(SNHScrollPageViewController *)viewController {
    return NSStringFromClass([SNHIndicatorCollectionViewCell class]);
}

/*!
 *  自定义的layout
 */
- (UICollectionViewFlowLayout *)indicatorCollectionViewLayoutForPageViewController:(SNHScrollPageViewController *)viewController {
    return [[SNHScrollPageIndicatorCollectionViewLayout alloc] init];
}

@end

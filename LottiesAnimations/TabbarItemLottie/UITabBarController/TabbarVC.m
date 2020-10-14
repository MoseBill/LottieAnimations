//
//  TabbarVC.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "TabbarVC.h"
#import "LoadingImage.h"

#import <QuartzCore/QuartzCore.h>

TabbarVC *tabbarVC;

@interface TabbarVC () <UITabBarControllerDelegate>

@property(nonatomic,strong)NSMutableArray <NSString *>*lottieImageMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*tabLottieMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*imagesMutArr;

@end

@implementation TabbarVC

-(instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
        tabbarVC = self;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}
                                             forState:UIControlStateSelected];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self UISetting];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myTabBar.height += self.myTabBar.offsetHeight;
    self.myTabBar.y = self.view.height - self.myTabBar.height;
    
    for (UITabBarItem *item in self.tabBar.items) {
        if ([item.title isEqualToString:@"首页"]) {
            [item pp_addBadgeWithText:@"99+"];
            [UIView animationAlert:item.badgeView];
            
//            shakerAnimation(item.badgeView, 2, 20);//重力弹跳动画效果
            
            [UIView 视图上下一直来回跳动的动画:item.badgeView];
        }
        
        
    }

//    for (UIView *subView in self.tabBar.subviews) {
//        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//
//        }
//    }
}

- (void)UISetting{
    
    NSMutableArray *mArr = NSMutableArray.array;
    for (int i = 0 ; i < self.childMutArr.count; i++){

        NSString *imageSelected = [NSString stringWithFormat:@"%@_selected",self.imagesMutArr[i]];
        NSString *imageUnselected = [NSString stringWithFormat:@"%@_unselected",self.imagesMutArr[i]];
        
        UIViewController *vc = self.childMutArr[i];
        
        [self addLottieImage:vc
                 lottieImage:self.lottieImageMutArr[i]];

        [vc setTitle:self.titleMutArr[i]];
        vc.tabBarItem.image = [[UIImage imageNamed:imageUnselected]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelected]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
#pragma mark —— 凸起部分判断逻辑和处理 —— 一般的图片
        for (NSNumber *b in self.humpIndex) {
            if (b.intValue == i) {
                [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(-self.myTabBar.humpOffsetY,
                                                               0,
                                                               -self.myTabBar.humpOffsetY / 2,
                                                               0)];//修改图片偏移量，上下，左右必须为相反数，否则图片会被压缩
                [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];//修改文字偏移量
            }
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.title = self.titleMutArr[i];
        [mArr addObject:nav];
    }
    
    self.viewControllers = mArr;
    
#pragma mark —— 凸起部分判断逻辑和处理 —— Lottie 动画
    for (int d = 0; d < self.childMutArr.count; d++) {
        if (self.humpIndex.count) {
            for (NSNumber *b in self.humpIndex) {
                if (d == b.intValue) {
                    [self.tabBar addLottieImage:d
                                        offsetY:- self.myTabBar.humpOffsetY / 2
                                     lottieName:self.tabLottieMutArr[d]];
                }
            }
        }else{
            [self.tabBar addLottieImage:d
                                offsetY:0
                             lottieName:self.tabLottieMutArr[d]];
        }
    }
    
    //初始显示
    if (self.firstUI_selectedIndex < self.viewControllers.count) {
        self.selectedIndex = self.firstUI_selectedIndex;//初始显示哪个
        [self lottieImagePlay:self.childMutArr[self.firstUI_selectedIndex]];
        [self.tabBar animationLottieImage:self.firstUI_selectedIndex];
    }
}


- (void)addLottieImage:(UIViewController *)vc
           lottieImage:(NSString *)lottieImage {
    vc.view.backgroundColor = [UIColor lightGrayColor];

    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:lottieImage];
    lottieView.frame = [UIScreen mainScreen].bounds;
    lottieView.contentMode = UIViewContentModeScaleAspectFit;
    lottieView.loopAnimation = YES;
    lottieView.tag = 100;
    [vc.view addSubview:lottieView];
}

- (void)lottieImagePlay:(UIViewController *)vc {
    LOTAnimationView *lottieView = (LOTAnimationView *)[vc.view viewWithTag:100];
    
    if (!lottieView ||
        ![lottieView isKindOfClass:LOTAnimationView.class]) {
        return;
    }
    
    lottieView.animationProgress = 0;
    [lottieView play];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    [self lottieImagePlay:viewController];
    return YES;
}
//点击事件
- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item {
    if ([self.tabBar.items containsObject:item]) {
        NSInteger index = [self.tabBar.items indexOfObject:item];
        [self.tabBar animationLottieImage:(int)index];
    }
}
#pragma mark —— lazyLoad
-(CustomTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = [[CustomTabBar alloc] initWithBgImg:nil];
        [self setValue:_myTabBar
                forKey:@"tabBar"];//KVC 进行替换
        _myTabBar.frame = self.tabBar.bounds;
    }return _myTabBar;
}

-(NSMutableArray<NSString *> *)lottieImageMutArr{
    if (!_lottieImageMutArr) {
        _lottieImageMutArr = NSMutableArray.array;
        [_lottieImageMutArr addObject:@"home_priase_animation"];
        [_lottieImageMutArr addObject:@"music_animation"];
        [_lottieImageMutArr addObject:@"record_change"];
        
        [_lottieImageMutArr addObject:@"home_priase_animation"];
        [_lottieImageMutArr addObject:@"music_animation"];
        [_lottieImageMutArr addObject:@"record_change"];
        
        [_lottieImageMutArr addObject:@"home_priase_animation"];
        [_lottieImageMutArr addObject:@"music_animation"];
        [_lottieImageMutArr addObject:@"record_change"];
    }return _lottieImageMutArr;
}

-(NSMutableArray<NSString *> *)tabLottieMutArr{
    if (!_tabLottieMutArr) {
        _tabLottieMutArr = NSMutableArray.array;
        [_tabLottieMutArr addObject:@"tab_home_animate"];
        [_tabLottieMutArr addObject:@"tab_search_animate"];
        [_tabLottieMutArr addObject:@"tab_message_animate"];
        
        [_tabLottieMutArr addObject:@"tab_home_animate"];
        [_tabLottieMutArr addObject:@"tab_search_animate"];
        [_tabLottieMutArr addObject:@"tab_message_animate"];
        
        [_tabLottieMutArr addObject:@"tab_home_animate"];
        [_tabLottieMutArr addObject:@"tab_search_animate"];
        [_tabLottieMutArr addObject:@"tab_message_animate"];
    }return _tabLottieMutArr;
}

-(NSMutableArray<UIViewController *> *)childMutArr{
    if (!_childMutArr) {
        _childMutArr = NSMutableArray.array;
    }return _childMutArr;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"首页"];
        [_titleMutArr addObject:@"精彩生活"];
        [_titleMutArr addObject:@"发现"];
        
        [_titleMutArr addObject:@"首页"];
        [_titleMutArr addObject:@"精彩生活"];
        [_titleMutArr addObject:@"发现"];
        
        [_titleMutArr addObject:@"首页"];
        [_titleMutArr addObject:@"精彩生活"];
        [_titleMutArr addObject:@"发现"];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)imagesMutArr{
    if (!_imagesMutArr) {
        _imagesMutArr = NSMutableArray.array;
        [_imagesMutArr addObject:@"community"];
        [_imagesMutArr addObject:@"post"];
        [_imagesMutArr addObject:@"My"];
        
        [_imagesMutArr addObject:@"community"];
        [_imagesMutArr addObject:@"post"];
        [_imagesMutArr addObject:@"My"];
        
        [_imagesMutArr addObject:@"community"];
        [_imagesMutArr addObject:@"post"];
        [_imagesMutArr addObject:@"My"];
    }return _imagesMutArr;
}

-(NSMutableArray<NSNumber *> *)humpIndex{
    if (!_humpIndex) {
        _humpIndex = NSMutableArray.array;
    }return _humpIndex;
}

@end

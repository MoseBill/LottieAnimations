//
//  VC@2.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/13.
//  Copyright © 2020 xa. All rights reserved.
//

#import "VC@2.h"

@interface VC_2 ()

@end

@implementation VC_2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    extern TabbarVC *tabbarVC;
    for (UITabBarItem *item in tabbarVC.myTabBar.items) {
        if ([item.title isEqualToString:@"首页"]) {
            [item pp_increase];
        }
    }
}



@end

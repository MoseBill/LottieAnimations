//
//  UIView+HitAreaExpand.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/13.
//  Copyright © 2020 xa. All rights reserved.
//

#import "UIView+HitAreaExpand.h"
#import "HitTestTool.h"
#import <objc/runtime.h>

@implementation UIView (HitAreaExpand)

- (CGFloat)minHitTestWidth {
    NSNumber * width = objc_getAssociatedObject(self, @selector(minHitTestWidth));
    return [width floatValue];
}

- (void)setMinHitTestWidth:(CGFloat)minHitTestWidth {
    objc_setAssociatedObject(self, @selector(minHitTestWidth), [NSNumber numberWithFloat:minHitTestWidth], OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)minHitTestHeight {
    NSNumber * height = objc_getAssociatedObject(self, @selector(minHitTestHeight));
    return [height floatValue];
}

- (void)setMinHitTestHeight:(CGFloat)minHitTestHeight {
    objc_setAssociatedObject(self, @selector(minHitTestHeight), [NSNumber numberWithFloat:minHitTestHeight], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    
    return CGRectContainsPoint(HitTestingBounds(self.bounds, self.minHitTestWidth, self.minHitTestHeight), point);
}

@end

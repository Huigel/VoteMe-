//
//  UIWindow+KeyWindow.m
//  HustHole
//
//  Created by Godlowd on 2021/5/1.
//

#import "UIWindow+KeyWindow.h"

@implementation UIWindow (KeyWindow)
+ (UIWindow *)getRootWindow {

    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            window.windowLevel == UIWindowLevelNormal &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}
@end

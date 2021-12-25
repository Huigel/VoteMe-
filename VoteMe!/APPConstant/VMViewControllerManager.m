//
//  VMViewControllerManager.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/3.
//

#import "VMViewControllerManager.h"

@implementation VMViewControllerManager

+(instancetype)sharedInstance{
    static dispatch_once_t singleFlag;
    static VMViewControllerManager * sharedManager;
    dispatch_once(&singleFlag, ^{
        sharedManager = [[VMViewControllerManager alloc] init];
    });
    return sharedManager;
}

-(UIViewController *)getNowViewController{
    UIViewController *result = nil;
        
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        if (window.windowLevel != UIWindowLevelNormal)
        {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tmpWin in windows)
            {
                if (tmpWin.windowLevel == UIWindowLevelNormal)
                {
                    window = tmpWin;
                    break;
                }
            }
        }
        
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
    return result;
}

@end

//
//  VMViewControllerManager.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/3.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface VMViewControllerManager : NSObject

+(instancetype)sharedInstance;

-(UIViewController *)getNowViewController;

@end

NS_ASSUME_NONNULL_END

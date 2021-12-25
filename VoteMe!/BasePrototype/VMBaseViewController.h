//
//  CIBaseViewController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/21.
//

#import "ViewController.h"
#import <Masonry.h>
#import <UIKit/UIKit.h>
#import "VMViewSizeAndColor.h"
#import "UIColor+Hex.h"
#import "VMNavigationBar.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "VMWebManager.h"
#import "VMHandleWebResponse.h"
#import "VMUserDefaultManager.h"
#import <UITextView+Placeholder.h>
#import "VMLabel.h"
#import <YYModel.h>
#import <Toast.h>
#import "VMPopView.h"
#import "VMWebManager.h"
#import "VMLoadingView.h"


NS_ASSUME_NONNULL_BEGIN

@interface VMBaseViewController : ViewController<VMHandleWebResponse>

@property(nonatomic, strong) VMNavigationBar *navigationBarView;

@end

NS_ASSUME_NONNULL_END

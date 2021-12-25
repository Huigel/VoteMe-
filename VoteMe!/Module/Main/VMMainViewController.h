//
//  CIMainViewController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import <UIKit/UIKit.h>
#import "VMBaseViewController.h"
#import "VMBottomTabBar.h"
#import "VMCardListViewController.h"
#import "VMRankingViewController.h"
#import "VMUserPageViewController.h"
//#import "VMCellConfigure.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMMainViewController :VMBaseViewController<VMBottomTabBarProtocol,VMHandleWebResponse>

@property(nonatomic, strong) VMBottomTabBar *BottomTabBar;

/**
 * current vc which show the view
 */
@property(nonatomic, strong) VMBaseViewController *mainVC;

@property(nonatomic, strong) VMBaseViewController *HomePageVC;

@property(nonatomic, strong) VMBaseViewController *RankPageVC;

@property(nonatomic, strong) VMBaseViewController *UserPageVC;

@property(nonatomic, strong) NSMutableArray<VMBaseViewController *> *SubViewConrollerArray;

+(instancetype)sharedInstance;

+(instancetype)sharedInstanceWithRefreshFlag:(BOOL)flag;

-(void)destroyMainViewcontroller;

@end

NS_ASSUME_NONNULL_END

//
//  CIBottomTabBar.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import <UIKit/UIKit.h>
#import "VMBaseView.h"
#import "VMBottomBarItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMBottomTabBar : VMBaseView<VMBottomTabBarProtocol>

@property(nonatomic, weak) UIViewController<VMBottomTabBarProtocol> *ChangeViewControllerDelegate;

@property(nonatomic, strong)VMBottomBarItem *HomePageItem;

@property(nonatomic, strong)VMBottomBarItem *RankingItem;

@property(nonatomic, strong)VMBottomBarItem *UserPageItem;

@property(nonatomic, strong) NSMutableArray<VMBottomBarItem *> *barItemArray;

-(void)configureBarItem;

@end

NS_ASSUME_NONNULL_END

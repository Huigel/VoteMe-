//
//  VMUserViewController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMBaseViewController.h"
#import "VMUserPageButton.h"
#import "VMNotificationBubbleView.h"
#import "VMUserVoteListController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMUserPageViewController : VMBaseViewController

@property(nonatomic, strong) UILabel *userNameLabel;

@property(nonatomic, strong) UILabel *userEmailLabel;

@property(nonatomic, strong) VMUserPageButton *myFavoriteButton;

@property(nonatomic, strong) VMUserPageButton *myCreateButton;

@property(nonatomic, strong) VMUserPageButton *myJoinButton;

@property(nonatomic, strong) VMNotificationBubbleView *notificationBubble;

@property(nonatomic, strong) UIButton *logoutButton;

//@property(nonatomic, strong) VMLabel *testLabel;

@end

NS_ASSUME_NONNULL_END

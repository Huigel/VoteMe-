//
//  VMNotificationBubbleView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMBaseView.h"
//#import "VMNotificationListController.h"


NS_ASSUME_NONNULL_BEGIN

@interface VMNotificationBubbleView : VMBaseView

@property(nonatomic, strong) UIView *baseBackgroundView;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UIView *yellowBallView;

@property(nonatomic, strong) UIButton *maskButton;

@property(nonatomic, assign) bool haveNewNotification;

-(instancetype)init;

@end

NS_ASSUME_NONNULL_END

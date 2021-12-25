//
//  CINavigationBar.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import <UIKit/UIKit.h>
#import "VMBaseView.h"
#import "VMNotificationBubbleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMNavigationBar : VMBaseView
/**
 * navigation title
 */
@property(nonatomic, strong) UILabel *title;
/**返回按钮*/
@property(nonatomic, strong) UIButton *backBtn;

@property(nonatomic, strong) VMNotificationBubbleView *notificationView;

@property(nonatomic, strong) UIButton *moreButton;

-(instancetype) init;
@end

NS_ASSUME_NONNULL_END

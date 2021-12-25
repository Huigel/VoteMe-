//
//  VMActionSheetView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/13.
//

#import "VMBaseView.h"
#import "VMActionSheetItemButton.h"
#import "VMNotificationBubbleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMActionSheetView : VMBaseView


@property(nonatomic, strong) UIView *maskView;

@property(nonatomic, strong) UIView *containerView;

@property(nonatomic, strong) UIButton *notificationButton;

@property(nonatomic, strong) VMActionSheetItemButton *favoriteButton;

@property(nonatomic, strong) VMActionSheetItemButton *deleteButton;

@property(nonatomic, strong) VMActionSheetItemButton *feedbackButton;

@property(nonatomic, strong) VMActionSheetItemButton *reportButton;

@property(nonatomic, strong) NSMutableArray<VMActionSheetItemButton *> *itemArray;
 


-(instancetype)init;

-(void)configureHierachy;

@end

NS_ASSUME_NONNULL_END

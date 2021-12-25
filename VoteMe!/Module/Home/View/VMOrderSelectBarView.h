//
//  VMOrderSelectBarView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/5.
//

#import "VMBaseView.h"

typedef NS_ENUM(NSInteger, VMOrderSelectBarState) {
    VMOrderedByDeadline,
    VMOrderedByCreateTime,
    VMOrderedCompleted
};

NS_ASSUME_NONNULL_BEGIN

@interface VMOrderSelectBarView : VMBaseView

@property(nonatomic, strong) UIButton *underWayButton;

@property(nonatomic, strong) UIButton *completeButton;

@property(nonatomic, strong) UIButton *orderedByDeadlineButton;

@property(nonatomic, strong) UIButton *orderedByCreateTimeButton;

@property(nonatomic, strong) UIView *subSelectBarView;

@property(nonatomic, strong) UIImageView *arrowsImageView;

@property(nonatomic, strong) UIView *leftBarViewUnderButton;

@property(nonatomic, strong) UIView *rightBarViewUnderButton;

@property(nonatomic, assign) VMOrderSelectBarState orderState;

@property(nonatomic, assign) VMOrderSelectBarState underWayOrderState;


-(instancetype)init; 

@end

NS_ASSUME_NONNULL_END

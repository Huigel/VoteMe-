//
//  VMUserTopBarView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMBaseView.h"

typedef NS_ENUM(NSInteger, VMUserTopBarState) {
    VMUserTopBarCollection,
    VMUserTopBarCreated,
    VMUserTopBarJoined
};

NS_ASSUME_NONNULL_BEGIN

@interface VMUserTopBarView : VMBaseView

@property(nonatomic, strong) UIButton *collectionButton;

@property(nonatomic, strong) UIButton *createdButton;

@property(nonatomic, strong) UIButton *joinedButton;

@property(nonatomic, strong) UIView *bottomBarView;

@property(nonatomic, assign) VMUserTopBarState state;

@property(nonatomic, assign) VMUserTopBarState currentState;

-(instancetype)initWithState:(VMUserTopBarState)Nowstate;

@end

NS_ASSUME_NONNULL_END

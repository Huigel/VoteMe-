//
//  VMCardListOptionModel.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMCardListOptionModel : VMBaseModel

@property(nonatomic, assign) NSInteger option_id;

@property(nonatomic, assign) NSInteger vote_id;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *img_link;

@property(nonatomic, assign) NSInteger num;

@end 

NS_ASSUME_NONNULL_END

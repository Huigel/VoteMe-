//
//  VMNotificationModel.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/17.
//

#import "VMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMNotificationModel : VMBaseModel

@property(nonatomic, assign) NSInteger notice_id;

@property(nonatomic, assign) NSInteger msg_type;

@property(nonatomic, copy) NSString *content;

@property(nonatomic, copy) NSString *send_at;

@property(nonatomic, assign) bool is_read;

@end

NS_ASSUME_NONNULL_END

//
//  VMBottomTabBarProtocol.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VMBottomTabBarProtocol <NSObject>

-(void)switchTabBarWithItemName:(NSString *)itemName;

-(void)switchMainViewController:(NSInteger)VCTag;

@end

NS_ASSUME_NONNULL_END

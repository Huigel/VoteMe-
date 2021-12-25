//
//  CIUserDefaultManager.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMUserDefaultManager : NSUserDefaults

@property(nonatomic, nullable, readonly, copy) NSString *token;

+(instancetype)sharedInstance;

-(void)setValue:(nullable)value forKey:(NSString *)key;

-(id)valueForKey:(NSString *)key;

/**
 * 退出登录清除所有用户信息
 */
-(void)logOut;

@end

NS_ASSUME_NONNULL_END

//
//  CIUserDefaultManager.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMUserDefaultManager.h"

@implementation VMUserDefaultManager


+(instancetype)sharedInstance{
    static dispatch_once_t singleFlag;
    static VMUserDefaultManager * sharedManager;
    dispatch_once(&singleFlag, ^{
        sharedManager = [[VMUserDefaultManager alloc] init];
    });
    return sharedManager;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}

-(id)valueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

-(void)logOut{
    NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
               [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
}

@end

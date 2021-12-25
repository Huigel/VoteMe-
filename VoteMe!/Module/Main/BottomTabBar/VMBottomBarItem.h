//
//  CIBottomBarItem.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import <UIKit/UIKit.h>
#import "VMBaseView.h"
#import "VMBottomTabBarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMBottomBarItem : VMBaseView

@property(nonatomic, weak) UIViewController<VMBottomTabBarProtocol> *ChangeItemDelegate;

@property(nonatomic, strong) UILabel *descLabel;

@property(nonatomic, strong) UIImageView *IconView;

@property(nonatomic, copy) NSString *itemName;

@property(nonatomic, assign) bool selected;

@property(nonatomic, strong) NSDictionary  *kIdentifierIconFileNameMapping;

-(instancetype)initWithItemName:(NSString *)itemName;

@end

NS_ASSUME_NONNULL_END

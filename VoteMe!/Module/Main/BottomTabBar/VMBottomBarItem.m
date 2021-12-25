//
//  CIBottomBarItem.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMBottomBarItem.h"

/**
 * define 2 state of tabBaritem and their coresponding colors
 */
static NSString *const kBarItemSelectedColor     = @"#A6B9FF";
static NSString *const kBarItemUnselectedColor   = @"#191D21";


@implementation VMBottomBarItem


-(instancetype)initWithItemName:(NSString *)itemName{
    VMBottomBarItem *item = [super init];
    
    item.itemName = itemName;
    
    item.IconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"InactiveTabBar%@",itemName]]];
    
    [item addSubview:item.IconView];
    [item.IconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25 * HEIGHT_SCALE);
        make.width.mas_equalTo(25 * WIDTH_SCALE);
        make.top.equalTo(item).with.offset(2 * HEIGHT_SCALE);
        make.centerX.equalTo(item);
    }];
    
    item.descLabel = [[UILabel alloc] init];
    item.descLabel.text = item.kIdentifierIconFileNameMapping[itemName];
    item.descLabel.textColor = [UIColor colorWithHexString:kBarItemSelectedColor];
    item.descLabel.numberOfLines = 0;
    item.descLabel.textAlignment = NSTextAlignmentCenter;
    item.descLabel.font = [UIFont systemFontOfSize:(12 * WIDTH_SCALE)];

    [item addSubview:item.descLabel];
    [item.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item.IconView.mas_bottom).with.offset(3 * HEIGHT_SCALE);
        make.bottom.centerX.equalTo(item);
        make.height.mas_equalTo(14 * HEIGHT_SCALE);
        make.width.mas_equalTo(50 * WIDTH_SCALE);
    }];
    
    UIButton *maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [item addSubview:maskBtn];
    [maskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(item);
    }];
    [maskBtn addTarget:item action:@selector(changeItemState) forControlEvents:UIControlEventTouchUpInside];
    
    item.selected = FALSE;
    [item addObserver:item forKeyPath:@"selected" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    return item;
}

#pragma mark - KVO
/**
 * listen to the value of the property of seleced, change the color of text and the icon of the tab with change of bool value of property
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"selected"]){
        
        if([[change valueForKey:@"new"]  isEqual: @1]){
            self.descLabel.textColor = [UIColor colorWithHexString:kBarItemSelectedColor];
            NSString *iconname = [NSString stringWithFormat:@"ActiveTabBar%@",self.itemName];
            self.IconView.image = [UIImage imageNamed:iconname];
            
            [self.ChangeItemDelegate switchTabBarWithItemName:self.itemName];
            
        }else{
            self.descLabel.textColor = [UIColor colorWithHexString:kBarItemUnselectedColor];
            NSString *iconname = [NSString stringWithFormat:@"InactiveTabBar%@",self.itemName];
            self.IconView.image = [UIImage imageNamed:iconname];
        }
        
    }
}


-(void)changeItemState{
    //[self.delegate switchTabBarWithItemName:self.itemName];
    self.selected = self.selected == TRUE ? self.selected : !self.selected;
}

#pragma mark - lazy load
-(NSDictionary *)kIdentifierIconFileNameMapping{
    if(!_kIdentifierIconFileNameMapping){
        _kIdentifierIconFileNameMapping = @{
            @"Home":@"首页",
            @"Rank":@"排行榜",
            @"User":@"我的"
            };
    }
    return _kIdentifierIconFileNameMapping;
}

@end

//
//  CIBottomTabBar.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMBottomTabBar.h"

@implementation VMBottomTabBar



-(void)configureBarItem{
    [self addSubview:self.HomePageItem];
    [self.HomePageItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(45 * WIDTH_SCALE);
        make.top.equalTo(self).with.offset(10 * HEIGHT_SCALE);
    }];
    self.HomePageItem.selected = true;
    
    [self addSubview:self.RankingItem];
    [self.RankingItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.HomePageItem);
    }];
    
    [self addSubview:self.UserPageItem];
    [self.UserPageItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-45 * WIDTH_SCALE);
        make.top.equalTo(self.HomePageItem);
    }];
    
    
    
}


#pragma mark - ChangeItemDelegate
-(void)switchTabBarWithItemName:(NSString *)itemName{
    for(int i = 0; i < self.barItemArray.count; i++){
        if(self.barItemArray[i].itemName != itemName){
            self.barItemArray[i].selected = false;
        }else{
            [self.ChangeViewControllerDelegate switchMainViewController:i];
        }
    }
}



#pragma mark - lazy load

-(VMBottomBarItem *)HomePageItem{
    if(!_HomePageItem){
        _HomePageItem = [[VMBottomBarItem alloc] initWithItemName:@"Home"];
        _HomePageItem.ChangeItemDelegate = self;
    }
    return _HomePageItem;
}

-(VMBottomBarItem *)RankingItem{
    if(!_RankingItem){
        _RankingItem = [[VMBottomBarItem alloc] initWithItemName:@"Rank"];
        _RankingItem.ChangeItemDelegate = self;
    }
    return _RankingItem;
}

-(VMBottomBarItem *)UserPageItem{
    if(!_UserPageItem){
        _UserPageItem = [[VMBottomBarItem alloc] initWithItemName:@"User"];
        _UserPageItem.ChangeItemDelegate = self;
    }
    return _UserPageItem;
}

-(NSMutableArray *)barItemArray{
    if(!_barItemArray){
        _barItemArray = [[NSMutableArray alloc] initWithObjects:self.HomePageItem, self.RankingItem, self.UserPageItem, nil];
        
    }
    return _barItemArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

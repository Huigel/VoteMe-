//
//  VMUserTopBarView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMUserTopBarView.h"

@implementation VMUserTopBarView


-(instancetype)initWithState:(VMUserTopBarState)Nowstate{
    self = [super init];
    
    self.state = Nowstate;
    self.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    [self configureHierachy];
    
    return self;
}

-(void)configureHierachy{
    
    [self addSubview:self.collectionButton];
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(25 * WIDTH_SCALE);
        make.top.equalTo(self);
        make.bottom.equalTo(self).with.offset(-7 * HEIGHT_SCALE);
        make.width.mas_equalTo(50 * WIDTH_SCALE);
    }];
    
    [self addSubview:self.createdButton];
    [self.createdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionButton.mas_right).with.offset(10 * WIDTH_SCALE);
        make.top.equalTo(self.collectionButton);
        make.bottom.equalTo(self.collectionButton);
        make.width.mas_equalTo(50 * WIDTH_SCALE);
    }];
    
    [self addSubview:self.joinedButton];
    [self.joinedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.createdButton.mas_right).with.offset(10 * WIDTH_SCALE);
        make.top.equalTo(self.collectionButton);
        make.bottom.equalTo(self.collectionButton);
        make.width.mas_equalTo(50 * WIDTH_SCALE);
    }];
    
    [self addSubview:self.bottomBarView];
    
}



#pragma mark - lazy load
-(UIButton *)collectionButton{
    if(!_collectionButton){
        _collectionButton = [[UIButton alloc] init];
        
        _collectionButton.titleLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        [_collectionButton setTitle:@"我收藏的" forState:(UIControlStateNormal)];
        [_collectionButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:(UIControlStateNormal)];
        
    }
    return _collectionButton;
}

-(UIButton *)createdButton{
    if(!_createdButton){
        _createdButton = [[UIButton alloc] init];
        
        _createdButton.titleLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        [_createdButton setTitle:@"我发起的" forState:(UIControlStateNormal)];
        [_createdButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:(UIControlStateNormal)];
        
    }
    return _createdButton;
}

-(UIButton *)joinedButton{
    if(!_joinedButton){
        _joinedButton = [[UIButton alloc] init];
        
        _joinedButton.titleLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        [_joinedButton setTitle:@"我参与的" forState:(UIControlStateNormal)];
        [_joinedButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:(UIControlStateNormal)];
        
    }
    return _joinedButton;
}

-(UIView *)bottomBarView{
    if(!_bottomBarView){
        _bottomBarView = [[UIButton alloc] init];
        _bottomBarView.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
    }
    return _bottomBarView;
}



@end

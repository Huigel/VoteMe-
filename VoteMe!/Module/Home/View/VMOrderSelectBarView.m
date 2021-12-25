//
//  VMOrderSelectBarView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/5.
//

#import "VMOrderSelectBarView.h"

@implementation VMOrderSelectBarView

-(instancetype)init{
    self = [super init];
    
    self.orderState = VMOrderedByDeadline;
    self.underWayOrderState = VMOrderedByDeadline;
    self.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    
    [self configureHierachy];
    
    return self;
}

-(void)configureHierachy{
    [self addSubview:self.underWayButton];
    [self.underWayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(38 * WIDTH_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(25 * WIDTH_SCALE);
        make.top.equalTo(self);
    }];
    
    [self addSubview:self.arrowsImageView];
    [self.arrowsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(8 * WIDTH_SCALE);
        make.height.mas_equalTo(7 * HEIGHT_SCALE);
        make.left.equalTo(self.underWayButton.mas_right).with.offset(2 * WIDTH_SCALE);
        make.centerY.equalTo(self.underWayButton);
    }];
    
    [self addSubview:self.completeButton];
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(38 * WIDTH_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
        make.left.equalTo(self.underWayButton.mas_right).with.offset(35 * WIDTH_SCALE);
        make.top.equalTo(self.underWayButton);
    }];
    
    [self addSubview:self.leftBarViewUnderButton];
    [self.leftBarViewUnderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40 * WIDTH_SCALE);
        make.height.mas_equalTo(2 * HEIGHT_SCALE);
        make.left.equalTo(self.underWayButton).with.offset(2 * WIDTH_SCALE);
        make.top.equalTo(self.underWayButton.mas_bottom).with.offset(4 * HEIGHT_SCALE);
    }];
    
    [self addSubview:self.rightBarViewUnderButton];
    [self.rightBarViewUnderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40 * WIDTH_SCALE);
        make.height.mas_equalTo(2 * HEIGHT_SCALE);
        make.centerX.equalTo(self.completeButton);
        make.top.equalTo(self.leftBarViewUnderButton);
    }];
    
    self.rightBarViewUnderButton.hidden = true;
    
    [self addSubview:self.subSelectBarView];
    [self.subSelectBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(24 * HEIGHT_SCALE);
        make.top.equalTo(self.leftBarViewUnderButton.mas_bottom);
        
        //make.bottom.equalTo(self);
    }];
    

    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftBarViewUnderButton).with.offset(4 * HEIGHT_SCALE);
        //make.bottom.equalTo(self.subSelectBarView).with.offset(4 * HEIGHT_SCALE);
    }];
    
    
    self.subSelectBarView.hidden = true;
    
}

-(void)rotateArrows{
    if(self.subSelectBarView.hidden){
        self.arrowsImageView.transform = CGAffineTransformMakeRotation(0);
        //[self.maskView removeFromSuperview];
        [self layoutIfNeeded];
        
        [UIView animateWithDuration:0.25 animations:^{
//            [self.orderView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.topBar.mas_bottom).with.offset(-44);
//            }];
//            self.orderView.alpha = 0;
            [self layoutIfNeeded];
        }];
        //self.maskView = nil;
        
    }else{
        self.arrowsImageView.transform = CGAffineTransformMakeRotation(3.1416);
        //self.orderView.alpha = 1;
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"orderChange" object:self userInfo:@{
//            @"order":[NSNumber numberWithInteger:(self.orderView.order ? HHHoleShowOrderCommentFirst : HHHoleShowOrderPostFirst)]
//        }];
        
        [UIView animateWithDuration:0.1 animations:^{
//            [self.arrowsImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.topBar.mas_bottom);
//            }];
            
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
//            [[HHMainViewController sharedInstance].view addSubview:self.maskView];
//            [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.orderView.mas_bottom);
//                make.left.right.bottom.equalTo(self.view);
//            }];
//
//            [self.maskView addTarget:self action:@selector(switchToPlaza)];
//            [self.maskView.superview bringSubviewToFront:self.maskView];
        }];
        
    }
}

#pragma mark - Button Action
-(void)underWayButtonClick{
    if(self.orderState == VMOrderedCompleted){
        self.orderState = self.underWayOrderState;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeOrderChange" object:nil];
        
        self.leftBarViewUnderButton.hidden = false;
        self.rightBarViewUnderButton.hidden = true;
        [self.underWayButton setTitleColor:[UIColor colorWithHexString:@"#081C34"] forState:(UIControlStateNormal)];
        [self.completeButton setTitleColor:[UIColor colorWithHexString:@"#A7B0B5"] forState:(UIControlStateNormal)];

    }
    
    self.arrowsImageView.hidden = false;
    if(self.subSelectBarView.hidden){
        [self arrowImageViewChange];
        self.subSelectBarView.hidden = false;

    }else{
        [self arrowImageViewChange];
        self.subSelectBarView.hidden = true;
        
    }
}

-(void)completeButtonClick{
    if(self.orderState == VMOrderedCompleted){
        
    }else{
        self.orderState = VMOrderedCompleted;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeOrderChange" object:nil];
        
        if(self.subSelectBarView.hidden){
            
        }else{
            [self arrowImageViewChange];
            self.subSelectBarView.hidden = true;
        }
        self.arrowsImageView.hidden = true;
        self.leftBarViewUnderButton.hidden = true;
        self.rightBarViewUnderButton.hidden = false;
        
        [self.completeButton setTitleColor:[UIColor colorWithHexString:@"#081C34"] forState:(UIControlStateNormal)];
        [self.underWayButton setTitleColor:[UIColor colorWithHexString:@"#A7B0B5"] forState:(UIControlStateNormal)];
    }
}

-(void)orderedByDeadlineButtonClick{
    if(self.orderState == VMOrderedByDeadline){
        
    }else if (self.orderState == VMOrderedByCreateTime){
        self.underWayOrderState = VMOrderedByDeadline;
        self.orderState = self.underWayOrderState;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeOrderChange" object:nil];
        
        self.orderedByDeadlineButton.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
        self.orderedByCreateTimeButton.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self.orderedByDeadlineButton setTitleColor:[UIColor colorWithHexString:@"#081C34"] forState:(UIControlStateNormal)];
        [self.orderedByCreateTimeButton setTitleColor:[UIColor colorWithHexString:@"#A7B0B5"] forState:(UIControlStateNormal)];
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeOrderChange" object:nil];
        
    }
}

-(void)orderedByCreateTimeButtonClick{
    if(self.orderState == VMOrderedByDeadline){
        self.underWayOrderState = VMOrderedByCreateTime;
        self.orderState = self.underWayOrderState;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeOrderChange" object:nil];
        
        self.orderedByDeadlineButton.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.orderedByCreateTimeButton.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
        [self.orderedByDeadlineButton setTitleColor:[UIColor colorWithHexString:@"#A7B0B5"] forState:(UIControlStateNormal)];
        [self.orderedByCreateTimeButton setTitleColor:[UIColor colorWithHexString:@"#081C34"] forState:(UIControlStateNormal)];
        
    }else if (self.orderState == VMOrderedByCreateTime){
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeOrderChange" object:nil];
    }
}

-(void)arrowImageViewChange{
    CGAffineTransform transform = self.arrowsImageView.transform;
    transform=CGAffineTransformRotate(transform, M_PI);
    self.arrowsImageView.transform = transform;
}

#pragma mark - lazy load
-(UIButton *)underWayButton{
    if(!_underWayButton){
        _underWayButton = [[UIButton alloc] init];
        _underWayButton.titleLabel.font = [UIFont boldSystemFontOfSize:12 * WIDTH_SCALE];
        [_underWayButton setTitle:@"未截止" forState:(UIControlStateNormal)];
        [_underWayButton setTitleColor:[UIColor colorWithHexString:@"#081C34"] forState:(UIControlStateNormal)];
        [_underWayButton addTarget:self action:@selector(underWayButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _underWayButton;
}

-(UIButton *)completeButton{
    if(!_completeButton){
        _completeButton = [[UIButton alloc] init];
        _completeButton.titleLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        [_completeButton setTitle:@"已截止" forState:(UIControlStateNormal)];
        [_completeButton setTitleColor:[UIColor colorWithHexString:@"#A7B0B5"] forState:(UIControlStateNormal)];
        [_completeButton addTarget:self action:@selector(completeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeButton;
}

-(UIButton *)orderedByDeadlineButton{
    if(!_orderedByDeadlineButton){
        _orderedByDeadlineButton = [[UIButton alloc] init];
        _orderedByDeadlineButton.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
        _orderedByDeadlineButton.layer.cornerRadius = 5 * WIDTH_SCALE;
        [UIView configureShadow:_orderedByDeadlineButton];
        
        _orderedByDeadlineButton.titleLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
        [_orderedByDeadlineButton setTitle:@"截止时间优先" forState:(UIControlStateNormal)];
        [_orderedByDeadlineButton setTitleColor:[UIColor colorWithHexString:@"#081C34"] forState:(UIControlStateNormal)];
        [_orderedByDeadlineButton addTarget:self action:@selector(orderedByDeadlineButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderedByDeadlineButton;
}

-(UIButton *)orderedByCreateTimeButton{
    if(!_orderedByCreateTimeButton){
        _orderedByCreateTimeButton = [[UIButton alloc] init];
        _orderedByCreateTimeButton.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _orderedByCreateTimeButton.layer.cornerRadius = 5 * WIDTH_SCALE;
        [UIView configureShadow:_orderedByCreateTimeButton];
        
        _orderedByCreateTimeButton.titleLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
        [_orderedByCreateTimeButton setTitle:@"发布时间优先" forState:(UIControlStateNormal)];
        [_orderedByCreateTimeButton setTitleColor:[UIColor colorWithHexString:@"#A7B0B5"] forState:(UIControlStateNormal)];
        [_orderedByCreateTimeButton addTarget:self action:@selector(orderedByCreateTimeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderedByCreateTimeButton;
}

-(UIView *)subSelectBarView{
    if(!_subSelectBarView){
        _subSelectBarView = [[UIView alloc] init];
        _subSelectBarView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _subSelectBarView.userInteractionEnabled = true;
        
        [_subSelectBarView addSubview:self.orderedByDeadlineButton];
        [self.orderedByDeadlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_subSelectBarView).with.offset(26 * WIDTH_SCALE);
            make.width.mas_equalTo(60 * WIDTH_SCALE);
            make.height.mas_equalTo(15 * HEIGHT_SCALE);
            make.top.equalTo(_subSelectBarView).with.offset(4 * HEIGHT_SCALE);
            make.bottom.equalTo(_subSelectBarView).with.offset(-4 * HEIGHT_SCALE);
        }];
        
        [_subSelectBarView addSubview:self.orderedByCreateTimeButton];
        [self.orderedByCreateTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.orderedByDeadlineButton.mas_right).with.offset(12 * WIDTH_SCALE);
            make.width.mas_equalTo(60 * WIDTH_SCALE);
            make.height.mas_equalTo(15 * HEIGHT_SCALE);
            make.top.equalTo(self.orderedByDeadlineButton);
        }];
    }
    return _subSelectBarView;
}

-(UIView *)leftBarViewUnderButton{
    if(!_leftBarViewUnderButton){
        _leftBarViewUnderButton = [[UIView alloc] init];
        _leftBarViewUnderButton.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
    }
    return _leftBarViewUnderButton;
}

-(UIView *)rightBarViewUnderButton{
    if(!_rightBarViewUnderButton){
        _rightBarViewUnderButton = [[UIView alloc] init];
        _rightBarViewUnderButton.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
    }
    return _rightBarViewUnderButton;
}

-(UIImageView *)arrowsImageView{
    if(!_arrowsImageView){
        _arrowsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomeOrderBarArrows"]];
    }
    return _arrowsImageView;
}


@end

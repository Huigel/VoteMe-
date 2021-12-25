//
//  VMPostVoteCardView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMPostVoteCardView.h"

@implementation VMPostVoteCardView

-(instancetype)init{
    self = [super init];
    

    
    
    [self configureHierachy];
    
    
    return self;;
}

-(void)configureHierachy{
    
    [self addSubview:self.cardBaseView];
    [self.cardBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.width.mas_equalTo(326 * WIDTH_SCALE);
        //make.bottom.equalTo(self);
    }];

    [self.cardBaseView addSubview:self.firstContentView];
    [self.firstContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cardBaseView);
        make.width.mas_equalTo(300 * WIDTH_SCALE);
        make.top.equalTo(self.cardBaseView);
        //make.bottom.equalTo(self);
    }];
    
    /*
     * 第一部分
     */
    
    [self.firstContentView addSubview:self.titleTextView];
    [self.titleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cardBaseView);
        make.width.mas_equalTo(280 * WIDTH_SCALE);
        make.top.equalTo(self.firstContentView).with.offset(20 * HEIGHT_SCALE);
        make.height.mas_equalTo(30 * HEIGHT_SCALE);
    }];
    
    UIView *separeterBarView1 = [[UIView alloc] init];
    separeterBarView1.backgroundColor = [UIColor colorWithHexString:@"#CDD0CB"];
    [self.firstContentView addSubview:separeterBarView1];
    [separeterBarView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.firstContentView);
        make.top.equalTo(self.titleTextView.mas_bottom).with.offset(15 * HEIGHT_SCALE);
        make.height.mas_equalTo(0.3 * HEIGHT_SCALE);
    }];
    
    [self.firstContentView addSubview:self.contentTextFieldBackgroundView];
    [self.contentTextFieldBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cardBaseView);
        make.width.mas_equalTo(300 * WIDTH_SCALE);
        make.top.equalTo(self.titleTextView.mas_bottom).with.offset(25 * HEIGHT_SCALE);
    }];
    
    [self.contentTextFieldBackgroundView addSubview:self.contentTextView];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentTextFieldBackgroundView).with.offset(9 * WIDTH_SCALE);
        make.right.equalTo(self.contentTextFieldBackgroundView).with.offset(-9 * WIDTH_SCALE);
        make.top.equalTo(self.contentTextFieldBackgroundView).with.offset(9 * WIDTH_SCALE);
        make.bottom.equalTo(self.contentTextFieldBackgroundView).with.offset(-9 * WIDTH_SCALE);
        make.height.mas_equalTo(90 * HEIGHT_SCALE);
    }];
    
    [self.firstContentView addSubview:self.addDetailPictureButton];
    [self.addDetailPictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextFieldBackgroundView.mas_bottom).with.offset(11 * HEIGHT_SCALE);
        make.left.equalTo(self.contentTextFieldBackgroundView).with.offset(10 * WIDTH_SCALE);
        make.width.mas_equalTo(14 * WIDTH_SCALE);
        make.height.mas_equalTo(17 * HEIGHT_SCALE);
        make.bottom.equalTo(self.firstContentView).with.offset(-10 * HEIGHT_SCALE);
    }];
    
    [self.addDetailPictureButton addSubview:self.detailNoPictureImageView];
    [self.detailNoPictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addDetailPictureButton);
        make.right.equalTo(self.addDetailPictureButton);
        make.top.equalTo(self.addDetailPictureButton);
        make.bottom.equalTo(self.addDetailPictureButton.mas_bottom).with.offset(-5 * HEIGHT_SCALE);
    }];
    
    self.detailHavePictureImageView.hidden = true;
    
    [self.addDetailPictureButton addSubview:self.detailHavePictureImageView];
    [self.detailHavePictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.addDetailPictureButton);
    }];

    
    UIView *separeterBarView2 = [[UIView alloc] init];
    separeterBarView2.backgroundColor = [UIColor colorWithHexString:@"#CDD0CB"];
    [self.firstContentView addSubview:separeterBarView2];
    [separeterBarView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.firstContentView);
        make.bottom.equalTo(self.firstContentView);
        make.height.mas_equalTo(0.3 * HEIGHT_SCALE);
    }];
    
    /*
     * 第二部分
     */
    
    [self.cardBaseView addSubview:self.secondContentView];
    [self.secondContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cardBaseView);
        make.width.mas_equalTo(300 * WIDTH_SCALE);
        //make.height.mas_equalTo(100 * HEIGHT_SCALE);
        make.top.equalTo(self.firstContentView.mas_bottom);
 //       make.bottom.equalTo(self);
    }];
    
//    VMPostVoteOpitionVIew *testView = [[VMPostVoteOpitionVIew alloc] init];
//
//    [self.secondContentView addSubview:testView];
//    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.secondContentView);
//        make.width.mas_equalTo(296 * WIDTH_SCALE);
//        make.height.mas_equalTo(20 * HEIGHT_SCALE);
//        make.top.equalTo(self.secondContentView).with.offset(28 * HEIGHT_SCALE);
// //       make.bottom.equalTo(self);
//    }];
    
    
    [self.secondContentView addSubview:self.addOptionButton];
    [self.addOptionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.secondContentView);
        make.top.equalTo(self.secondContentView).with.offset(15 * HEIGHT_SCALE);
        make.width.mas_equalTo(296 * WIDTH_SCALE);
        make.height.mas_equalTo(20 * HEIGHT_SCALE);
        make.bottom.equalTo(self.secondContentView).with.offset(-28 * HEIGHT_SCALE);
 //       make.bottom.equalTo(self);
    }];
    
    UIView *separeterBarView3 = [[UIView alloc] init];
    separeterBarView3.backgroundColor = [UIColor colorWithHexString:@"#CDD0CB"];
    [self.firstContentView addSubview:separeterBarView3];
    [separeterBarView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.secondContentView);
        make.bottom.equalTo(self.secondContentView);
        make.height.mas_equalTo(0.3 * HEIGHT_SCALE);
    }];
    
    /*
     * 第三部分
     */
    [self.cardBaseView addSubview:self.thirdContentView];
    [self.thirdContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cardBaseView);
        make.width.mas_equalTo(300 * WIDTH_SCALE);
        make.height.mas_equalTo(160 * HEIGHT_SCALE);
        make.top.equalTo(self.secondContentView.mas_bottom);
        make.bottom.equalTo(self.cardBaseView);
    }];
    
    UILabel *voteModeLabel = [[UILabel alloc] init];
    voteModeLabel.text = @"投票方式";
    voteModeLabel.textColor = [UIColor colorWithHexString:@"#081C34"];
    voteModeLabel.font = [UIFont boldSystemFontOfSize:10 * WIDTH_SCALE];
    
    [self.thirdContentView addSubview:voteModeLabel];
    [voteModeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdContentView).with.offset(4 * WIDTH_SCALE);
        make.top.equalTo(self.thirdContentView).with.offset(23 * HEIGHT_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
    }];
    
    UILabel *deadlineLabel = [[UILabel alloc] init];
    deadlineLabel.text = @"截止时间";
    deadlineLabel.textColor = [UIColor colorWithHexString:@"#081C34"];
    deadlineLabel.font = [UIFont boldSystemFontOfSize:10 * WIDTH_SCALE];
    
    [self.thirdContentView addSubview:deadlineLabel];
    [deadlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdContentView).with.offset(4 * WIDTH_SCALE);
        make.top.equalTo(self.thirdContentView).with.offset(59 * HEIGHT_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
    }];
    
    UILabel *tipslineLabel = [[UILabel alloc] init];
    tipslineLabel.text = @"💡Tips：投票一经发布不可再修改，请再次检查噢~";
    tipslineLabel.textColor = [UIColor colorWithHexString:@"#081C34"];
    tipslineLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
    
    [self.thirdContentView addSubview:tipslineLabel];
    [tipslineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdContentView).with.offset(4 * WIDTH_SCALE);
        make.top.equalTo(self.thirdContentView).with.offset(108 * HEIGHT_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
    }];
    
    [self.thirdContentView addSubview:self.radioButton];
    [self.radioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(voteModeLabel.mas_right).with.offset(23 * WIDTH_SCALE);
        make.centerY.equalTo(voteModeLabel);
        make.width.mas_equalTo(45 * WIDTH_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
    }];
    
    [self.thirdContentView addSubview:self.deadlineButton];
    [self.deadlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.radioButton);
        make.centerY.equalTo(deadlineLabel);
        make.width.mas_equalTo(70 * WIDTH_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
    }];
    
    
    /*
     * 发布按钮
     */
    [self addSubview:self.postButton];
    [self.postButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(55 * WIDTH_SCALE);
        make.height.mas_equalTo(20 * HEIGHT_SCALE);
        make.right.equalTo(self).with.offset(-19 * WIDTH_SCALE);
        make.top.equalTo(self.cardBaseView.mas_bottom).with.offset(15 * HEIGHT_SCALE);
        make.bottom.equalTo(self);
    }];
    
}


#pragma mark - add or delete option
-(void)addNewOption{
    VMPostVoteOpitionVIew *optionView = [[VMPostVoteOpitionVIew alloc] init];
    optionView.optionContentTextView.delegate = self;
    
    [optionView.deleteOpitionButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        [self deleteOption:optionView];
    }]forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.secondContentView addSubview:optionView];
    if(self.optionArray.count == 0){
        [optionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondContentView).with.offset(15 * HEIGHT_SCALE);
            make.centerX.equalTo(self.secondContentView);
            make.width.mas_equalTo(296 * WIDTH_SCALE);
            //make.height.mas_equalTo(20 * HEIGHT_SCALE);
        }];
    }else{
        [optionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.optionArray[self.optionArray.count - 1].mas_bottom).with.offset(11 * HEIGHT_SCALE);
            make.centerX.equalTo(self.secondContentView);
            make.width.mas_equalTo(296 * WIDTH_SCALE);
            //make.height.mas_equalTo(20 * HEIGHT_SCALE);
        }];
    }

    [self.addOptionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.secondContentView);
        make.top.equalTo(optionView.mas_bottom).with.offset(9 * HEIGHT_SCALE);
        make.width.mas_equalTo(296 * WIDTH_SCALE);
        make.height.mas_equalTo(20 * HEIGHT_SCALE);
        make.bottom.equalTo(self.secondContentView).with.offset(-28 * HEIGHT_SCALE);
    }];
    

    [self.optionArray addObject:optionView];
    
}

-(void)deleteOption:(VMPostVoteOpitionVIew *)optionView{
    

    NSInteger i;
    for(i = 0; i < self.optionArray.count; i++){
        if([self.optionArray[i] isEqual:optionView]){
            break;
        }
    }
    
    if(self.optionArray.count == 1){//当前只有一个选项
        [self.addOptionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.secondContentView);
            make.top.equalTo(self.secondContentView).with.offset(15 * HEIGHT_SCALE);
            make.width.mas_equalTo(296 * WIDTH_SCALE);
            make.height.mas_equalTo(20 * HEIGHT_SCALE);
            make.bottom.equalTo(self.secondContentView).with.offset(-28 * HEIGHT_SCALE);
        }];
    }else if(i == 0){//是第一个选项
        float viewHeight = self.optionArray[i + 1].frame.size.height;
        [self.optionArray[i + 1] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.secondContentView);
            make.top.equalTo(self.secondContentView).with.offset(15 * HEIGHT_SCALE);
            make.width.mas_equalTo(296 * WIDTH_SCALE);
            make.height.mas_equalTo(viewHeight);
        }];
    }else if(i == self.optionArray.count - 1){//是最后一个选项
        [self.addOptionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.secondContentView);
            make.top.equalTo(self.optionArray[i - 1].mas_bottom).with.offset(9 * HEIGHT_SCALE);
            make.width.mas_equalTo(296 * WIDTH_SCALE);
            make.height.mas_equalTo(20 * HEIGHT_SCALE);
            make.bottom.equalTo(self.secondContentView).with.offset(-28 * HEIGHT_SCALE);
        }];
    }else{//其他情况
        float viewHeight = self.optionArray[i + 1].frame.size.height;
        [self.optionArray[i + 1] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.secondContentView);
            make.top.equalTo(self.optionArray[i - 1].mas_bottom).with.offset(9 * HEIGHT_SCALE);
            make.width.mas_equalTo(296 * WIDTH_SCALE);
            make.height.mas_equalTo(viewHeight);
        }];
    }
    
    
    [optionView removeFromSuperview];
    [self.optionArray removeObject:optionView];
}



#pragma mark - TextView Delegate
-(void)textViewDidChange:(UITextView *)textView{
    CGFloat minHeight = 20.0 * HEIGHT_SCALE;
    if([textView isEqual:self.titleTextView]){
        minHeight  = 30.0 * HEIGHT_SCALE;
    }else if([textView isEqual:self.contentTextView]){
        minHeight  = 90.0 * HEIGHT_SCALE;
    }
    
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if(size.height < minHeight){
        size.height = minHeight;
    }
    if([textView isEqual:self.titleTextView]){
        [self.titleTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(280 * WIDTH_SCALE);
            make.top.equalTo(self.firstContentView).with.offset(20 * HEIGHT_SCALE);
            make.height.mas_equalTo(size.height);
        }];
    }else if ([textView isEqual:self.contentTextView]){
        [self.contentTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentTextFieldBackgroundView).with.offset(9 * WIDTH_SCALE);
            make.right.equalTo(self.contentTextFieldBackgroundView).with.offset(-9 * WIDTH_SCALE);
            make.top.equalTo(self.contentTextFieldBackgroundView).with.offset(9 * WIDTH_SCALE);
            make.bottom.equalTo(self.contentTextFieldBackgroundView).with.offset(-9 * WIDTH_SCALE);
            make.height.mas_equalTo(size.height);
        }];
    }else{
        for(NSInteger i = 0; i < self.optionArray.count; i++){
            if([textView isEqual:self.optionArray[i].optionContentTextView]){
                [self.optionArray[i].optionContentTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(size.height);
                    //make.height.mas_equalTo(size.height - 10 * HEIGHT_SCALE);
                    make.top.bottom.left.equalTo(self.optionArray[i]);
//                    make.left.equalTo(self.optionArray[i]);
//                    make.top.equalTo(self.optionArray[i]).with.offset(-5 * HEIGHT_SCALE);
//                    make.bottom.equalTo(self.optionArray[i]).with.offset(5 * HEIGHT_SCALE);
                }];
            }
        }
    }
}

#pragma mark - lazy load
-(UIView *)cardBaseView{
    if(!_cardBaseView){
        _cardBaseView = [[UIView alloc] init];
        _cardBaseView.backgroundColor = [UIColor whiteColor];
        _cardBaseView.layer.cornerRadius = 10 * WIDTH_SCALE;
        
        _cardBaseView.layer.shadowColor = [UIColor grayColor].CGColor;
        _cardBaseView.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
        _cardBaseView.layer.shadowOpacity = 0.4;
        _cardBaseView.layer.shadowRadius = 3 * WIDTH_SCALE;
    }
    return _cardBaseView;
}

-(UIView *)firstContentView{
    if(!_firstContentView){
        _firstContentView = [[UIView alloc] init];
    }
    return _firstContentView;
}

-(UITextView *)titleTextView{
    if(!_titleTextView){
        _titleTextView = [[UITextView alloc] init];
        _titleTextView.font = [UIFont systemFontOfSize:12 * HEIGHT_SCALE];
        _titleTextView.placeholder = [NSString stringWithFormat:@"填写投票题目"];
        _titleTextView.placeholderColor = [UIColor colorWithHexString:@"#CDD0CB"];
        _titleTextView.scrollEnabled = NO;    // 不允许滚动
        _titleTextView.delegate = self;
    }
    return _titleTextView;
}

-(UIView *)contentTextFieldBackgroundView{
    if(!_contentTextFieldBackgroundView){
        _contentTextFieldBackgroundView = [[UIView alloc] init];
        _contentTextFieldBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _contentTextFieldBackgroundView.layer.cornerRadius = 12 * WIDTH_SCALE;
    }
    return _contentTextFieldBackgroundView;
}

-(UITextView *)contentTextView{
    if(!_contentTextView){
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _contentTextView.autocapitalizationType=UITextAutocapitalizationTypeNone;
        _contentTextView.font = [UIFont systemFontOfSize:12 * HEIGHT_SCALE];
        _contentTextView.placeholder = [NSString stringWithFormat:@"填写投票描述"];
        _contentTextView.placeholderColor = [UIColor colorWithHexString:@"#CDD0CB"];
        _contentTextView.scrollEnabled = NO;
        _contentTextView.delegate = self;
    }
    return _contentTextView;
}

-(UIButton *)addDetailPictureButton{
    if(!_addDetailPictureButton){
        _addDetailPictureButton = [[UIButton alloc] init];
    }
    return _addDetailPictureButton;
}

-(UIImageView *)detailHavePictureImageView{
    if(!_detailHavePictureImageView){
        _detailHavePictureImageView = [[UIImageView alloc] init];
        _detailHavePictureImageView.image = [UIImage imageNamed:@"OptionHavePicture"];
    }
    return _detailHavePictureImageView;
}

-(UIImageView *)detailNoPictureImageView{
    if(!_detailNoPictureImageView){
        _detailNoPictureImageView = [[UIImageView alloc] init];
        _detailNoPictureImageView.image = [UIImage imageNamed:@"OptionNoPicture"];
    }
    return _detailNoPictureImageView;
}

-(UIView *)secondContentView{
    if(!_secondContentView){
        _secondContentView = [[UIView alloc] init];
    }
    return _secondContentView;
}

-(NSMutableArray<VMPostVoteOpitionVIew *> *)optionArray{
    if(!_optionArray){
        _optionArray = [[NSMutableArray<VMPostVoteOpitionVIew *> alloc] init];
    }
    return _optionArray;
}

-(UIButton *)addOptionButton{
    if(!_addOptionButton){
        _addOptionButton = [[UIButton alloc] init];
        _addOptionButton.backgroundColor = [UIColor colorWithHexString:@"#FDEFEF"];
        _addOptionButton.layer.cornerRadius = 5 * WIDTH_SCALE;
        _addOptionButton.titleLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
        [_addOptionButton setTitle:@"+ 添加投票选项" forState:(UIControlStateNormal)];
        [_addOptionButton setTitleColor:[UIColor colorWithHexString:@"#081C34"] forState:(UIControlStateNormal)];
        [_addOptionButton addTarget:self action:@selector(addNewOption) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addOptionButton;
}

-(UIView *)thirdContentView{
    if(!_thirdContentView){
        _thirdContentView = [[UIView alloc] init];
    }
    return _thirdContentView;
}


-(UIButton *)radioButton{
    if(!_radioButton){
        _radioButton = [[UIButton alloc] init];
        _radioButton.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
        _radioButton.layer.cornerRadius = 5 * WIDTH_SCALE;
        _radioButton.titleLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
        _radioButton.titleLabel.hidden = false;
        [_radioButton setTitle:@"单选" forState:(UIControlStateNormal)];
        [_radioButton setTitleColor:[UIColor colorWithHexString:@"#081C34"] forState:(UIControlStateNormal)];
    }
    return _radioButton;
}

-(UIButton *)deadlineButton{
    if(!_deadlineButton){
        _deadlineButton = [[UIButton alloc] init];
        _deadlineButton.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _deadlineButton.layer.cornerRadius = 5 * WIDTH_SCALE;
        _deadlineButton.titleLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
        _deadlineButton.titleLabel.hidden = false;
        [_deadlineButton setTitle:@"点击选择" forState:(UIControlStateNormal)];
        [_deadlineButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
    }
    return _deadlineButton;
}

-(UIButton *)postButton{
    if(!_postButton){
        _postButton = [[UIButton alloc] init];
        _postButton.backgroundColor = [UIColor colorWithHexString:@"#DBF2FF"];
        _postButton.layer.cornerRadius = 10 * WIDTH_SCALE;
//        _postButton.titleLabel.text = @"发布";
//        _postButton.titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _postButton.titleLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
        _postButton.titleLabel.hidden = false;
        [_postButton setTitle:@"发布" forState:(UIControlStateNormal)];
        [_postButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
    }
    return _postButton;
}

@end

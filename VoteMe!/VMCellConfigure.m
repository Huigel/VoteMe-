//
//  VMCellConfigure.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMCellConfigure.h"
#import "VMCommentDetailController.h"

@implementation VMCellConfigure

+(void)configureVoteListCell:(VMCardListCollectionCell *)cell withModel:(VMCardListCellModel *)model{
    
    [cell layoutSubviews];
    cell.cellModel = model;
    cell.titleLabel.text = model.title;
    //cell.titleLabel.text = @"这里是题目，最多呈现两行。这里是题目，最多呈现两行。这里是题目，最多呈现两行。这里是题目，最多呈现两行。";
    cell.contentLabel.text = model.content;
    //cell.contentLabel.text = @"这里是描述，最多三行，这里是描述，最多三行，这里是描述，最多三行，这里是描述，最多三行，这里是描述，最多三行，这里是描述，最多三行，这里是描述，最多三行，这里是描述，最多三行";
    cell.createrLabel.text = model.username;
    cell.timeLabel.text = [VMCellConfigure timeExtractBBEnd:model.end_time];
    
    for(NSInteger i = 0; i < cell.optionArray.count; i++){
        [cell.optionArray[i] removeFromSuperview];
    }
    
    [cell.optionArray removeAllObjects];
    
    
    for(NSInteger i = 0 ; i < model.options.count; i++){
        VMCardOptionView *optionView = [[VMCardOptionView alloc] initWithContent:[model.options[i] valueForKey:@"name"] havePicture:([[model.options[i] valueForKey:@"img_link"] isEqualToString:@""] ? 0 : 1)];
        
        optionView.backgroundColor = [UIColor colorWithHexString:@"#EDF8EB"];
        
        [cell.optionArray addObject:optionView];
        
        [cell addSubview:cell.optionArray[i]];
        [cell.optionArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                make.top.equalTo(cell.contentLabel.mas_bottom).with.offset(9 * HEIGHT_SCALE);
            }else{
                make.top.equalTo(cell.optionArray[i - 1].mas_bottom).with.offset(4 * HEIGHT_SCALE);
            }
            make.left.equalTo(cell).with.offset(10 * WIDTH_SCALE);
            make.right.equalTo(cell).with.offset(-10 * WIDTH_SCALE);
            make.height.mas_equalTo(15 * HEIGHT_SCALE);
        }];
        
    }
    
    
}

#pragma mark - 投票详情页部分

+(void)configDetailHostCell:(VMVoteDetailHostCell *)cell withModel:(VMVoteDetailHostModel *)model couldVote:(BOOL)flag{
    
    cell.createrNameLabel.text = model.username;
    cell.deadlineLabel.text = [VMCellConfigure timeExtractBBEnd:model.end_time];
    //cell.endTimeLabel.text = [VMCellConfigure timeExtractBBEnd:model.end_time];
    cell.endTimeLabel.text = [model.end_time substringToIndex:10];
    cell.titleLabel.text = model.title;
    cell.detailLabel.text = model.content;
    
    CGFloat sumVoter = 0;
    if(!flag){
        for(NSInteger i = 0; i < model.options.count; i++){
            sumVoter += [[model.options[i] valueForKey:@"num"] integerValue];
        }
        if(sumVoter == 0){
            sumVoter = 1.0;
        }
    }
    
    if(![model.img isEqualToString:@""]){
        [cell.contentView addSubview:cell.detailImageView];
        [cell.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(156 * WIDTH_SCALE);
            make.height.mas_equalTo(100 * HEIGHT_SCALE);
            make.top.equalTo(cell.detailLabel.mas_bottom).with.offset(12 * HEIGHT_SCALE);
            make.left.equalTo(cell.detailLabel);
        }];
        

        [cell.detailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.img]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image){
                cell.detailImageView.image = image;
            }else{
                cell.detailImageView.image = [UIImage imageNamed:@"TempPicture"];
            }
        }];
        
        cell.detailImageView.userInteractionEnabled = YES;
        UIButton *maskButton = [[UIButton alloc] init];
        
        [maskButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
           
            //[VMPictureDetailView shareInstance].delegate = self;
            [[VMPictureDetailView shareInstance] setPictureDetailType:VMPictureDetailDownloadType];
            [VMPictureDetailView shareInstance].pictureImageView.image = cell.detailImageView.image;
            
            [[VMPictureDetailView shareInstance] showPictureDetail];

        }] forControlEvents:UIControlEventTouchUpInside];
        
        [cell.detailImageView addSubview:maskButton];
        [maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.detailImageView);
        }];

    }

    
    for(NSInteger i = 0 ; i < model.options.count; i++){
        
        VMVoteDetailOptionView *optionView = [[VMVoteDetailOptionView alloc] initWithType:(flag ? VMOptionYypeUnselected : VMOptionYypeSelected)];
        
        optionView.declareLabel.text = [model.options[i] valueForKey:@"name"];
        
        if(!flag){
            optionView.numLabel.text = [NSString stringWithFormat:@"%@人", [model.options[i] valueForKey:@"num"]];
        }
        
        //optionView.backgroundColor = [UIColor colorWithHexString:@"#EDF8EB"];
        //NSString * test = optionView.declareLabel.text;
        if([[model.options[i] valueForKey:@"img_link"] isEqualToString:@""]){
            [optionView.optionPictureImageView removeFromSuperview];
     
            [optionView.declareLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(optionView.actionButton).with.offset(15 * HEIGHT_SCALE);
                make.left.equalTo(optionView.actionButton).with.offset(12 * WIDTH_SCALE);
                make.right.equalTo(optionView.actionButton).with.offset(-12 * WIDTH_SCALE);
                make.bottom.equalTo(optionView.actionButton).with.offset(-15 * HEIGHT_SCALE);
            }];
        }else{
            
            optionView.optionPictureImageView.userInteractionEnabled = YES;
            UIButton *maskButton = [[UIButton alloc] init];
            
            [maskButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
               
                //[VMPictureDetailView shareInstance].delegate = self;
                [[VMPictureDetailView shareInstance] setPictureDetailType:VMPictureDetailDownloadType];
                [VMPictureDetailView shareInstance].pictureImageView.image = optionView.optionPictureImageView.image;
                
                [[VMPictureDetailView shareInstance] configureImageSize];
                
                [[[VMViewControllerManager sharedInstance] getNowViewController].view addSubview:[VMPictureDetailView shareInstance]];
                
                [[VMPictureDetailView shareInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo([[VMViewControllerManager sharedInstance] getNowViewController].view);
                }];

            }] forControlEvents:UIControlEventTouchUpInside];
            
            [optionView.optionPictureImageView addSubview:maskButton];
            [maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(optionView.optionPictureImageView);
            }];
            
            
            
            [optionView.optionPictureImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", [model.options[i] valueForKey:@"img_link"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image){
                    optionView.optionPictureImageView.image = image;
                }else{
                    optionView.optionPictureImageView.image = [UIImage imageNamed:@"TempPicture"];
                }
            }];
            
            [optionView.declareLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(optionView.actionButton).with.offset(15 * HEIGHT_SCALE);
                make.left.equalTo(optionView.actionButton).with.offset(12 * WIDTH_SCALE);
                make.right.equalTo(optionView.optionPictureImageView.mas_left).with.offset(-12 * WIDTH_SCALE);
                make.bottom.equalTo(optionView.actionButton).with.offset(-15 * HEIGHT_SCALE);
            }];
        }
        
        if(!flag){
            optionView.numLabel.text = [NSString stringWithFormat:@"%@人", [model.options[i] valueForKey:@"num"]];
            
            CGFloat nowRate = [[model.options[i] valueForKey:@"num"] integerValue]/sumVoter;
            CGFloat nowWidth = nowRate * 297 * WIDTH_SCALE;
            [optionView.rateView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(nowWidth);
            }];
        }
        
        [cell.optionArray addObject:optionView];
        
        [optionView.actionButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            [cell.OptionDelectDelegate switchSelectWithIndex:i];
        }]forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:cell.optionArray[i]];
        
        [cell.optionArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                if(![[model valueForKey:@"img"] isEqualToString:@""]){
                    make.top.equalTo(cell.detailImageView.mas_bottom).with.offset(24 * HEIGHT_SCALE).priority(1000);
                }else{
                    make.top.equalTo(cell.detailLabel.mas_bottom).with.offset(24 * HEIGHT_SCALE);
                }
            }else{
                make.top.equalTo(cell.optionArray[i - 1].mas_bottom).with.offset(10 * HEIGHT_SCALE).priority(1000);
            }
            make.left.equalTo(cell.contentView ).with.offset(24 * WIDTH_SCALE);
            make.right.equalTo(cell.contentView ).with.offset(-24 * WIDTH_SCALE);
            //make.height.mas_equalTo(15 * HEIGHT_SCALE);
        }];
        if(i == model.options.count - 1){
            if(cell.couldVote){
                [cell.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.optionArray[i].mas_bottom).with.offset(22 * HEIGHT_SCALE).priority(1000);
                    make.centerX.equalTo(cell.contentView);
                    make.width.mas_equalTo(157 * WIDTH_SCALE).priority(1000);
                    make.height.mas_equalTo(40 * HEIGHT_SCALE).priority(1000);
                }];
            }else{
                [cell.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.optionArray[i].mas_bottom).with.offset(25 * HEIGHT_SCALE).priority(1000);
                    make.left.equalTo(cell.contentView).with.offset(23 * WIDTH_SCALE);
                }];
            }
        }
    }
}

+(void)configDetailCommentCell:(VMVoteDetailCommentCell *)cell withModel:(VMVoteDetailCommentModel *)model{
    
    cell.createrNameLabel.text = model.name;
    cell.timeLabel.text = [VMCellConfigure timeExtractBBEnd:model.send_at];
    cell.contentLabel.text = model.content;
    
    if(model.remarks){//有回复
        if(model.remarks.count >= 1){
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = [NSString stringWithFormat:@"%@：%@", [model.remarks[0] valueForKey:@"name"], [model.remarks[0] valueForKey:@"content"]];
            label1.textColor = [UIColor colorWithHexString:@"#000000"];
            label1.font = [UIFont systemFontOfSize:8 * HEIGHT_SCALE];
            label1.numberOfLines = 2;
            [cell.remarkBackgroundView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.remarkBackgroundView).with.offset(8 * WIDTH_SCALE);
                make.right.equalTo(cell.remarkBackgroundView).with.offset(-7 * WIDTH_SCALE);
                make.top.equalTo(cell.remarkBackgroundView).with.offset(10 * HEIGHT_SCALE);
            }];
            if(model.remarks.count == 1){
                [label1 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(cell.remarkBackgroundView).with.offset(-12 * HEIGHT_SCALE);
                }];
            }else{
                UILabel *label2 = [[UILabel alloc] init];
                label2.text = [NSString stringWithFormat:@"%@：%@", [model.remarks[0] valueForKey:@"name"], [model.remarks[0] valueForKey:@"content"]];
                label2.textColor = [UIColor colorWithHexString:@"#000000"];
                label2.font = [UIFont systemFontOfSize:8 * HEIGHT_SCALE];
                label2.numberOfLines = 2;
                [cell.remarkBackgroundView addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.remarkBackgroundView).with.offset(8 * WIDTH_SCALE);
                    make.right.equalTo(cell.remarkBackgroundView).with.offset(-7 * WIDTH_SCALE);
                    make.top.equalTo(label1.mas_bottom).with.offset(9 * HEIGHT_SCALE);
                }];
                
                if(model.remarks.count == 2){
                    [label2 mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(cell.remarkBackgroundView).with.offset(-12 * HEIGHT_SCALE);
                    }];
                }else{
                    [cell.remarkBackgroundView addSubview:cell.moreButton];
                    [cell.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(label2.mas_bottom).with.offset(6 * HEIGHT_SCALE);
                        make.left.equalTo(label2);
                        make.bottom.equalTo(cell.remarkBackgroundView).with.offset(-8 * HEIGHT_SCALE);
                    }];
                }
            }
        }
        [cell.cardBackgroundView addSubview:cell.remarkBackgroundView];
    }

    if(![model.imgurl isEqualToString:@""]){//有图片
        
        [cell.cardBackgroundView addSubview:cell.contentImageView];
        [cell.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(94 * WIDTH_SCALE);
            make.height.mas_equalTo(80 * HEIGHT_SCALE);
            make.top.equalTo(cell.contentLabel.mas_bottom).with.offset(14.4 * HEIGHT_SCALE);
            make.left.equalTo(cell.contentLabel);
        }];
        
        [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.imgurl]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image){
                cell.contentImageView.image = image;
            }else{
                cell.contentImageView.image = [UIImage imageNamed:@"TempPicture"];
            }
        }];
        
        cell.contentImageView.userInteractionEnabled = YES;
        UIButton *maskButton = [[UIButton alloc] init];
        
        [maskButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            [[VMPictureDetailView shareInstance] setPictureDetailType:VMPictureDetailDownloadType];
            [VMPictureDetailView shareInstance].pictureImageView.image = cell.contentImageView.image;
            
            [[VMPictureDetailView shareInstance] showPictureDetail];

        }] forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentImageView addSubview:maskButton];
        [maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentImageView);
        }];
        
        
        if(model.remarks){//有图片有回复
            [cell.remarkBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentImageView.mas_bottom).with.offset(10 * HEIGHT_SCALE);
                make.bottom.equalTo(cell.cardBackgroundView).with.offset(-13 * HEIGHT_SCALE);
                make.left.equalTo(cell.cardBackgroundView).with.offset(10 * WIDTH_SCALE);
                make.right.equalTo(cell.cardBackgroundView).with.offset(-10 * WIDTH_SCALE);
            }];
        }else{//有图片无回复
            [cell.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.cardBackgroundView).with.offset(-20 * HEIGHT_SCALE);
            }];
        }
    }else{//没有图片
        if(model.remarks){
            [cell.remarkBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentLabel.mas_bottom).with.offset(10 * HEIGHT_SCALE);
                make.bottom.equalTo(cell.cardBackgroundView).with.offset(-13 * HEIGHT_SCALE);
                make.left.equalTo(cell.cardBackgroundView).with.offset(10 * WIDTH_SCALE);
                make.right.equalTo(cell.cardBackgroundView).with.offset(-10 * WIDTH_SCALE);
            }];
        }else{
            [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.cardBackgroundView).with.offset(-13 * HEIGHT_SCALE);
            }];
        }
    }
    
//    [cell.moreButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
//        VMCommentDetailController *vc = [[VMCommentDetailController alloc] init];
//        
//        [[[VMViewControllerManager sharedInstance] getNowViewController].navigationController pushViewController:vc animated:false];
//    }]forControlEvents:UIControlEventTouchUpInside];
}

+(void)configCommentDetailHostCell:(VMCommentHostCell *)cell
                         withModel:(VMVoteDetailCommentModel *)model{
    
    cell.createrNameLabel.text = model.name;
    cell.contentLabel.text = model.content;
    cell.timeLabel.text = [self timeExtractBBEnd:model.send_at];
    if(![model.imgurl isEqualToString:@""]){//有图片
        [cell.cardBackgroundView addSubview:cell.contentImageView];
        [cell.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentLabel.mas_bottom).with.offset(13 * HEIGHT_SCALE);
            make.bottom.equalTo(cell.cardBackgroundView).with.offset(-18 * HEIGHT_SCALE);
            make.left.equalTo(cell.contentLabel);
            make.width.mas_equalTo(93 * WIDTH_SCALE);
            make.height.mas_equalTo(80 * HEIGHT_SCALE);
        }];
        
        [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.imgurl]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image){
                cell.contentImageView.image = image;
            }else{
                cell.contentImageView.image = [UIImage imageNamed:@"TempPicture"];
            }
        }];
        
        cell.contentImageView.userInteractionEnabled = YES;
        UIButton *maskButton = [[UIButton alloc] init];
        
        [maskButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            [[VMPictureDetailView shareInstance] setPictureDetailType:VMPictureDetailDownloadType];
            [VMPictureDetailView shareInstance].pictureImageView.image = cell.contentImageView.image;
            
            [[VMPictureDetailView shareInstance] showPictureDetail];

        }] forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentImageView addSubview:maskButton];
        [maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentImageView);
        }];
        
    }else{
        [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.cardBackgroundView).with.offset(-12 * HEIGHT_SCALE);
        }];
    }
    
}

+(void)configCommentDetailfollowCell:(VMCommentCell *)cell
                           withModel:(VMVoteDetailCommentModel *)model{
    
    cell.contentLabel.text = [NSString stringWithFormat:@"%@ : %@", model.name, model.content];
    cell.timeLabel.text = [self timeExtractBBEnd:model.send_at];
}


+(void)configureNotificationCell:(VMNotificationCell *)cell model:(VMNotificationModel *)model{
    
    NSString *contentStr = model.content;
    //NSString *contentStr = @"20:adawd";
    NSString *numStr;
    
    if(model.msg_type == 0){
        cell.contentLabel.text = model.content;
    }
    
    if(model.msg_type == 1){
        bool flag = false;
        for(NSInteger i = 0; i < contentStr.length; i++){
            if([[contentStr substringWithRange:NSMakeRange(i,1)] isEqualToString:@":"]){
                numStr = [contentStr substringToIndex:i];
                contentStr = [contentStr substringFromIndex:i + 1];
                
                cell.vote_id = [numStr integerValue];
                cell.contentLabel.text = contentStr;
                flag = true;
                break;
            }
        }
//        if(!flag){
//            cell.contentLabel.text = model.content;
//        }
    }
    
    if(model.msg_type == 2 || model.msg_type == 3){
        for(NSInteger i = 0; i < contentStr.length; i++){
            if([[contentStr substringWithRange:NSMakeRange(i,1)] isEqualToString:@":"]){
                numStr = [contentStr substringToIndex:i];
                contentStr = [contentStr substringFromIndex:i + 1];
                
                cell.vote_id = [numStr integerValue];
                cell.contentLabel.text = contentStr;
                break;
            }
        }
    }
    


    cell.timeLabel.text = [VMCellConfigure timeExtractBBEnd:model.send_at];
    if(model.is_read){
        cell.redFlagView.hidden = true;
    }
    
    
}






+(NSString *)timeExtractNomal:(NSString *)timeStamp{
    NSString *specificDay = [timeStamp substringToIndex:10];
    NSString *specificMinute = [timeStamp substringWithRange:NSMakeRange(11, 8)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", specificDay, specificMinute]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *delta = [calendar components:unit fromDate:date toDate:[NSDate dateWithTimeIntervalSinceNow:-8 * 60 * 60] options:0];
    
    NSInteger year, month, day, hour, minute, second;
    year = delta.year;
    month = delta.month;
    day = delta.day;
    hour = delta.hour;
    minute = delta.minute;
    second = delta.second;
    
    
    
    if(delta.year >= 0 && delta.month >= 0 && delta.day >= 0 && delta.hour >= 0 && delta.minute >= 0 && delta.second >= 0){
        if (delta.year > 0 || delta.month >0 || delta.day >10){
            /*
            return [NSString stringWithFormat:@"%ld年前", (long)delta.year];
        }else if (delta.month > 0){
            return [NSString stringWithFormat:@"%ld月前", (long)delta.month];
        }else if (delta.day > 10){
            return [NSString stringWithFormat:@"%ld天前", (long)delta.day];
            */
            return [NSString stringWithFormat:@"%@",specificDay];
        }else if (delta.day > 0){
            return [NSString stringWithFormat:@"%ld天前", (long)delta.day];
        }else if (delta.hour > 0){
            return [NSString stringWithFormat:@"%ld小时前", (long)delta.hour];
        }else if (delta.minute > 0){
            return [NSString stringWithFormat:@"%ld分钟前", (long)delta.minute];
        }else{
            return @"刚刚更新";
        }
    }else if (delta.year < 0 || delta.month <0){
        return [NSString stringWithFormat:@"%@截止",specificDay];
    }else if (delta.day < 0){
        return [NSString stringWithFormat:@"%ld天截止", -1 * (long)delta.day];
    }else if (delta.hour < 0){
        return [NSString stringWithFormat:@"%ld小时截止", -1 * (long)delta.hour];
    }else if (delta.minute < 0){
        return [NSString stringWithFormat:@"%ld分钟截止", -1 * (long)delta.minute];
    }else{
        return @"即将截止";
    }
}
    

+(NSString *)timeExtractBBEnd:(NSString *)timeStamp{
    NSString *specificDay = [timeStamp substringToIndex:10];
    NSString *specificMinute = [timeStamp substringWithRange:NSMakeRange(11, 8)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", specificDay, specificMinute]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *delta = [calendar components:unit fromDate:date toDate:[NSDate dateWithTimeIntervalSinceNow:-8 * 60 * 60] options:0];
    
    NSInteger year, month, day, hour, minute, second;
    year = delta.year;
    month = delta.month;
    day = delta.day;
    hour = delta.hour;
    minute = delta.minute;
    second = delta.second;
    
    if(delta.year >= 0 && delta.month >= 0 && delta.day >= 0 && delta.hour >= 0 && delta.minute >= 0 && delta.second >= 0){
        if (delta.year > 0 || delta.month >0 || delta.day >10){
            /*
            return [NSString stringWithFormat:@"%ld年前", (long)delta.year];
        }else if (delta.month > 0){
            return [NSString stringWithFormat:@"%ld月前", (long)delta.month];
        }else if (delta.day > 10){
            return [NSString stringWithFormat:@"%ld天前", (long)delta.day];
            */
            return [NSString stringWithFormat:@"%@",specificDay];
        }else if (delta.day > 0){
            return [NSString stringWithFormat:@"%ld天前", (long)delta.day];
        }else if (delta.hour > 0){
            return [NSString stringWithFormat:@"%ld小时前", (long)delta.hour];
        }else if (delta.minute > 0){
            return [NSString stringWithFormat:@"%ld分钟前", (long)delta.minute];
        }else{
            return @"刚刚更新";
        }
    }else if (delta.year < 0 || delta.month <0){
        return [NSString stringWithFormat:@"%@截止",specificDay];
    }else if (delta.day < 0){
        return [NSString stringWithFormat:@"%ld天截止", -1 * (long)delta.day];
    }else if (delta.hour < 0){
        return [NSString stringWithFormat:@"%ld小时截止", -1 * (long)delta.hour];
    }else if (delta.minute < 0){
        return [NSString stringWithFormat:@"%ld分钟截止", -1 * (long)delta.minute];
    }else{
        return @"即将截止";
    }
}


@end

//
//  MemoListCell.h
//  memo_App
//
//  Created by kawaharadai on 2017/12/03.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Memo.h"

@interface MemoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void)setCellData:(Memo *)memoData;
@end

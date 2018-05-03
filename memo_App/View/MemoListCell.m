//
//  MemoListCell.m
//  memo_App
//
//  Created by kawaharadai on 2017/12/03.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "MemoListCell.h"
#import "NSDate+Style.h"

@implementation MemoListCell

- (void)setCellData:(Memo *)memoData {
    self.updateTimeLabel.text = [memoData.updateDate dateStyle];
    
    NSMutableArray<NSString *> *lines = [[memoData.text componentsSeparatedByString:@"\n"] mutableCopy];
    [lines removeObject:@""];
    
    if (lines.count > 0) {
        self.titleLabel.text = lines[0];
    } else {
        self.titleLabel.text = @"";
    }
    
    if (lines.count > 1) {
        self.contentLabel.text = lines[1];
    } else {
        self.contentLabel.text = @"";
    }
}

@end

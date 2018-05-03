//
//  MemoListProvider.m
//  memo_App
//
//  Created by kawaharadai on 2017/12/02.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "MemoListProvider.h"
#import "MemoListCell.h"
#import "DatabaseClient.h"

@implementation MemoListProvider

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.memoData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemoListCell" forIndexPath:indexPath];
    
    [cell setCellData:self.memoData[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {     
        __weak typeof(self) wself = self;
        if ([wself.delegate respondsToSelector:@selector(deleteData:)]) {
            [wself.delegate deleteData:indexPath];
        }
    }
    
}

@end

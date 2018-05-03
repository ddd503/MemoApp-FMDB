//
//  MemoListProvider.h
//  memo_App
//
//  Created by kawaharadai on 2017/12/02.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Memo.h"

@protocol MemoListProviderDelegate <NSObject>
- (void)deleteData:(NSIndexPath *)indexPath;
@end
@interface MemoListProvider : NSObject <UITableViewDataSource>
@property (nonatomic, weak) id<MemoListProviderDelegate> delegate;
@property (nonatomic) NSArray<Memo *> *memoData;
@end

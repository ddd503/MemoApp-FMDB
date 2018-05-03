//
//  Memo.m
//  memo_App
//
//  Created by kawaharadai on 2017/11/12.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "Memo.h"

@implementation Memo
- (instancetype)initWithFMResultSet:(FMResultSet *)results {
    self = [super init];
    if (self) {
        self.memoId = [results intForColumn:@"memoId"];
        self.updateDate = [results dateForColumn:@"updateDate"];
        self.text = [results stringForColumn:@"text"];
    }
    return self;
}
@end

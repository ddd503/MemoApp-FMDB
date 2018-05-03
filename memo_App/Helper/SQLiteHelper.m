//
//  SQLiteHelper.m
//  memo_App
//
//  Created by kawaharadai on 2017/11/12.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "SQLiteHelper.h"

@implementation SQLiteHelper

- (instancetype)init {
    self = [super init];
    if (self) {
        self.db = [[FMDatabase alloc] initWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"database.db"]];
        // ない場合は作る
        [self createMemoTable];
    }
    return self;
}

- (void)createMemoTable {
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS MEMO (memoId INTEGER PRIMARY KEY AUTOINCREMENT, updateDate DATE, text TEXT)";
    
    [self.db open];
    [self.db executeUpdate:sql];
    [self.db close];
}

@end

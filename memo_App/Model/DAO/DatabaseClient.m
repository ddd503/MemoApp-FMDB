//
//  DatabaseClient.m
//  memo_App
//
//  Created by kawaharadai on 2017/11/12.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "DatabaseClient.h"
#import <FMDB.h>
#import "SQLiteHelper.h"


@implementation DatabaseClient

// MARK: - INSERT

/**
 レコードを新規登録する
 @param memoObject 登録するMemoObject
 @return 成功 or 失敗
 */
+ (BOOL)insert:(Memo *)memoObject {
    
    memoObject.updateDate = [NSDate date];
    
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"INSERT INTO MEMO(updateDate, text) VALUES(?, ?)";
    
    BOOL result = NO;
    
    [sqliteHelper.db open];
    result = [sqliteHelper.db executeUpdate:sql withArgumentsInArray:@[memoObject.updateDate, memoObject.text]];
    [sqliteHelper.db close];
    return result;
}

// MARK: - UPDATE

/**
 レコードを更新する
 
 @param memoObject 更新するMemoObject
 @return 成功 or 失敗
 */
+ (BOOL)update:(Memo *)memoObject {
    
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"UPDATE MEMO SET updateDate = :UPDATEDATE, text = :TEXT WHERE memoId = :MEMOID";
    
    NSDictionary<NSString *, id> *params = @{@"UPDATEDATE": memoObject.updateDate,
                                             @"TEXT": memoObject.text,
                                             @"MEMOID": @(memoObject.memoId)};
    
    BOOL result = NO;
    
    [sqliteHelper.db open];
    result = [sqliteHelper.db executeUpdate:sql withParameterDictionary:params];
    [sqliteHelper.db close];
    return result;
}

// MARK: - SELECT

/**
 更新日の降順で全レコードを取得する
 
 @return Memoの配列
 */
+ (NSArray<Memo *> *)selectAll {
    
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"SELECT * FROM MEMO ORDER BY updateDate DESC";
    
    NSMutableArray<Memo *>* resultArray = [@[] mutableCopy];
    
    [sqliteHelper.db open];
    
    FMResultSet *results = [sqliteHelper.db executeQuery:sql];
    while ([results next]) {
        Memo *memoObject = [[Memo alloc] initWithFMResultSet:results];
        [resultArray addObject:memoObject];
    }
    
    [sqliteHelper.db close];
    return resultArray;
}

/**
 更新日を指定して、1件レコードを取得する
 
 @param date 取得するレコードの更新日
 @return MemoObject
 */
+ (Memo *)selectByUpdateDate:(NSDate *)date {
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"SELECT * FROM MEMO WHERE updateDate = ?";
    
    [sqliteHelper.db open];
    
    FMResultSet *results = [sqliteHelper.db executeQuery:sql withArgumentsInArray:@[date]];
    
    Memo *memoObject;
    while ([results next]) {
        memoObject = [[Memo alloc] initWithFMResultSet:results];
    }
    [sqliteHelper.db close];
    return memoObject;
}

// MARK: - DELETE

/**
 全レコードを削除する
 
 @return 成功 or 失敗
 */
+ (BOOL)deleteAll {
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"DELETE FROM MEMO";
    
    BOOL result = NO;
    
    [sqliteHelper.db open];
    result = [sqliteHelper.db executeUpdate:sql];
    [sqliteHelper.db close];
    return result;
}

/**
 memoIdを指定して、1件レコードを削除する
 
 @param memoId 削除するレコードのmemoId
 @return 成功 or 失敗
 */
+ (BOOL)deleteId:(NSInteger)memoId {
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"DELETE FROM MEMO WHERE memoId = ?";
    
    BOOL result = NO;
    
    [sqliteHelper.db open];
    result = [sqliteHelper.db executeUpdate:sql withArgumentsInArray:@[@(memoId)]];
    [sqliteHelper.db close];
    return result;
}

@end

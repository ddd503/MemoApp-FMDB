//
//  DatabaseClient.h
//  memo_App
//
//  Created by kawaharadai on 2017/11/12.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Memo.h"

@interface DatabaseClient : NSObject
+ (BOOL)insert:(Memo *)memoObject;
+ (BOOL)update:(Memo *)memoObject;
+ (NSArray<Memo *> *)selectAll;
+ (Memo *)selectByUpdateDate:(NSDate *)date;
+ (BOOL)deleteAll;
+ (BOOL)deleteId:(NSInteger)memoId;
@end

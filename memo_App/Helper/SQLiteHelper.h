//
//  SQLiteHelper.h
//  memo_App
//
//  Created by kawaharadai on 2017/11/12.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface SQLiteHelper : NSObject
@property (nonatomic) FMDatabase *db;
@end

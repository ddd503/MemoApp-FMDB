//
//  MemoListController.m
//  memo_App
//
//  Created by kawaharadai on 2017/11/12.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "MemoListController.h"
#import "DatabaseClient.h"
#import "Memo.h"
#import "MemoListProvider.h"
#import "MemoController.h"
#import "DatabaseClient.h"
#import "AlertHelper.h"

@interface MemoListController () <UITableViewDelegate, MemoListProviderDelegate, AlertHelperDelegate>
@property (weak, nonatomic) IBOutlet UITableView *memoList;
@property (weak, nonatomic) IBOutlet UILabel *memoCountLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *memoControllButton;
@property (nonatomic) DatabaseClient *databaseClient;
@property (nonatomic) MemoListProvider *provider;
@property (nonatomic) AlertHelper *alertHelper;
@property (nonatomic) BOOL isEditing;
@end

static CGFloat const CellHeight = 70;

@implementation MemoListController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.databaseClient = [DatabaseClient new];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createDataSource];
}

#pragma mark - SetUp Methods
- (void)setup {
    [self setupTableView];
    [self setupAlertHelper];
    [self createDataSource];
}

- (void)setupTableView {
    self.provider = [MemoListProvider new];
    self.provider.delegate = self;
    self.memoList.dataSource = self.provider;
    self.memoList.delegate = self;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setupAlertHelper {
    self.alertHelper = [AlertHelper new];
    self.alertHelper.delegate = self;
}

#pragma mark - Private Methods
- (void)createDataSource {
    self.provider.memoData = [DatabaseClient selectAll];
    [self updateMemoCount];
    [self switchSeparator];
    [self.memoList reloadData];
}

- (void)updateMemoCount {
    if (self.provider.memoData.count == 0) {
        self.memoCountLabel.text = @"メモなし";
    } else {
        self.memoCountLabel.text = [NSString stringWithFormat:@"%lu件のメモ",
                                    (unsigned long)self.provider.memoData.count];
    }
}

- (void)transitionMemo:(Memo *)setMemoData {
    UIStoryboard *memoStoryboard = [UIStoryboard storyboardWithName:@"Memo" bundle:nil];
    MemoController *memoController = [memoStoryboard instantiateInitialViewController];
    memoController.memoData = setMemoData;
    [self.navigationController pushViewController:memoController animated:YES];
}

- (void)setBarTitle:(BOOL)isEditing {
    if (isEditing) {
        [self.memoControllButton setTitle:@"すべて削除"];
    } else {
        [self.memoControllButton setTitle:@"メモ追加"];
    }
}

- (void)outputActionSheet {
    UIAlertController *actionSheet = [self.alertHelper createAllDeleteActionSheet:@"すべて削除"
                                                                cancelButtonTitle:@"キャンセル"];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

// テーブルビューのセパレート状態を変更
- (void)switchSeparator {
    if (self.provider.memoData.count == 0) {
        self.memoList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.memoList.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

#pragma mark - MemoListProviderDelegate Methods
- (void)deleteData:(NSIndexPath *)indexPath {
    [DatabaseClient deleteId:self.provider.memoData[indexPath.row].memoId];
    
    self.provider.memoData = [DatabaseClient selectAll];
    [self updateMemoCount];
    [self switchSeparator];
    [self.memoList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - AlertHelperDelegate Methods
- (void)allDelete {
    [DatabaseClient deleteAll];
    [self createDataSource];
}

#pragma mark - UITableViewDelegate Methods
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    self.isEditing = editing;
    [self setBarTitle:editing];
    self.memoList.editing = editing;
}

// セルの高さ
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

// セル選択時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self transitionMemo:self.provider.memoData[indexPath.row]];
}

#pragma mark - ButtonAction Methods
- (IBAction)memoControll:(id)sender {
    if (self.isEditing) {
        [self outputActionSheet];
    } else {
        [self transitionMemo:nil];
    }
}

@end

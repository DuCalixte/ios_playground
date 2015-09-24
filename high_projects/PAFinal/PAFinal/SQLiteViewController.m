//
//  SQLiteViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "SQLiteViewController.h"

@interface SQLiteViewController ()

@end

@implementation SQLiteViewController
{
    sqlite3 *db;
}

- (void) displayAlert:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!!!" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void) createDataBase
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/db"];
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK){
        [self displayAlert:@"Connection has failed!!!"];
        return;
    }
    
    char* sql = "CREATE TABLE IF NOT EXISTS documents "
    "(document_id INTEGER PRIMARY KEY, document TEXT)";
    char *err_msg;
    if ( sqlite3_exec(db, sql,  NULL, NULL, &err_msg ) != SQLITE_OK)
    {
        [self displayAlert:[NSString stringWithUTF8String:err_msg]];
        db = NULL;
        return ;
    }
}

- (void) insertIntoDataBase
{
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO documents "
                        "VALUES(NULL,'%@')", self.textContent.text];
    char *err_msg;
    if (sqlite3_exec(db, [insert UTF8String], NULL, NULL, &err_msg) != SQLITE_OK){
        [self displayAlert:[NSString stringWithUTF8String:err_msg]];
        sqlite3_free(err_msg);
    }
}

- (void) loadLastRecordFromDataBase
{
//    NSInteger lastRowId = sqlite3_last_insert_rowid(db);
    char *sql = "SELECT * FROM documents WHERE document_id = (SELECT MAX(document_id) FROM documents)";
    sqlite3_stmt *stmt;
    
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK){
        [self displayAlert:@"Prepartion has failed!!!"];
        return;
    }
    
    NSMutableString *result = [[NSMutableString alloc] init];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        [result appendFormat:@"%s", sqlite3_column_text(stmt, 1)];
    }
    
    self.textContent.text = result;
    
    sqlite3_finalize(stmt);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self loadLastRecordFromDataBase];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self insertIntoDataBase];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SQLite";
    
    [self createDataBase];
    
    self.splitViewController.delegate = self;
    [self.textContent becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

@end


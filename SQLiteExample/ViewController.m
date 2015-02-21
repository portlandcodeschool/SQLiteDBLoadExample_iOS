//
//  ViewController.m
//  SQLiteExample
//
//  Created by Erick Bennett on 2/19/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import "ViewController.h"
#import "Author.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", [self authorList]);
}

-(NSMutableArray *) authorList {
    
    NSMutableArray *theauthors = [[NSMutableArray alloc] initWithCapacity:10];
    sqlite3_stmt *sqlStatement;

    @try {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"AuthorsDB.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
            
        }

        const char *sql = "SELECT * FROM  books";
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
        }else{
            
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                Author * author = [[Author alloc] init];
                author.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                author.title = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                author.genre = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
                [theauthors addObject:author];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        sqlite3_close(db);
        
        return theauthors;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

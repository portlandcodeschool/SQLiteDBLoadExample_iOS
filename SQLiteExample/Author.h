//
//  Author.h
//  SQLiteExample
//
//  Created by Erick Bennett on 2/19/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject {
    
    NSString *name;
    NSString *title;
    NSString *genre;
}

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *genre;
@end

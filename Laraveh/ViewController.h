//
//  ViewController.h
//  Laraveh
//
//  Created by Damian Balandowski on 20.06.2015.
//  Copyright (c) 2015 DamianPrg. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController<NSTableViewDelegate, NSTableViewDataSource>

// laravel's project path where app, resources folder, etc... are.
@property NSString* projectPath;

- (void)runCommand:(NSString *)commandToRun;

// execute artisan command example: make:controller
-(void) executeCommand:(NSString*)command;

// migration arrays
@property NSMutableArray* namesArray;
@property NSMutableArray* typesArray;

@property (strong) IBOutlet NSTextView *commandResult;
@property (strong) IBOutlet NSComboBox *typeComboBox;
@property (strong) IBOutlet NSTextField *makeNameTextField;
@property (strong) IBOutlet NSTextField *namespaceTextField;
@property (weak) IBOutlet NSTableView *migrationTableView;
@property (weak) IBOutlet NSTextField *migrationColumnName;
@property (weak) IBOutlet NSComboBox *migrationColumnType;

@end


//
//  ViewController.m
//  Laraveh
//
//  Created by Damian Balandowski on 20.06.2015.
//  Copyright (c) 2015 DamianPrg. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:NO];
    [panel setCanSelectHiddenExtension:YES];
    [panel setCanChooseFiles:NO];
    [panel setTitle:@"Select your laravel app root folder (where app and other folders are)"];

    if([panel runModal] != NSFileHandlingPanelCancelButton)
    {
        self.projectPath = [[panel URL] absoluteString];

        NSString * fixedPath = [self.projectPath mutableCopy];
        fixedPath = [fixedPath substringFromIndex:7];

        self.projectPath = fixedPath;
    }
    else
    {
        self.projectPath = @"Path not set";
    }
}

-(void)viewDidAppear {

    if([self.projectPath isEqualToString:@"Path not set"])
    {
        [NSApp terminate:nil];
    }

    [self.view.window setTitle:[NSString stringWithFormat:@"Artison - (%@)", self.projectPath]];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

-(void) executeCommand:(NSString*)command {

    NSString* artisanCMDpath = [NSString stringWithFormat:@"php %@/artisan %@", self.projectPath, command];

    [self runCommand:artisanCMDpath];
}

- (void)runCommand:(NSString *)commandToRun
{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];

    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c" ,
                          [NSString stringWithFormat:@"%@", commandToRun],
                          nil];
    [task setArguments:arguments];

    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];

    NSFileHandle *file = [pipe fileHandleForReading];

    [task launch];

    NSData *data = [file readDataToEndOfFile];

    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSString* newCommandStr = [NSString stringWithFormat:@"%@%@", self.commandResult.string, output];

    [self.commandResult setString:newCommandStr];


    [self.commandResult scrollLineDown:self];
}
- (IBAction)makeController:(id)sender {

    NSString* selectedOptionValue = (NSString*)[[self.typeComboBox objectValueOfSelectedItem] lowercaseString];

    NSString* name        = self.makeNameTextField.stringValue;
    NSString* makeCommand = [NSString stringWithFormat:@"make:%@ %@", selectedOptionValue, name];

    // NSLog(makeCommand);

    [self executeCommand:makeCommand];

}
- (IBAction)coreServe:(id)sender {
    [self executeCommand:@"serve"];
}
- (IBAction)coreMigrate:(id)sender {
    [self executeCommand:@"migrate"];
}
- (IBAction)coreOptimize:(id)sender {
    [self executeCommand:@"optimize"];
}
- (IBAction)coreGenerateKey:(id)sender {
    [self executeCommand:@"key:generate"];
}
- (IBAction)coreUp:(id)sender {
    [self executeCommand:@"up"];
}
- (IBAction)coreDown:(id)sender {
    [self executeCommand:@"down"];
}
- (IBAction)coreClearCompiledViews:(id)sender {
     [self executeCommand:@"view:clear"];
}
- (IBAction)coreRunScheduledCommands:(id)sender {
    [self executeCommand:@"schedule:run"];
}
- (IBAction)coreCreateRouteCacheFile:(id)sender {
     [self executeCommand:@"route:cache"];
}
- (IBAction)coreRemoveRouteCache:(id)sender {
    [self executeCommand:@"route:clear"];
}
- (IBAction)coreSeedDatabase:(id)sender {
     [self executeCommand:@"db:seed"];
}
- (IBAction)coreClearCache:(id)sender {
    [self executeCommand:@"cache:clear"];
}
- (IBAction)migrateInstall:(id)sender {
    [self executeCommand:@"migrate:install"];
}
- (IBAction)migrateRefresh:(id)sender {
    [self executeCommand:@"migrate:refresh"];
}
- (IBAction)migrateReset:(id)sender {
    [self executeCommand:@"migrate:reset"];
}
- (IBAction)migrateRollback:(id)sender {
    [self executeCommand:@"migrate:rollback"];
}
- (IBAction)migrateStatusList:(id)sender {
    [self executeCommand:@"migrate:status"];
}
- (IBAction)coreChangeNamespace:(id)sender {

    NSString* newNamespace = [self.namespaceTextField stringValue];

    [self executeCommand:[NSString stringWithFormat:@"app:name %@", newNamespace]];

}

@end

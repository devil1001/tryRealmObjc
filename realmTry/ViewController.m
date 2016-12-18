//
//  ViewController.m
//  realmTry
//
//  Created by devil1001 on 19.12.16.
//  Copyright © 2016 devil1001. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>

@interface DialogHistory : RLMObject
@property NSString *dialogHistory;
@property NSString *user;
@end

@interface DialogsBase : RLMObject
@property NSString *dialogsDate;
@end

@implementation DialogsBase
@end
@implementation DialogHistory
+ (NSString *) primaryKey {
    return @"user";
}
@end

@interface ViewController ()
@property (weak,nonatomic)IBOutlet UITextField *first;
@property (weak, nonatomic) IBOutlet UITextField *second;
@property (nonatomic) NSInteger i;
@property (weak, nonatomic) IBOutlet UITextView *result;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _i = 0;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickedButton:(id)sender {
    DialogsBase *dibase = [[DialogsBase alloc] initWithValue:@{@"dialogsDate" : _first.text}];
    DialogHistory *history = [[DialogHistory alloc]init];
    history.user = [NSString stringWithFormat:@"%ld",_i];
    history.dialogHistory = _second.text;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:dibase];
    [DialogHistory createOrUpdateInRealm:realm withValue:history];
    //[realm addObject:history];
    [realm commitWriteTransaction];
    _i++;
    RLMResults<DialogHistory *> *dialog = [DialogHistory allObjects];
    //dialog.
    //[_result setText:[DialogHistory allObjects]];
    NSLog(@"%@",[DialogHistory allObjects]);
}


- (IBAction)search:(id)sender {
    RLMResults *dialogs;
    NSString *j = @"5";
    
    // Запрос при помощи NSPredicate
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"user = %@",j];
    dialogs = [DialogHistory objectsWithPredicate:pred];
    [_result setText:[[dialogs firstObject] valueForKey:@"dialogHistory"]];
}

@end

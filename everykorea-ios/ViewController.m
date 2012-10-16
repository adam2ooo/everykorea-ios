//
//  ViewController.m
//  everykorea-ios
//
//  Created by cetauri on 12. 10. 16..
//  Copyright (c) 2012년 everykorea. All rights reserved.
//

#import "ViewController.h"
#import "NoticeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstButton setTitle:@"first" forState:UIControlStateNormal];
        [firstButton addTarget:self action:@selector(firstMenuPressed) forControlEvents:UIControlEventTouchUpInside];
        firstButton.backgroundColor = [UIColor grayColor];
        firstButton.frame = CGRectMake(0, self.view.frame.size.height - (40 * 3), self.view.frame.size.width, 40);
        [self.view addSubview:firstButton];
        
        UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondButton setTitle:@"second" forState:UIControlStateNormal];
        [secondButton addTarget:self action:@selector(secondMenuPressed) forControlEvents:UIControlEventTouchUpInside];
        secondButton.backgroundColor = [UIColor lightGrayColor];
        secondButton.frame = CGRectMake(0, self.view.frame.size.height - (40 * 2), self.view.frame.size.width, 40);
        [self.view addSubview:secondButton];
        
        
        UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [thirdButton setTitle:@"third" forState:UIControlStateNormal];
        [thirdButton addTarget:self action:@selector(thirdMenuPressed) forControlEvents:UIControlEventTouchUpInside];
        thirdButton.backgroundColor = [UIColor grayColor];
        thirdButton.frame = CGRectMake(0, self.view.frame.size.height - (40 * 1), self.view.frame.size.width, 40);
        [self.view addSubview:thirdButton];
    }
    return self;
}

- (void)firstMenuPressed
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NoticeViewController *noticeViewController = [[NoticeViewController alloc]init];
    [self.navigationController pushViewController:noticeViewController animated:YES];
}

- (void)secondMenuPressed
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)thirdMenuPressed
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
@end

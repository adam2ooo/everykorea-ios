//
//  NoticeViewController.m
//  everykorea-ios
//
//  Created by cetauri on 12. 10. 17..
//  Copyright (c) 2012년 everykorea. All rights reserved.
//

#import "NoticeViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
@interface NoticeViewController (){
    UITableView *_tableView;
    NSMutableArray *array;
    UIActivityIndicatorView *_indicatorView;
}
@end

@implementation NoticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        array = [NSMutableArray array];
        
        CGRect frame = self.view.frame;
        frame.size.height -= 44;
        
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.userInteractionEnabled = NO;
        [self.view addSubview:_tableView];
        
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.color = [UIColor darkGrayColor];
        _indicatorView.center = _tableView.center;
        [_indicatorView startAnimating];
        [self.view addSubview:_indicatorView];
        
        self.title = @"Notice";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //http://reysion.tistory.com/15
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack; //스타일 적용
    self.navigationController.navigationBar.translucent = NO; // 반투명 효과 주기
    
    [self getLatestList];
}

-(void)getLatestList{
    NSURL *nurl = [NSURL URLWithString:@"http://www.everykorea.com/app_api/"];
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:nurl];
    NSMutableURLRequest *request =[httpClient requestWithMethod:@"GET" path:@"notice.asp" parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){

        NSDictionary *response = [operation.responseString objectFromJSONString];
        array = [response objectForKey:@"notices"];
        [_tableView reloadData];
        
        [_indicatorView removeFromSuperview];
        _tableView.userInteractionEnabled = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"에러가 발생하였습니다.\n다시 시도해주세요." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        NSLog(@"error.localizedDescription : %@", error.localizedDescription);
    }];
    
    [operation start];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"noticeCell";
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(tableViewCell == nil){
        tableViewCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    NSDictionary *dictionary = [array objectAtIndex:indexPath.row];
    tableViewCell.textLabel.text = [dictionary objectForKey:@"subject"];
    return tableViewCell;
}


@end

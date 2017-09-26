//
//  ViewController.m
//  Mi Primera Tabla
//
//  Created by Walter Gonzalez Domenzain on 20/09/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "Home.h"
#import "cellMainTable.h"
#import "NewPersonViewController.h"
#import "DetailViewController.h"

@interface Home () <NewPersonDelegate>
@property NSMutableArray *personData;
@end

@implementation Home
/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initController];
}
//-------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------------------------------------------------------
- (void)initController {
    self.personData = [[NSMutableArray alloc]init];
    [self.personData addObject:@{
                                 @"name" :  @"Tyrion Lannister",
                                 @"age" : @"38 años",
                                 @"image" :  [UIImage imageNamed:@"tyrion.jpg"],
                                 @"description": @""
                                 }];
    [self.personData addObject: @{
                                  @"name" :  @"Daenerys Targaryen",
                                  @"age" : @"22 años",
                                  @"image" :  [UIImage imageNamed:@"daenerys.jpeg"],
                                  @"description": @""
                                  }];
    [self.personData addObject: @{
                                  @"name" :  @"Jon Snow",
                                  @"age" : @"25 años",
                                  @"image" :  [UIImage imageNamed:@"jon.jpg"],
                                  @"description": @""
                                  }];
    [self.personData addObject: @{
                                  @"name" :  @"Arya Stark",
                                  @"age" : @"16 años",
                                  @"image" :  [UIImage imageNamed:@"arya.jpg"],
                                  @"description": @""
                                  }];
    [self.personData addObject:@{
                                 @"name" :  @"Cersei Lannister",
                                 @"age" : @"42 años",
                                 @"image" :  [UIImage imageNamed:@"cersei.jpg"],
                                 @"description": @""
                                 }];
}

/**********************************************************************************************/
#pragma mark - Table source and delegate methods
/**********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.personData.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Initialize cells
    cellMainTable *cell = (cellMainTable *)[tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"cellMainTable" bundle:nil] forCellReuseIdentifier:@"cellMainTable"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    }
    NSDictionary *current = self.personData[indexPath.row];
    //Fill cell with info from arrays
    cell.lblName.text       =  current[@"name"];
    cell.lblAge.text        =  current[@"age"];
    cell.imgUser.image      =  current[@"image"];
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tblMain deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *current = self.personData[indexPath.row];
    [self performSegueWithIdentifier:@"toShowDetail" sender:current];
}
/**********************************************************************************************/
#pragma mark - Action methods
/**********************************************************************************************/
- (IBAction)btnAddPressed:(id)sender {
    /**
    [self.userNames addObject:@"Walter"];
    [self.userAges addObject:@"37 años"];
    [self.userImages addObject:@"jon.jpg"];
    [self.tblMain reloadData];
     */
    [self performSegueWithIdentifier:@"toAddNewPerson" sender:nil];
}

#pragma mark - NewPersonDelegate

- (void)didAddPersonName:(NSString *)name andImageSelected:(UIImage *)image {
    NSLog(@"%@",name);
    [self.personData addObject:@{
                                 @"name" :  name,
                                 @"age" : @"",
                                 @"imaage" :  image,
                                 @"description": @""
                                 }];
    [self.tblMain reloadData];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toAddNewPerson"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        NewPersonViewController *personVC = [[navigationController viewControllers]firstObject];
        personVC.delegate = self;
    } else if ([segue.identifier isEqualToString:@"toShowDetail"]) {
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.person = sender;
    }
}


@end

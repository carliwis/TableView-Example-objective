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

@interface Home () <NewPersonDelegate>
@property NSMutableArray *userNames;
@property NSMutableArray *userAges;
@property NSMutableArray *userImages;
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
    self.userNames  = [[NSMutableArray alloc] initWithObjects: @"Tyrion Lannister", @"Daenerys Targaryen", @"Jon Snow", @"Arya Stark", @"Cersei Lannister", nil];
    
    self.userAges  = [[NSMutableArray alloc] initWithObjects: @"38 años", @"22 años", @"25 años", @"16 años", @"42 años", nil];

    self.userImages = [[NSMutableArray alloc] initWithObjects: [UIImage imageNamed:@"tyrion.jpg"], [UIImage imageNamed:@"daenerys.jpeg"], [UIImage imageNamed:@"jon.jpg"], [UIImage imageNamed:@"arya.jpg"], [UIImage imageNamed:@"cersei.jpg"], nil];
}

/**********************************************************************************************/
#pragma mark - Table source and delegate methods
/**********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userNames.count;
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
    //Fill cell with info from arrays
    cell.lblName.text       = self.userNames[indexPath.row];
    cell.lblAge.text        = self.userAges[indexPath.row];
    cell.imgUser.image      = self.userImages[indexPath.row];
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Pending
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
    [self.userNames addObject:name];
    [self.userAges addObject:@""];
    [self.userImages addObject:image];
    [self.tblMain reloadData];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toAddNewPerson"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        NewPersonViewController *personVC = [[navigationController viewControllers]firstObject];
        personVC.delegate = self;
    }
}


@end

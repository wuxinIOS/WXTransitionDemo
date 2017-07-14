//
//  WXMagicMoveController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/14.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXMagicMoveController.h"

#import "WXMagicMovePushController.h"

#define space 10

@interface WXMagicMoveController ()<UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@end

@implementation WXMagicMoveController

static NSString * const reuseIdentifier = @"Cell";

- (void)dealloc{
    NSLog(@"释放了");
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    
    self = [super initWithCollectionViewLayout:layout];
    self.layout = layout;
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;
    
    // Do any additional setup after loading the view.
}


- (void)backToRoot
{
    self.navigationController.delegate = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:10];
    if (imgView) {
        
    } else {
        imgView = [[UIImageView alloc]initWithFrame:cell.bounds];
        imgView.tag = 10;
        [cell addSubview:imgView];
    }
    imgView.image = [UIImage imageNamed:@"5355d3ccc22dd.jpg"];
    
    
    //cell.backgroundColor = [UIColor redColor];
    
    return cell;
}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (self.view.bounds.size.width - 3 * space) / 2;
    CGFloat height = width;
    CGSize size = CGSizeMake(width, height);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return space;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return space;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.currentIndexPath = indexPath;
    WXMagicMovePushController *pushVc = [WXMagicMovePushController new];
    self.navigationController.delegate = pushVc;
    [self.navigationController pushViewController:pushVc animated:YES];
}



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

<?php
namespace backend\controllers;

use Yii;
use yii\web\Controller;
use yii\filters\VerbFilter;
use yii\filters\AccessControl;

use backend\models\Car;
use backend\models\User;
use backend\models\Payment;
use backend\models\PaymentType;

/**
 * Site controller
 */
class CarsController extends RentCarsController{
  public function behaviors(){
    return [
          'access' => [
              'class' => AccessControl::className(),
              'rules' => [
                  [    // all the action are accessible to superadmin, admin and manager
                      'allow' => true,  
                      'roles' => ['admin', 'manager', 'cars_owner'],
                  ],   
//                   [
//                       'deny',
//                       'users'=>array('?'),
//                  ],
              ],
          ],        
          /*'verbs' => [
              'class' => VerbFilter::className(),
              'actions' => [
                  'delete' => ['post'],
              ],
          ],*/
      ];
  }
  
  /**
     * Displays cars
     *
     * @return string
     */
    public function actionIndex(){
      $number = (int)Yii::$app->getRequest()->getQueryParam('number');
      $page = Yii::$app->getRequest()->getQueryParam('page') ? Yii::$app->getRequest()->getQueryParam('page') : 1;
      $count = 20;
      
      $where = $this->createWhere($number);
      $cars = Car::find()->where($where)->offset(($page-1)*$count)->limit($count);
       
      $message = Yii::$app->session->getFlash('message');
      return $this->render('index.tpl', ['cars'=>$cars, 
                                         'number'=>$number, 
                                         'message'=>$message, 
                                         'page'=>$page]);
    }
    
    public function actionAdd(){
      $car = new Car();
      return $this->render('edit.tpl', ['car'=>$car]);
    }
    
    
    public function actionEdit(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $car = Car::findOne(['id'=>$id]);
      
      return $this->render('edit.tpl', ['car'=>$car]);
    }
    
    
    public function actionView(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $car = Car::findOne(['id'=>$id]);
      
      return $this->render('view.tpl', ['car'=>$car]);
    }
    
    /**
     * Save car data
     */
    public function actionSave(){
      $post = Yii::$app->getRequest()->post();
      $action = $post['action'];
      $id = (int)$post['id'];

      $car = Car::findOne(['id'=>$id]);
      if (!$car)
        $car = new Car();
      
      switch ($action){
        case 'save':
          $car->mark = trim(ucfirst(strtolower($post['mark'])));
          $car->model = trim(ucfirst(strtolower($post['model'])));
          $car->color = trim(ucfirst(strtolower($post['color'])));
          $car->number = trim($post['number']);
          $car->mileage = (int)$post['mileage'];
          $car->year = (int)$post['year'];
          $car->status = (int)$post['status'];
          
          if ($car->save()){
            Yii::$app->getSession()->setFlash('message', 'Car saved successfully.');
            return $this->redirect('/cars');
          }else{
            //Yii::$app->getSession()->setFlash('message', 'Error save car:'.$car->getErrors());
          }
          
          break;
        case 'delete':
          $car->status = Car::STATUS_DELETED;
          $car->save();
          
          Yii::$app->getSession()->setFlash('message', 'Car deleted.');
          // do down
        default:
          return $this->redirect('/cars');
      }
    }
    
    public function actionPayRent(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $car = Car::findOne(['id'=>$id]);
      
      if (!Yii::$app->getRequest()->isPost){
        return $this->render('pay_rent.tpl', ['car'=>$car]);
      }
      
      $post = Yii::$app->getRequest()->post();
      // save payment
      $payment = new Payment(['car_id'      => $car->id, 
                              'user_id'     => Yii::$app->user->id,
                              'creator_id'  => Yii::$app->user->id,
                              'category_id' => 1, // Pay rent car owner
                              'type_id'     => PaymentType::OUTGOING,
                              'date'        => date('Y-m-d', strtotime($post['start_lease'])),
                              'date_stop'   => date('Y-m-d', strtotime($post['stop_lease'])),
                              'date_create' => date('Y-m-d H:i:s', time()),
                              'thb'       => (int)$post['price'],
                              'status'      => Payment::STATUS_CONFIRMED]
                            );
      $payment->save();
      
      // update Car record
      $car->last_payment_id = $payment->id;
      $car->save();
      
      return $this->redirect('/cars');
    }
    
    /**
     * 
     */
    public function actionPayments() {
      $id = Yii::$app->getRequest()->getQueryParam('id');
      
      $where = ['id'=>$id];
      if (Yii::$app->user->identity->type_id == User::ROLE_CARS_OWNER) {
        $where['owner_id'] = Yii::$app->user->id;
      }
      
      $car = Car::findOne($where);
      $payments = [];
      if ($car) {
        $payments = Payment::find(['car_id'=>$car->id, 'category_id'=>  1])->orderBy(['date'=>'DESC']);// 1 =Pay rent car owner
      }
        
      
      return $this->render('payments.tpl', ['car'     => $car,
                                            'payments'=> $payments]);
    }
    /**
     * 
     * @param
     * @return 
    */
    protected function createWhere($number) {
      $res = ' AND status!=10';
      
      //print_r(Yii::$app->user);
      //die();
      
      if ($number)
        $res .= " AND number LIKE '%".$number."%'";
      if (Yii::$app->user->identity->type_id == User::ROLE_CARS_OWNER)
        $res .= ' AND owner_id='.Yii::$app->user->id;
      
      return substr($res, 5);
    } 
    
}
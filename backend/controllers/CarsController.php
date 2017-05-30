<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;

use backend\models\Car;
use backend\models\User;
use backend\models\Payment;
use backend\models\PaymentType;
use yii\helpers\ArrayHelper;
use backend\classes\rcPaginator;
use yii\helpers\Url;

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
                      'roles' => ['admin', 'manager'],
                  ],   
                   
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
      $params['number'] = (int)Yii::$app->getRequest()->getQueryParam('number');
      $params['owner_id'] = (int)Yii::$app->getRequest()->getQueryParam('owner_id');
      $params['status'] = (int)Yii::$app->getRequest()->getQueryParam('status');
      $params['page'] = Yii::$app->getRequest()->getQueryParam('page') ? Yii::$app->getRequest()->getQueryParam('page') : 1;
      $count = 40;
      
      $where = $this->createWhere($params);
      $cars = Car::find()->where($where)
                          ->offset(($params['page']-1)*$count)
                          ->limit($count);
      
      $all_records = Car::find()->where($where)->count();
      $pages = ceil($all_records / $count);
      
      $owners = User::find()->where(['type_id'=>User::ROLE_CARS_OWNER])->indexBy('id')->all();
      $arr_owners = ArrayHelper::map($owners, 'id', 'name');
      
      $paginator = new rcPaginator(['pages'=>$pages, 
                                    'current'=>$params['page'], 
                                   ]);
      $message = Yii::$app->session->getFlash('message');
      return $this->render('index.tpl', ['cars'=>$cars, 
                                         'owners'=>$owners, 
                                         'statuses'=>Car::$statuses, 
                                         'params'=>$params, 
                                         'all_records'=>$all_records, 
                                         'paginator'=>$paginator, 
                                         'arr_owners'=>$arr_owners, 
                                         'message'=>$message]);
    }
    
    public function actionAdd(){
      $car = new Car();
      return $this->render('edit.tpl', ['car'=>$car]);
    }
    
    
    public function actionEdit(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $car = Car::findOne(['id'=>$id]);
      $owners = ArrayHelper::map(User::find()->where(['type_id'=>User::ROLE_CARS_OWNER])->all(), 'id', 'name');
      
      return $this->render('edit.tpl', ['car'=>$car, 'owners'=>$owners]);
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
          $car->owner_id = (int)$post['owner_id'];
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
     * @param [number, owner_id, status]
     * @return 
    */
    protected function createWhere($params) {
      $res = ' AND status!=10';
      
      if ($params['number'])
        $res .= " AND number LIKE '%".$params['number']."%'";
      if ($params['owner_id'])
        $res .= " AND owner_id = ".$params['owner_id'];
      if ($params['status'])
        $res .= " AND status = ".$params['status'];
      
      /*if (!Yii::$app->user->isGuest) { // HUCK - TODO find solution
        if (Yii::$app->user->identity->type_id == User::ROLE_CARS_OWNER)
          $res .= ' AND owner_id='.Yii::$app->user->id;
      }*/
      
      return substr($res, 5);
    } 
    
}
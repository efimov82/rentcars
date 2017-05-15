<?php
namespace backend\controllers;

use Yii;
use yii\web\Controller;
use yii\filters\VerbFilter;
use yii\filters\AccessControl;
use common\models\LoginForm;

use backend\models\Car;
use backend\models\Payment;

/**
 * Site controller
 */
class CarsController extends RentCarsController
{
  public function behaviors()
  {
    return [
          'access' => [
              'class' => AccessControl::className(),
              'rules' => [
                  [    // all the action are accessible to superadmin, admin and manager
                      'allow' => true,  
                      'roles' => ['admin', 'manager'],
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
    public function actionIndex()
    {
      $number = (int)Yii::$app->getRequest()->getQueryParam('number');
      $page = Yii::$app->getRequest()->getQueryParam('page') ? Yii::$app->getRequest()->getQueryParam('page') : 1;
      $count = 20;
      if ($number)
        //$cars = Car::find()->where('AND', ['LIKE', 'number', $number], 'status=1')->offset(($page-1)*$count)->limit($count);
        //['and', 'type=1', ['or', 'id=1', 'id=2']]
        $cars = Car::find()->where(['AND', 'status!=10', ['LIKE', 'number', $number]])->offset(($page-1)*$count)->limit($count);
        //$cars = Car::find()->where(['LIKE', 'number', $number])->offset(($page-1)*$count)->limit($count);
      else
        $cars = Car::find()->where('status!=10')->offset(($page-1)*$count)->limit($count);
        
      $message = Yii::$app->session->getFlash('message');
      return $this->render('index.tpl', ['cars'=>$cars, 
                                         'number'=>$number, 
                                         'message'=>$message, 
                                         'page'=>$page]);
    }
    
    public function actionAdd()
    {
      $car = new Car();
      
      return $this->render('edit.tpl', ['car'=>$car]);
    }
    
    public function actionEdit()
    {
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $car = Car::findOne(['id'=>$id]);
      
      return $this->render('edit.tpl', ['car'=>$car]);
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
      
      switch ($action)
      {
        case 'save':
          $car->mark = trim(ucfirst(strtolower($post['mark'])));
          $car->model = trim(ucfirst(strtolower($post['model'])));
          $car->color = trim(strtolower($post['color']));
          $car->number = trim($post['number']);
          $car->mileage = (int)$post['mileage'];
          $car->start_lease = date('Y-m-d', strtotime($post['start_lease']));
          $car->paid_up_to = date('Y-m-d', strtotime($post['paid_up_to']));
          $car->price = (int)$post['price'];
          $car->year = (int)$post['year'];
          $car->status = (int)$post['status'];
          //$car->description = $post['description'];
          if ($car->save())
          {
            Yii::$app->getSession()->setFlash('message', 'Car saved successfully.');
            return $this->redirect('/cars');
          }
          else 
          {
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
    
    public function actionAddPayment()
    {
      $car_id = Yii::$app->getRequest()->getQueryParam('car_id');
      $payment_id = Yii::$app->getRequest()->getQueryParam('payment_id');
      
      $car = Car::findOne(['id'=>$car_id]);
      if (!$car)
        return $this->redirect('/cars');
      
      $payment = CarPayment::findOne(['id'=>$payment_id, 'car_id'=>$car_id]);
      if (!$payment)
        $payment = new CarPayment(['car_id'=>$car_id]);
      
      return $this->render('edit_payment.tpl', ['car'=>$car, 'payment'=>$payment]);
    }
    
    public function actionSavePayment()
    {
      $action = Yii::$app->getRequest()->post('action');
      $id = Yii::$app->getRequest()->post('id');
      $car_id = Yii::$app->getRequest()->post('car_id');
      $post = Yii::$app->getRequest()->post();
      
      $car = Car::findOne(['id'=>$car_id]);
      if (!$car)
        return $this->redirect('/cars');
       
      $payment = CarPayment::findOne(['id'=>$id]);
      if (!$payment)
        $payment = new CarPayment(['car_id'=>$car_id]);
      
      
      switch ($action)
      {
        case 'save':
          $payment->setAttribute('date', $post['date']);
          $payment->sum = $post['sum'];
          $payment->description = $post['description'];
          $payment->save();
          break;
        case 'delete':
          $payment->delete();
          break;
      }
      
      return $this->redirect('/cars/edit?id='.$car_id);
    }
}

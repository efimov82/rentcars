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
        $cars = Car::find()->where(['LIKE', 'number', $number])->offset(($page-1)*$count)->limit($count);
      else
        $cars = Car::find()->offset(($page-1)*$count)->limit($count);
        
      return $this->render('index.tpl', ['cars'=>$cars, 'number'=>$number, 'page'=>$page]);
    }
    
    public function actionEdit()
    {
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $car = Car::findOne(['id'=>$id]);
      
      //$payments = Payment::find()->where(['car_id'=>$id]);
      
      return $this->render('edit.tpl', ['car'=>$car]);
    }
    
    /**
     * Save car data
     */
    public function actionSave()
    {
      $action = Yii::$app->getRequest()->post('action');
      $id = Yii::$app->getRequest()->post('id');
      $post = Yii::$app->getRequest()->post();
      
      $car = Car::findOne(['id'=>$id]);
      if (!$car)
        $car = new Car();
      
      switch ($action)
      {
        case 'save':
          $car->mark = $post['mark'];
          $car->model = $post['model'];
          $car->color = $post['color'];
          $car->number = $post['number'];
          $car->mileage = $post['mileage'];
          $car->start_lease = $post['start_lease'];
          $car->paid_up_to = $post['paid_up_to'];
          //$car->year = $post['year'];
          //$car->description = $post['description'];
          if ($car->save())
          {
            //Yii::$app->getSession()->setFlash('message', 'Car saved successfully.');
            return $this->redirect('/cars');
          }
          else 
          {
            //Yii::$app->getSession()->setFlash('message', 'Error save car:'.$car->getErrors());
          }
          
          break;
        case 'delete':
          $car->delete();
          // TODO delete Payments
          
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

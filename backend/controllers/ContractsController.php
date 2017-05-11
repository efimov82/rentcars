<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\models\Contract;
use backend\models\Car;
use backend\models\PaymentCategory;
use backend\models\PaymentType;
use yii\helpers\ArrayHelper;

/**
 * Client controller
 */
class ContractsController extends RentCarsController
{
  public function behaviors()
  {
    return [
          'access' => [
              'class' => AccessControl::className(),
              'rules' => [
                  [    // all the action are accessible to admin and manager
                      'allow' => true,  
                      'roles' => ['admin', 'manager'],
                  ],   
//                   
              ],
          ],        
      ];
  }
  
  /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
      $page = Yii::$app->getRequest()->getQueryParam('page') ? Yii::$app->getRequest()->getQueryParam('page') : 1;
      
      $contracts = Contract::find()->limit(20, ($page-1))
                      ->orderBy(['date_create'=>SORT_DESC]);
      return $this->render('index.tpl', ['contracts'=>$contracts, 'page'=>$page]);
    }
    
    public function actionAdd()
    {
      $contract = new Contract();
      $data = array_flip($contract->getTableSchema()->getColumnNames());
      $data['car_number'] = '';
      $error = '';
      if (Yii::$app->getRequest()->isPost)
      {
        if ($this->doSave($contract))
        {
          // save clien
          // creare payment
          
          return $this->redirect('/contracts');
        }
        else
        {
          $data = Yii::$app->getRequest()->post();
          $error = Yii::$app->session->getFlash('error');
          //$contract->setAttributes(Yii::$app->getRequest()->post(), false);
        }
      }
      
      $cars = Car::find()->all();
      
      return $this->render('edit.tpl', ['data'=>$data, 'contract'=>$contract, 'cars'=>$cars, 'error'=>$error]);
    }
    
    public function actionEdit()
    {
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $payment = Payment::findOne(['id'=>$id]);
      if (!$payment)
        return $this->redirect('/');
      
      $categories = ArrayHelper::map(PaymentCategory::find(), 'id', 'name');
      
      return $this->render('edit.tpl', ['payment'=>$payment, 'categories'=>$categories]);
    }
    
    protected function doSave(Contract &$contract)
    {
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $post = Yii::$app->getRequest()->post();
      
      if ($contract->isNewRecord)
      {
        $contract->user_id =  Yii::$app->user->id;
        $contract->date_create = date('Y-m-d H:i:s');
        $contract->status = 1; // OPEN
      }
      else
      {
        $contract->date_update = date('Y-m-d H:i:s');
        $contract->status = (int)$post['status'];
      }
      
      $contract->date_start = date('Y-m-d', strtotime($post['date_start']));
      $contract->date_stop = date('Y-m-d', strtotime($post['date_stop']));
      $contract->time = (int)$post['time'];
      
      $car = Car::findOne(['id'=>(int)$post['car_id']]);
      if (!$car)
      {
        Yii::$app->session->setFlash('error', 'Wrong car number');
        return false;
      }
      
      
      $contract->car_id = $car->id;
      
      return $contract->save();
    }
}

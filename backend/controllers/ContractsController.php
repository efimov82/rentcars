<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\models\Contract;
use backend\models\Car;
use backend\models\Client;
use backend\models\PaymentCategory;
use backend\models\PaymentType;
use backend\models\Payment;
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
      
      $message = Yii::$app->session->getFlash('message');
      
      return $this->render('index.tpl', ['contracts'=>$contracts, 'page'=>$page, 'message'=>$message]);
    }
    
    public function actionAdd()
    {
      $contract = new Contract();
      $data = array_flip($contract->getTableSchema()->getColumnNames());
      $data['car_number'] = '';
      $error = '';
      
      if (!Yii::$app->getRequest()->isPost){
        return $this->renderPage($data, $contract);
      }
      
      $post = Yii::$app->getRequest()->post();
      // save clien
      $contract->client_id = $this->saveClient($post);
      if (!$contract->client_id){
        return $this->renderPage($post, $contract);
      }
      // save contract
      $res = $this->saveContract($contract, $post);
      if (!$res){
        return $this->renderPage($post, $contract);
      }

      $this->savePayments($contract, $post);
      $this->savePictures($contract, $post);
      Yii::$app->session->setFlash('message', 'Contract save success!');
      
      return $this->redirect('/contracts');
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
    
    protected function renderPage($data, $contract)
    {
      $cars = Car::find()->all();
      $clients = Client::find()->all();
      $error = Yii::$app->session->getFlash('error');
      
      return $this->render('edit.tpl', ['data'=>$data, 
                                        'contract'=>$contract, 
                                        'cars'=>$cars, 
                                        'clients'=>$clients, 
                                        'error'=>$error]);
    }
    
    
    /**
     * 
     * @param array $post
     * @return int client_id | 0
     */
    protected function saveClient(array $post)
    {
      $client = null;
      if (isset($post['client_id']) && (int)$post['client_id']){
        $client = Client::findOne(['id'=>$post['client_id']]);
      }
      
      if (!$client){
        $client = new Client();
      }
      
      $client->s_name = $post['s_name'];
      $client->passport = $post['passport'];
      $client->phone_m = $post['phone_m'];
      $client->phone_h = $post['phone_h'];
      $client->email = $post['email'];
      
      if (!$client->save()){
        Yii::$app->session->setFlash('error', 'Error save client data.');
        return false;
      }
      
      return $client->id;
    }

    /**
     * Creare/update contact
     * 
     * @param Contract $contract
     * @param array $post
     * @return boolean
     */
    protected function saveContract(Contract &$contract, array $post)
    {
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
    
    protected function savePayments($contract, $post)
    {
      $user_id = Yii::$app->user->id;
      $data = ['user_id'=>$user_id, 'creator_id'=>$user_id, 'date'=>$post['date_start'],
                  'date_create'=>date('Y-m-d H:i:s'), 'type_id'=>PaymentType::INCOMING,
                  'contract_id'=>$contract->id, 'car_id'=>$contract->car_id, 'status'=>Payment::STATUS_NEW];
      
      // deposit
      // category_id = 9 - deposit TODO think about change it
      $data1 = $data;
      $data1['category_id'] = 9;
      $data1['thb'] = $post['amount_thb'];
      $data1['euro'] = $post['amount_euro'];
      $data1['usd'] = $post['amount_usd'];
      $data1['ruble'] = $post['amount_ruble'];
      
      $payment_deposit = new Payment($data1);
      $payment_deposit->save();
      // rent payment
      // category_id = 2 TODO change it
      $data2 = $data;
      $data2['category_id'] = 2;
      $data2['thb'] = $post['deposit_thb'];
      $data2['euro'] = $post['deposit_euro'];
      $data2['usd'] = $post['deposit_usd'];
      $data2['ruble'] = $post['deposit_ruble'];
      
      $payment_rent = new Payment($data2);
      $payment_rent->save();
    }
    
    public function savePictures($contract, $post)
    {
      return true;
    }
}
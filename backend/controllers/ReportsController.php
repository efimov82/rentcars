<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\controllers\RentCarsController;
use yii\db\Query;
use backend\models\User;
use backend\models\Car;
use backend\models\PaymentCategory;
use backend\models\Payment;
use kartik\mpdf\Pdf;

class ReportsController extends RentCarsController{
  
  public    $group_by_list = ['days'      => 'Day',
                              'users'     => 'User',
                              'cars'      => 'Car',
                              'types'     => 'Type',
                              'categories'=> 'Category',
                              'statuses'  => 'Status',
                             ];
  
  public function behaviors(){
    return [
        'access' => [
          'class' => AccessControl::className(),
          'rules' => [
            [    // all the action are accessible to admin and manager
              'allow' => true,  
              'roles' => ['admin', 'manager'],
            ],   
          ],
        ],        
      ];
  }

  /**
   * @return string
   */
  public function actionIndex(){
    $users = User::find()->select('id, username')->indexBy('id')->asArray()->all();
    $categories = PaymentCategory::find()->select('id, name')->indexBy('id')->asArray()->all();
    $cars = Car::find()->indexBy('id')->all();
    $payments_statuses = Payment::getListStatuses(true);
    
    //die();
    $default_params = ['user_id'    => 0, 
                       'date_start' => date('d/m/Y', time()),
                       'date_stop'  => date('d/m/Y', time()+24*3600),
                       'payment_category' => 0,
                       'payment_status' => 0,
                       'payment_type'   => 0,
                       'show_params'    => true,
                       'hasPost'        => false
                      ];
    
    if (!Yii::$app->getRequest()->isPost){
      return $this->render('index.tpl', ['params'             => $default_params,
                                         'results'            => [], 
                                         'group_by_list'      => $this->group_by_list, 
                                         'users'              => $users,
                                         'categories'         => $categories,
                                         'payments_statuses'  => $payments_statuses
                                        ]);
    }

    $post = Yii::$app->getRequest()->post();
    $where = $this->getWhereStatement($post);
    $fields = $this->getFields($post);
    $group_by = $this->getGroupBy($post);

    $results = $this->search($fields, $where, $group_by);

    if (isset($post['group_by']))
      $post['group_by'] = array_flip($post['group_by']);
    
    $post['show_params'] = (count($results) == 0);
    $post['hasPost'] = true;
    
    $content = $this->render('index.tpl', ['params'             => $post, 
                                       'results'            => $results,
                                       'group_by_list'      => $this->group_by_list,
                                       'users'              => $users,
                                       'cars'               => $cars,
                                       'categories'         => $categories,
                                       'payments_statuses'  => $payments_statuses
                                      ]);
    //if (Yii::$app->getRequest()->isPost)
    //  return $this->pdfReport($content);
    //else
      return $content;
    
  }
  
  
  

  protected function getFields($get){
    return 'date, user_id, car_id, type_id, status, category_id, SUM(usd) as sum_usd,
            SUM(euro) as sum_euro, SUM(thb) as sum_thb, SUM(ruble) as sum_ruble';
  }

  
  protected function getGroupBy($get){
    $res = [];
    if (!isset($get['group_by']))
      return null;

    $group = array_flip($get['group_by']);

    if ($group){
      if (isset($group['days']))
        $res[] = 'date';
      if (isset($group['users']))
        $res[] = 'user_id';
      if (isset($group['cars']))
        $res[] = 'car_id';
      if (isset($group['types']))
        $res[] = 'type_id';
      if (isset($group['statuses']))
        $res[] = 'status';
      if (isset($group['categories']))
        $res[] = 'category_id';
    }

    return $res;
  }

  protected function getWhereStatement($params){
    $where = "";
    //echo("start=".$params['date_start']);
    //echo("time=".strtotime($params['date_start']));
    //die();
    print_r($params);
    if (isset($params['date_start']) && $params['date_start']){
      $where .= " AND date >= '".date('Y-m-d', strtotime(str_replace('/', '-', $params['date_start'])))."'";
    }
    
    if (isset($params['date_stop']) && $params['date_stop']){
      $where .= " AND date <= '".date('Y-m-d', strtotime(str_replace('/', '-', $params['date_stop'])))."'";
    }
    
    if (isset($params['car_number']) && $params['car_number']){
      $car = Car::findOne(['number'=>$params['car_number']]);
      //$car_id = !is_null($car) ? $car->id : 0;
      $where .= " AND car_id = ".(!is_null($car) ? $car->id : 0);//$car_id;
    }
    
    if (isset($params['user_id']) && (int)$params['user_id'])
      $where .= " AND user_id = ".(int)$params['user_id'];
    
    if (isset($params['payment_type']) && (int)$params['payment_type'])
      $where .= " AND type_id = ".(int)$params['payment_type'];
    
    if (isset($params['payment_status']) && (int)$params['payment_status'])
      $where .= " AND status = ".(int)$params['payment_status'];
    
    if (isset($params['payment_category']) && (int)$params['payment_category'])
      $where .= " AND category_id = ".(int)$params['payment_category'];

    if ($where)
      $where = substr($where, 4);

    return $where;

    //[‘between’, ‘created_date’, ‘2014-11-08’, ‘2014-11-19’]
    /*$query = (new Query())
          ->select('*')
          ->from('users u')
          ->where(['and',['u.user_id'=>[1,5,8]],['or','u.status=1','u.verified=1']])
          ->orWhere(['u.social_account'=>1,'u.enable_social'=>1]);*/
    //$command = $query->createCommand();  
    //print_r ($command->sql);
    //die;

    //return ['where'=>['AND', ['']],
    //        'group_by'=>[]];
  }

  protected function search($fields, $where, $group_by){
    $results = (new Query())
                    ->select($fields)
                    ->from('payments')
                    ->where($where)
                    ->groupBy($group_by)
                    ->orderBy('date')
                    //->createCommand();
                    //print_r ($results->sql);
                    //die();
                    ->all();

    return $results;
  }
}
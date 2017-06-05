<?php

namespace backend\controllers\common;

use backend\controllers\RentCarsController;
use backend\models\Car;
use backend\models\User;
use backend\models\Payment;
use backend\models\PaymentCategory;

/* 
 * Abstrac for common reports functions 
 */

abstract class AbstractPaymentsController extends RentCarsController {
  
  protected $default_params = [];
  protected $list_managers = [];
  protected $categories = [];
  protected $cars = [];
  protected $payments_statuses = [];


  public function __construct($id, $module, $config = array()) {
    parent::__construct($id, $module, $config);
    
    $this->default_params = ['user_id'    => 0, 
                            'date_start' => date('d/m/Y', time()),
                            'date_stop'  => date('d/m/Y', time()+24*3600),
                            'payment_category' => 0,
                            'payment_status' => 0,
                            'payment_type'   => 0,
                            'show_params'    => true,
                            'hasPost'        => false
                           ];
    
    $this->list_managers = User::find()->select('id, name')
                            ->where(['type_id'=>1])
                            ->indexBy('id')
                            ->asArray()
                            ->all();
    
    $this->categories = PaymentCategory::find()->select('id, name')
                                                ->indexBy('id')
                                                ->asArray()
                                                ->all();
    $this->cars = Car::find()->indexBy('id')->all();
    $this->payments_statuses = Payment::getListStatuses(true);
  }
  
  /**
   * 
   * @param array $params [date_start, date_stop, car_number, user_id, payment_type, payment_status, payment_category]
   * @return string WHERE conditions
   */
  protected function getWhereStatement($params){
    $where = "";
    if (isset($params['date_start']) && $params['date_start']){
      $where .= " AND date >= '".date('Y-m-d', strtotime(str_replace('/', '-', $params['date_start'])))."'";
    }
    
    if (isset($params['date_stop']) && $params['date_stop']){
      $where .= " AND date <= '".date('Y-m-d', strtotime(str_replace('/', '-', $params['date_stop'])))."'";
    }
    
    if (isset($params['car_number']) && $params['car_number']){
      $car = Car::findOne(['number'=>$params['car_number']]);
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
  }
}


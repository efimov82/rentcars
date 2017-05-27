<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;

use backend\models\Contract;
use yii\db\Query;
use backend\models\Car;

class CarsUsageController extends RentCarsController{
  
  public function behaviors(){
    return [
        'access' => [
          'class' => AccessControl::className(),
          'rules' => [
            [    // all the action are accessible to admin
              'allow' => true,  
              'roles' => ['admin'],
            ],   
          ],
        ],        
      ];
  }
  
  /**
   * @return string
   */
  public function actionIndex(){
    $default_params = ['date_start' => date('Y-m-d', time()),
                       'date_stop'  => date('Y-m-d', time()+24*3600),
                      ];
    if (!Yii::$app->getRequest()->isPost){
      return $this->render('index.tpl', ['params'  => $default_params,
                                         'data'    => [],
                                        ]);
    }

    $post = Yii::$app->getRequest()->post();
    $date_start = date('Y-m-d', strtotime($post['date_start']));
    $date_stop = date('Y-m-d', strtotime($post['date_stop']));
    
    $d1 = new \DateTime($date_start);
    $d2 = new \DateTime($date_stop);
    
    $count_days = (int)$d1->diff($d2)->format('%R%a');
    echo("$date_start - $date_stop, $count_days  \n");
    
    $where = "date_start <='".$date_stop."' AND date_stop >'".$date_start."'";
    $raw_data = (new Query())
                    ->select('*')
                    ->from('contracts')
                    ->where($where)
                    ->orderBy('date_start')
                    //->createCommand();
                    //print_r ($results->sql);
                    //die();
                    ->all();
    $data = $this->createData($raw_data, $d1, $d2);
    $cars = Car::find()->indexBy('id')->all();
    
    return $this->render('index.tpl', ['params' => $post,
                                       'data'   => $data,
                                       'cars'   => $cars,
                                       'count_days'=> $count_days]);
  }
  
  /**
   * 
   * @param array $raw_data [num]=>[id, car_id, date_start, date_stop, ...]
   * @return array [car_id]=>[]
 */
  protected function createData($raw_data, $d1, $d2) {
    $res = [];
    $arr_dates = []; // массив с last_date для каждой машины
    // types: 1 = rent; 2 = repair; 3 = free
    foreach($raw_data as $num=>$arr){
      $c1 = new \DateTime($arr['date_start']);
      $c2 = new \DateTime($arr['date_stop']);
      $car_id = $arr['car_id'];
      if (!isset($arr_dates[$car_id])) {
        $arr_dates[$car_id] = $d1;
      }
      
      $last_date = $arr_dates[$car_id];
      $diff = (int)$last_date->diff($c1)->format('%R%a');
      
      if ($diff < 0) { // ушли за пределы отчета - берем точку отсчета last_date = d1
        // если c2 лежит за d2 тогда считаем дни по d2
        if ($c2 > $d2) {
          $days = (int)$last_date->diff($d2)->format('%R%a');
        } else {
          $days = (int)$last_date->diff($c2)->format('%R%a');
        }
        //echo("contract={$arr['id']}, car_d={$arr['car_id']}, diff(last=".$last_date->format('d-m-Y')." - c2=".$arr['date_stop']." ,)=$days;\n");
        //echo("days=$days");
      } else {
        if($diff > 1) { // есть зазор между периодами - заполняем как свободное время
          $res[$arr['car_id']][] = ['contract_id'=>0, 
                                    'type'=>3, 
                                    'days'=>$diff, 
                                    'date_start'=>'', 
                                    'date_stop'=>'',
                                    'all_days'=>$diff]; // возможно даты нужно вычислить
        }
        // считаем дни текущего периода
        if ($c2 > $d2) {
          $days = (int)$c1->diff($d2)->format('%R%a');
        } else {
          $days = (int)$c1->diff($c2)->format('%R%a');
        }
      }
      
      $res[$arr['car_id']][] = ['contract_id'=>$arr['id'],
                                'type'=>$arr['type_id'], 
                                'days'=>$days, 
                                'date_start'=>$arr['date_start'], 
                                'date_stop'=>$arr['date_stop'],
                                'all_days' => (int)$c1->diff($c2)->format('%R%a')];
      // сдвигаем точку отсчета в конец текущего контракта
      $arr_dates[$car_id] = $c2;
    }
    
    // выравниваем концы массивов добавляя пустые интервалы где их нет
    foreach ($arr_dates as $car_id=>$c2){
      if ($c2 < $d2) {
        $days = (int)$c2->diff($d2)->format('%R%a');
        $res[$car_id][] = ['contract_id'=>0, 
                            'type'=>3, 
                            'days'=>$days, 
                            'date_start'=>'', 
                            'date_stop'=>'',
                            'all_days'=>$days];
      }
    }
    
     
    return $res;
  }
}
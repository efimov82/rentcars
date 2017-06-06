<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;

use yii\helpers\Url;
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
    if (!count(Yii::$app->getRequest()->getQueryParams())){
      return $this->render('index.tpl', ['params'  => $default_params,
                                         'data'    => [],
                                        ]);
    }

    $params = Yii::$app->getRequest()->get();
    $date_start = date('Y-m-d', strtotime($params['date_start']));
    $date_stop = date('Y-m-d', strtotime($params['date_stop']));
    $car_number = substr(trim($params['number']), 0, 6);
    $car_id = isset($params['car_id']) ? (int)$params['car_id'] : 0;
    
    $d1 = new \DateTime($date_start);
    $d2 = new \DateTime($date_stop);
    
    $count_days = (int)$d1->diff($d2)->format('%R%a');
    
    $where = "date_start <='".$date_stop."' AND date_stop >='".$date_start."'";
    if ($car_number) {
      $car = Car::findOne(['number'=>$car_number]);
      if ($car)
        $car_id = $car->id;
    }
      
    if ($car_id) {
      $car = Car::findOne(['id'=>$car_id]);
      if ($car)
        $params['number'] = $car->number;
    }
    
    if ($car_id)
      $where .= ' AND car_id='.$car_id;
    
    $raw_data = (new Query())
                    ->select('*')
                    ->from('contracts')
                    ->where($where)
                    ->orderBy('date_start')
                    //->createCommand();
                    //print_r ($results->sql);
                    //die();
                    ->all();
    if ($car_id) {
      $data = $this->createCalendarData($raw_data, $date_start, $date_stop);
    } else {
      $data = $this->createData($raw_data, $d1, $d2);
    }
    
    $cars = Car::find()->indexBy('id')->all();
    $base_url = Url::current();
    return $this->render('index.tpl', ['params' => $params,
                                       'data'   => $data,
                                       'base_url'   => $base_url,
                                       'cars'   => $cars,
                                       'car_number' =>$car_number,
                                       'car_id' =>$car_id,
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
  
  /**
   * Cteate calendar data array.
   * 
   * @param array $raw_data [num]=>[id, car_id, date_start, date_stop, ...]
   * @return array [num]['month'=>12,           (1-12)
   *                     'year'=>2016,          (1970-NOW)
   *                     'name'=>'Dec, 20016',  (string name)
   *                     'days'=>[day=>state]]  (1-31)
   *                            where 'state': [
   *                                            1 - free,
   *                                            2 - rent, 
   *                                            3 - repair]
 */
  protected function createCalendarData($raw_data, $period_start, $period_stop) {
    // TODO for February add check 28-29 days
    // cal_days_in_month(CAL_GREGORIAN, 2, 2003); // 28
    $months = [1=>'31', 2=>'28', 3=>'31', 4=>'30', 5=>'31', 6=>'30', 7=>'31', 8=>'31', 9=>'30', 10=>'31',11=>'30', 12=>'31'];
    $res = [];
    
    
    // create rent days matrix
    $data_rent = [];
    foreach ($raw_data as $num=>$arr) {
      $date_start = new \DateTime($arr['date_start']);
      $date_stop = new \DateTime($arr['date_stop']);
    
      //echo('state='.$arr['date_start'].", stop=".$arr['date_stop']."\n");
      while($date_start <= $date_stop) {
        $data_rent[$date_start->format('Y')][$date_start->format('m')][$date_start->format('d')] = 2;//rent
        $date_start->add(new \DateInterval('P1D'));
      }
    }
    
    // create matrix of months from start date to end date from contracts data
    $start = reset($raw_data);
    $date_start = new \DateTime($start['date_start']);
    $date_start->modify('first day of this month');
    // end
    $stop = end($raw_data);
    $date_end = new \DateTime($stop['date_stop']);
    $date_end->modify('last day of month');
    
    while($date_start <= $date_end) {
      $date_start->add(new \DateInterval('P1D'));
    }
    /*$res[] = ['name'=>'Dec, 2016', 'days'=>[0=>['day'=>'', 'state'=>1], 
                                            1=>['day'=>'1', 'state'=>2], 
                                            2=>['day'=>'2', 'state'=>2], 
                                            3=>['day'=>'3', 'state'=>2], 
                                            4=>['day'=>'4', 'state'=>1], 
                                            5=>['day'=>'5', 'state'=>1], 
                                            6=>['day'=>'6', 'state'=>1], 
                                            7=>['day'=>'7', 'state'=>2], 
                                            8=>['day'=>'8', 'state'=>2], 
                                            9=>['day'=>'9', 'state'=>2], 
                                            10=>['day'=>'10', 'state'=>2], 
                                            11=>['day'=>'11', 'state'=>1], 
                                            12=>['day'=>'12', 'state'=>1], 
                                            13=>['day'=>'13', 'state'=>1], 
                                            14=>['day'=>'14', 'state'=>2], 
                                           ]
              ];
    $res[] = ['name'=>'Jan, 2017', 'days'=>[]];
    $res[] = ['name'=>'Feb, 2017', 'days'=>[0=>['day'=>'', 'state'=>1], 
                                            1=>['day'=>'', 'state'=>2], 
                                            2=>['day'=>'', 'state'=>2], 
                                            3=>['day'=>'', 'state'=>2], 
                                            4=>['day'=>'1', 'state'=>1], 
                                            5=>['day'=>'2', 'state'=>1], 
                                            6=>['day'=>'3', 'state'=>1], 
                                            7=>['day'=>'4', 'state'=>2], 
                                            8=>['day'=>'5', 'state'=>2], 
                                            9=>['day'=>'6', 'state'=>2], 
                                            10=>['day'=>'7', 'state'=>2], 
                                            11=>['day'=>'8', 'state'=>1], 
                                            12=>['day'=>'9', 'state'=>1], 
                                            13=>['day'=>'10', 'state'=>1], 
                                            14=>['day'=>'11', 'state'=>2], 
                                            15=>['day'=>'12', 'state'=>2], 
                                            16=>['day'=>'13', 'state'=>2], 
                                           ]
              ];
    $res[] = ['name'=>'Mar, 2017', 'days'=>[]];*/
    
    return $res;
  }
  
  /**
   * 
   * @param
   * @return [year][month]=>[num=>day] - num starts from Monday. 
   *              If current month start from Friday 
   *              array contain [0=>'',1=>'',2=>'',3=>'', 4=>'1', 5=>'2', 6=>'3', ...]
 */
  protected function _createEmptyMatrix($raw_data) {
    
  }
}
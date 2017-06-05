<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;

use backend\controllers\common\AbstractPaymentsController;
use yii\db\Query;

//use kartik\mpdf\Pdf;

class ReportsController extends AbstractPaymentsController{
  
  public    $group_by_list = ['days'      => 'Day',
                              'users'     => 'Manager',
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
    if (!Yii::$app->getRequest()->isPost){
      return $this->render('index.tpl', ['params'             => $this->default_params,
                                         'results'            => [], 
                                         'group_by_list'      => $this->group_by_list, 
                                         'managers'           => $this->list_managers,
                                         'categories'         => $this->categories,
                                         'payments_statuses'  => $this->payments_statuses
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
    
    $content = $this->render('index.tpl', ['params'           => $post, 
                                          'results'           => $results,
                                          'group_by_list'     => $this->group_by_list,
                                          'managers'          => $this->list_managers,
                                          'cars'              => $this->cars,
                                          'categories'        => $this->categories,
                                          'payments_statuses' => $this->payments_statuses
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
<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Contract extends ActiveRecord
{
  public  $statuses = [1=>'Open', 2=>'Closed'];
  public  $car_number = 0;
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'contracts';
    }
}
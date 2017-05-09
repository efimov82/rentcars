<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class MoneyBenchmark extends ActiveRecord
{
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'money_benchmarks';
    }
}
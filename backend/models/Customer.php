<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Customer extends ActiveRecord
{
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'customers';
    }
}
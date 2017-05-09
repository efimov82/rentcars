<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Car extends ActiveRecord
{
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cars';
    }
}
<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Place extends ActiveRecord
{
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
      return 'places';
    }
}
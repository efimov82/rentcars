<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Area extends ActiveRecord
{
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
      return 'areas';
    }
}
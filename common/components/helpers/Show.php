<?php
namespace common\components\helpers;

use yii\helpers\BaseHtml;

class Show extends BaseHtml {

    public static function errorBlock($errors) {
        $html = [];
        if (is_array($errors) && !empty($errors)) {
            foreach ($errors as $error) {
                $html[] = '<div class="help-block"><span class="error-color">'. $error .'</span></div>';
            }
        }
        return implode('', $html);
    }

    public static function activeDropDownList($model, $attribute, $labels, $items, $options = [], $errors = []) {
        $options = empty($options) ? ['class' => 'form-select'] : $options;
        $html = '<div class="form-group">';
        $html .= '<label class="control-label">'. (isset($labels[$attribute]) ? $labels[$attribute] : '') .'</label><br>';
        $html .= parent::activeDropDownList($model, $attribute, $items, $options);
        $html .= self::errorBlock(isset($errors[$attribute]) ? $errors[$attribute] : []);
        $html .= '</div>';
        return $html;
    }

    public static function multiSelect($attribute, $needle, $haystack, $key, $value, $labels, $options = []) {
        if (empty($options)) $options = ['class' => 'form-listbox', 'multiple' => true];
        $sorted = array();
        if (!empty($haystack)) {
            foreach ($haystack as $object) {
                if (isset($object->$key) && $object->$value) {
                    $sorted[$object->$key] = $object->$value;
                }
            }
        }
        $html = '<div class="form-group">';
        $html .= '<label class="control-label">'. (isset($labels[$attribute]) ? $labels[$attribute] : '') .'</label><br>';
        $html .= BaseHtml::listBox($attribute, $needle, $sorted, $options);
        $html .= '</div>';
        return $html;
    }

    public static function input($type = '', $model, $attribute, $labels, $options = [], $errors = []) {
        $type = ($type == '') ? 'text' : $type;

        if (empty($options)) $options = ['class' => 'form-control'];
        $value = (is_object($model) && isset($model->$attribute)) ? $model->attribute : '';
        $html = '<div class="form-group">';
        $html .= '<label class="control-label">'. (isset($labels[$attribute]) ? $labels[$attribute] : '') .'</label><br>';
        $html .= parent::input($type, $attribute, $value, $options);
        $html .= self::errorBlock(isset($errors[$attribute]) ? $errors[$attribute] : []);
        $html .= '</div>';
        return $html;
    }
}
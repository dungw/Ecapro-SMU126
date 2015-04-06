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

    public static function activeDropDownList($model, $attribute, $labels, $items, $options = ['class' => 'form-select'], $errors = []) {
        $html = '<div class="form-group">';
        $html .= '<label class="control-label">'. (isset($labels[$attribute]) ? $labels[$attribute] : '') .'</label><br>';
        $html .= parent::activeDropDownList($model, $attribute, $items, $options);
        $html .= self::errorBlock(isset($errors[$attribute]) ? $errors[$attribute] : []);
        $html .= '</div>';
        return $html;
    }

    public static function multiSelect($data, $key, $value, $options = []) {
        $needOption = ['class' => 'form-listbox', 'multiple' => true];
        if (!empty($options)) $needOption = array_merge($needOption, $options);
        $sortedData = array();
        if (!empty($data)) {
            foreach ($data as $item) {
                if (isset($item[$key]) && $item[$value]) {
                    $sortedData[$item[$key]] = $item[$value];
                }
            }
        }
        return BaseHtml::listBox('list-feature', '', $sortedData, $needOption);
    }
}
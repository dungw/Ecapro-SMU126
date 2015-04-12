<?php
// DetailView Attributes Configuration
$attributes = [
    [
        'group'=>true,
        'label'=>'SECTION 1: Identification Information',
        'rowOptions'=>['class'=>'info'],
        //'groupOptions'=>['class'=>'text-center']
    ],
    [
        'attribute'=>'id',
        'label'=>'Book #',
        'type'=>DetailView::INPUT_HIDDEN
    ],
    ['attribute'=>'book_code', 'format'=>'raw', 'value'=>'<kbd>'.$model->book_code.'</kbd>', 'displayOnly'=>true],
    'attribute'=>'book_name',
    [
        'attribute'=>'color',
        'format'=>'raw',
        'value'=>"<span class='badge' style='background-color: {$model->color}'> </span>  <code>" . $model->color . '</code>',
        'type'=>DetailView::INPUT_COLOR,
        'inputContainer' => ['class'=>'col-sm-6']
    ],
    [
        'group'=>true,
        'label'=>'SECTION 2: Price / Valuation Amounts',
        'rowOptions'=>['class'=>'info'],
        //'groupOptions'=>['class'=>'text-center']
    ],
    [
        'attribute'=>'buy_amount',
        'label'=>'Buy Amount ($)',
        'format'=>['decimal', 2],
        'inputContainer' => ['class'=>'col-sm-6']
    ],
    [
        'attribute'=>'sale_amount',
        'label'=>'Sale Amount ($)',
        'format'=>['decimal', 2],
        'inputContainer' => ['class'=>'col-sm-6'],
    ],
    [
        'label'=>'Difference ($)',
        'value'=>$model->buy_amount - $model->sale_amount,
        'format'=>['decimal', 2],
        'inputContainer' => ['class'=>'col-sm-6'],
        // hide this in edit mode by adding `kv-edit-hidden` CSS class
        'rowOptions'=>['class'=>'warning kv-edit-hidden', 'style'=>'border-top: 5px double #dedede'],
    ],
    [
        'group'=>true,
        'label'=>'SECTION 3: Book Details',
        'rowOptions'=>['class'=>'info'],
        //'groupOptions'=>['class'=>'text-center']
    ],
    [
        'attribute'=>'publish_date',
        'format'=>'date',
        'type'=>DetailView::INPUT_DATE,
        'widgetOptions' => [
            'pluginOptions'=>['format'=>'yyyy-mm-dd']
        ],
        'inputContainer' => ['class'=>'col-sm-6']
    ],
    [
        'attribute'=>'status',
        'label'=>'Available?',
        'format'=>'raw',
        'value'=>$model->status ?
                '<span class="label label-success">Yes</span>' :
                '<span class="label label-danger">No</span>',
        'type'=>DetailView::INPUT_SWITCH,
        'widgetOptions' => [
            'pluginOptions' => [
                'onText' => 'Yes',
                'offText' => 'No',
            ]
        ]
    ],
    [
        'attribute'=>'rememberMe',
        'label'=>'Remember',
        'type'=>DetailView::INPUT_SWITCH,
        'widgetOptions' => [
            'pluginOptions' => [
                'onText' => 'Yes',
                'offText' => 'No',
            ]
        ],
        // hide this in view mode by adding `kv-view-hidden` CSS class
        'rowOptions'=>['class'=>'kv-view-hidden']
    ],
    [
        'attribute'=>'author_id',
        'format'=>'raw',
        'value'=>Html::a('John Steinbeck', '#', ['class'=>'kv-author-link']),
        'type'=>DetailView::INPUT_SELECT2,
        'widgetOptions'=>[
            'data'=>ArrayHelper::map(Author::find()->orderBy('name')->asArray()->all(), 'id', 'name'),
            'options' => ['placeholder' => 'Select ...'],
            'pluginOptions' => ['allowClear'=>true]
        ],
        'inputContainer' => ['class'=>'col-sm-6']
    ],
    [
        'attribute'=>'synopsis',
        'format'=>'raw',
        'value'=>'<span class="text-justify"><em>' . $model->synopsis . '</em></span>',
        'type'=>DetailView::INPUT_TEXTAREA,
        'options'=>['rows'=>4]
    ],
];

// View file rendering the widget
echo DetailView::widget([
    'model' => $model,
    'attributes' => $attributes,
    'mode' => 'view',
    'bordered' => 1,
    'striped' => 0,
    'condensed' => 0,
    'responsive' => 1,
    'hover' => 1,
    'hAlign'=>'right',
    'vAlign'=>'middle',
    'fadeDelay'=>800,
    'deleteOptions'=>[ // your ajax delete parameters
        'params' => ['id' => 1000, 'kvdelete'=>true],
    ],
    'container' => ['id'=>'kv-demo'],
    'formOptions' => ['action' => Url::current(['#' => 'kv-demo'])] // your action to delete
]);

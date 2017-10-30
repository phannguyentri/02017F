<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= lang('Thêm nguyên vật liệu'); ?></h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-md-12">
                <p class="introtext"><?php echo lang('enter_info'); ?></p>
                <?php
                $attrib = array('data-toggle' => 'validator', 'role' => 'form');
                echo form_open("items/add", $attrib)
                ?>

                <div class="col-md-6">
                    <div class="form-group">
                        <?= lang("Tên nguyên vật liệu", "item") ?>

                        <?= form_input('item', (isset($_POST['item']) ? $_POST['item'] : ''), 'class="form-control" id="item" required="required"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang("Mã nguyên vật liệu", "item_code") ?>
                        <?= form_input('item_code', (isset($_POST['item_code']) ? $_POST['item_code'] : ''), 'class="form-control" id="item_code" required="required"'); ?>
                    </div>

                    <div class="form-group all">
                        <?= lang("Quy cách", "specification") ?>
                        <?= form_input('specification', (isset($_POST['specification']) ? $_POST['specification']: ''), 'class="form-control" id="specification"  required="required"') ?>
                    </div>

                    <div class="form-group all">
                        <?= lang("Trọng lượng", "weight") ?>
                        <?= form_input('weight', (isset($_POST['weight']) ? $_POST['weight']: ''), 'class="form-control" id="weight"  required="required"') ?>
                    </div>

                     <div class="form-group all">
                        <?= lang("Giá", "cost") ?>
                        <?= form_input('cost', (isset($_POST['cost']) ? $_POST['cost']: ''), 'class="form-control" id="cost"  required="required"') ?>
                    </div>
                    <!-- <p style="font-weight: bold;">Kích thước</p> -->
                    <div class="col-md-6">
                        <div class="form-group">
                        <?= lang("Dài", "size_long") ?>
                        <?= form_input('size_long', (isset($_POST['size_long']) ? $_POST['size_long']: ''), 'class="form-control" id="size_long"') ?>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                        <?= lang("Rộng", "size_wide") ?>
                        <?= form_input('size_wide', (isset($_POST['size_wide']) ? $_POST['size_wide']: ''), 'class="form-control" id="size_wide"') ?>
                        </div>
                    </div>




                </div>
                <div class="col-md-6">

                    <div class="form-group all">
                        <?= lang("Đơn vị", "unit_id") ?>
                        <?php
                        $un[''] = "";
                        foreach ($units as $unit) {
                            $un[$unit->id] = $unit->unit;
                        }
                        echo form_dropdown('unit_id', $un, (isset($_POST['unit_id']) ? $_POST['unit_id'] : ''), 'class="form-control select" id="unit_id" placeholder="' . lang("select") . " " . lang("đơn vị") . '" required="required" style="width:100%"');
                        ?>
                        <?php echo form_hidden('unit', ''); ?>
                    </div>
                    <!-- <div class="form-group all">
                        <?= lang("Số lượng", "quantity") ?>

                        <?php
                            echo form_input('quantity', (isset($_POST['quantity']) ? $_POST['quantity'] : ''), 'class="form-control" id="quantity"');
                            ?>

                    </div>  -->
                    <div class="<?= $product ? 'text-warning' : '' ?>">
                            <strong><?= lang("warehouse_quantity") ?></strong><br>
                            <?php
                            if (!empty($warehouses)) {
                                if ($product) {
                                    echo '<div class="row"><div class="col-md-12"><div class="well"><div id="show_wh_edit">';
                                    if (!empty($warehouses_products)) {
                                        echo '<div style="display:none;">';
                                        foreach ($warehouses_products as $wh_pr) {
                                            echo '<span class="bold text-info">' . $wh_pr->name . ': <span class="padding05" id="rwh_qty_' . $wh_pr->id . '">' . $this->sma->formatNumber($wh_pr->quantity) . '</span>' . ($wh_pr->rack ? ' (<span class="padding05" id="rrack_' . $wh_pr->id . '">' . $wh_pr->rack . '</span>)' : '') . '</span><br>';
                                        }
                                        echo '</div>';
                                    }
                                    foreach ($warehouses as $warehouse) {
                                        //$whs[$warehouse->id] = $warehouse->name;
                                        echo '<div class="col-md-6 col-sm-6 col-xs-6" style="padding-bottom:15px;">' . $warehouse->name . '<br><div class="form-group">' . form_hidden('wh_' . $warehouse->id, $warehouse->id) . form_input('wh_qty_' . $warehouse->id, (isset($_POST['wh_qty_' . $warehouse->id]) ? $_POST['wh_qty_' . $warehouse->id] : (isset($warehouse->quantity) ? $warehouse->quantity : '')), 'class="form-control wh" id="wh_qty_' . $warehouse->id . '" placeholder="' . lang('quantity') . '"') . '</div>';
                                        if ($this->Settings->racks) {
                                            echo '<div class="form-group">' . form_input('rack_' . $warehouse->id, (isset($_POST['rack_' . $warehouse->id]) ? $_POST['rack_' . $warehouse->id] : (isset($warehouse->rack) ? $warehouse->rack : '')), 'class="form-control wh" id="rack_' . $warehouse->id . '" placeholder="' . lang('rack') . '"') . '</div>';
                                        }
                                        echo '</div>';
                                    }
                                    echo '</div><div class="clearfix"></div></div></div></div>';
                                } else
                                {
                                    echo '<div class="row"><div class="col-md-12"><div class="well">';
                                    foreach ($warehouses as $warehouse) {
                                        //$whs[$warehouse->id] = $warehouse->name;
                                        echo '<div class="col-md-6 col-sm-6 col-xs-6" style="padding-bottom:15px;">' . $warehouse->name . '<br><div class="form-group">' . form_hidden('wh_' . $warehouse->id, $warehouse->id) . form_input('wh_qty_' . $warehouse->id, (isset($_POST['wh_qty_' . $warehouse->id]) ? $_POST['wh_qty_' . $warehouse->id] : '0'), 'class="form-control" readonly id="wh_qty_' . $warehouse->id . '" placeholder="' . lang('quantity') . '"') . '</div>';
                                        if ($this->Settings->racks) {
                                            echo '<div class="form-group">' . form_input('rack_' . $warehouse->id, (isset($_POST['rack_' . $warehouse->id]) ? $_POST['rack_' . $warehouse->id] : ''), 'class="form-control" id="rack_' . $warehouse->id . '" placeholder="' . lang('rack') . '"') . '</div>';
                                        }
                                        echo '</div>';
                                    }
                                    echo '<div class="clearfix"></div></div></div></div>';
                                }
                            }
                            ?>
                        </div>


                </div>

                <div class="col-md-12">
                    <div class="form-group">
                        <?= lang("Ghi chú", "note") ?>
                        <?= form_textarea('note', (isset($_POST['note']) ? $_POST['note'] : ''), 'class="form-control" id="note"'); ?>
                    </div>
                    <div class="form-group">
                        <?php echo form_submit('add', $this->lang->line("Thêm nguyên vật liệu"), 'class="btn btn-primary"'); ?>
                    </div>
                </div>
                <?= form_close(); ?>

            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function (e) {
    $('#unit_id').change(function () {
            var v =  $(this).find(":selected").text();
            $('input[name="unit"]').val(v);


    });
});

</script>

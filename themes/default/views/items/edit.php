<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= lang('Sửa nguyên vật liệu'); ?></h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-md-12">
                <p class="introtext"><?php echo lang('enter_info'); ?></p>
                <?php
                $attrib = array('data-toggle' => 'validator', 'role' => 'form');
                echo form_open("items/edit/".$id, $attrib)
                ?>

                <div class="col-md-6">                    
                    <div class="form-group">
                        <?= lang("Tên nguyên vật liệu", "item") ?>
                        <?= form_input('item', (isset($_POST['item']) ? $_POST['item'] : (isset($item) ? $item->item : '')), 'class="form-control" id="item" required="required"'); ?>
                    </div>
                    <div class="form-group all">
                        <?= lang("Quy cách", "specification") ?>
                        <?= form_input('specification', (isset($_POST['specification']) ? $_POST['specification']: (isset($item) ? $item->specification : '')), 'class="form-control" id="specification"  required="required"') ?>
                    </div>

                    <div class="form-group all">
                        <?= lang("Trọng lượng", "weight") ?>
                        <?= form_input('weight', (isset($_POST['weight']) ? $_POST['weight']: (isset($item) ? $item->weight : '')), 'class="form-control" id="weight"  required="required"') ?>
                    </div>

                     <div class="form-group all">
                        <?= lang("Giá", "cost") ?>
                        <?= form_input('cost', (isset($_POST['cost']) ? $_POST['cost']: (isset($item) ? $item->cost : '')), 'class="form-control" id="cost"  required="required"') ?>
                    </div>
                    <!-- <p style="font-weight: bold;">Kích thước</p> -->
                    <div class="col-md-6">
                        <div class="form-group">
                        <?= lang("Dài", "size_long") ?>
                        <?= form_input('size_long', (isset($_POST['size_long']) ? $_POST['size_long']: (isset($item) ? $item->size_long : '')), 'class="form-control" id="size_long"') ?>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                        <?= lang("Rộng", "size_wide") ?>
                        <?= form_input('size_wide', (isset($_POST['size_wide']) ? $_POST['size_wide']: (isset($item) ? $item->size_wide : '')), 'class="form-control" id="size_wide"') ?>
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
                        echo form_dropdown('unit_id', $un, (isset($_POST['unit_id']) ? $_POST['unit_id'] : (isset($item) ? $item->unit_id : '')), 'class="form-control select" id="unit_id" placeholder="' . lang("select") . " " . lang("đơn vị") . '" required="required" style="width:100%"');                        
                        ?>
                        <?php echo form_hidden('unit', $item->unit); ?>
                    </div>
                    <!-- <div class="form-group all">
                        <?= lang("Số lượng", "quantity") ?>
                        
                        <?php
                            echo form_input('quantity', (isset($_POST['quantity']) ? $_POST['quantity'] : (isset($item) ? $item->quantity : '')), 'class="form-control" id="quantity"');
                            ?>
                        
                    </div> -->


                    <div class="<?= $product ? 'text-warning' : '' ?>">
                            <strong><?= lang("warehouse_quantity") ?></strong><br>
                            <?php
                            if (!empty($warehouses) || !empty($warehouses_products)) {
                                echo '<div class="row"><div class="col-md-12"><div class="well"><button type="button" class="btn btn-xs btn-danger pull-right tip" title="' . lang('close') . '" id="disable_wh"><i class="fa fa-times"></i></button><button type="button" class="btn btn-xs btn-warning pull-right tip" title="' . lang('edit') . '" id="enable_wh"><i class="fa fa-edit"></i></button>';
                                if (!empty($warehouses_products)) {
                                    foreach ($warehouses_products as $wh_pr) {
                                        echo '<span class="bold text-info">' . $wh_pr->name . ': <input type="hidden" value="'.$this->sma->formatDecimal($wh_pr->quantity).'" id="vwh_qty_' . $wh_pr->id . '"><span class="padding05" id="rwh_qty_' . $wh_pr->id . '">' . $this->sma->formatNumber($wh_pr->quantity) . '</span>' . ($wh_pr->rack ? ' (<span class="padding05" id="rrack_' . $wh_pr->id . '">' . $wh_pr->rack . '</span>)' : '') . '</span><br>';

                                    }
                                }
                                echo '<div id="show_wh_edit" style="padding-top:20px"><!--<div class="alert alert-danger margin010"><p>' . lang('edit_quantity_not_recommended_here') . '<input type="hidden" value="0" name="warehouse_quantity" id="warehouse_quantity"></p></div>-->';
                                foreach ($warehouses as $warehouse) {
                       
                                    //$whs[$warehouse->id] = $warehouse->name;
                                    echo '<div class="col-md-6 col-sm-6 col-xs-6" style="padding-bottom:15px;">' . $warehouse->name . '<br><div class="form-group">' . form_hidden('wh_' . $warehouse->id, $warehouse->id) . form_input('wh_qty_' . $warehouse->id, (isset($_POST['wh_qty_' . $warehouse->id]) ? $_POST['wh_qty_' . $warehouse->id] : (isset($warehouse->quantity) ? $warehouse->quantity : '')), 'class="form-control wh" readonly id="wh_qty_' . $warehouse->id . '" placeholder="' . lang('quantity') . '" ') . '</div>';
                                    if ($this->Settings->racks) {
                                        echo '<div class="form-group">' . form_input('rack_' . $warehouse->id, (isset($_POST['rack_' . $warehouse->id]) ? $_POST['rack_' . $warehouse->id] : (isset($warehouse->rack) ? $warehouse->rack : '')), 'class="form-control wh" id="rack_' . $warehouse->id . '" placeholder="' . lang('rack') . '"') . '</div>';
                                    }
                                    echo '</div>';
                                }
                                echo '</div><div class="clearfix"></div></div></div></div>';
                            }
                            ?>
                        </div>

                </div>

                <div class="col-md-12">
                    <div class="form-group">
                        <?= lang("Ghi chú", "note") ?>
                        <?= form_textarea('note', (isset($_POST['note']) ? $_POST['note'] : (isset($item) ? $item->note : '')), 'class="form-control" id="note"'); ?>
                    </div>
                    <div class="form-group">
                        <?php echo form_submit('edit', $this->lang->line("Sửa nguyên vật liệu"), 'class="btn btn-primary"'); ?>
                    </div>
                </div>
                <?= form_close(); ?>

            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function (e) {
    $('#enable_wh').click(function () {
            var whs = $('.wh');
            // $.each(whs, function () {
            //     $(this).val($('#v' + $(this).attr('id')).val());
            // });
            $('#warehouse_quantity').val(1);
            $('.wh').attr('disabled', false);
            $('#show_wh_edit').slideDown();
        });
        $('#disable_wh').click(function () {
            $('#warehouse_quantity').val(0);
            $('#show_wh_edit').slideUp();
        });
        $('#show_wh_edit').hide();
        $('.wh').attr('disabled', true);
         var whs = $('.wh');
        $.each(whs, function () {
            $(this).val($('#r' + $(this).attr('id')).text());
        });
    var v =  $(this).find(":selected").text();
    $('input[name="unit"]').val(v);
    $('#unit_id').change(function () {
            var v =  $(this).find(":selected").text();
            $('input[name="unit"]').val(v);
            

    });
});
    
</script>

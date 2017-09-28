<style type="text/css">
    #enquiry{
            display: none;


            padding-top: 13px;
            width: 111%;
            margin-left: -30px;
    }

    #enquiry .title_enquiry{
        border: 1px solid #ccc;
        margin-bottom: 11px;
        padding: 10px 5px;
        border-left: 0px;
        border-right: 0px;
        text-align: center;
        background: #d9edf7;
        color: #a52727;
        font-size: 15px;
        font-weight: 600;
    }

    .completed{
        pointer-events: none;

    }
</style>
<script type="text/javascript">
    var billers = <?= json_encode($billers)?>;
    var production_items = <?= json_encode($production_items)?>;

    console.log('inv', JSON.parse(JSON.stringify(<?= $inv_items; ?>)));

    var count = 1, an = 1, product_variant = 0, DT = <?= $Settings->default_tax_rate ?>,
        product_tax = 0, invoice_tax = 0, total_discount = 0, total = 0,
        tax_rates = <?php echo json_encode($tax_rates); ?>;
    //var audio_success = new Audio('<?= $assets ?>sounds/sound2.mp3');
    //var audio_error = new Audio('<?= $assets ?>sounds/sound3.mp3');
    $(document).ready(function () {

        <?php if ($inv) { ?>
        localStorage.setItem('sldate', '<?= $this->sma->hrsd($inv->date) ?>');
        localStorage.setItem('slcustomer', '<?= $inv->customer_id ?>');
        localStorage.setItem('slbiller', '<?= $inv->biller_id ?>');
        localStorage.setItem('slref', '<?= $inv->reference_no ?>');
        localStorage.setItem('delivery_mode', '<?= $inv->delivery_mode ?>');
        localStorage.setItem('sluwarehouse', '<?= $inv->warehouse_id ?>');
        localStorage.setItem('slsale_status', '<?= $inv->sale_status ?>');
        localStorage.setItem('slpayment_status', '<?= $inv->payment_status ?>');
        localStorage.setItem('slpayment_term', '<?= $inv->payment_term ?>');
        localStorage.setItem('slnote', '<?= str_replace(array("\r", "\n"), "", $this->sma->decode_html($inv->note)); ?>');
        localStorage.setItem('slinnote', '<?= str_replace(array("\r", "\n"), "", $this->sma->decode_html($inv->staff_note)); ?>');
        localStorage.setItem('sldiscount', '<?= $inv->order_discount_id ?>');
        localStorage.setItem('sltax2', '<?= $inv->order_tax_id ?>');
        localStorage.setItem('slshipping', '<?= $inv->shipping ?>');
        localStorage.setItem('slitems', JSON.stringify(<?= $inv_items; ?>));

        <?php } ?>
        <?php if ($Owner || $Admin) { ?>
        $(document).on('change', '#sldate', function (e) {
            localStorage.setItem('sldate', $(this).val());
        });
        if (sldate = localStorage.getItem('sldate')) {
            $('#sldate').val(sldate);
        }
        $(document).on('change', '#slbiller', function (e) {
            localStorage.setItem('slbiller', $(this).val());
        });
        if (slbiller = localStorage.getItem('slbiller')) {
            $('#slbiller').val(slbiller);
        }

        // console.log(localStorage.getItem('delivery_mode'))
        if(localStorage.getItem('delivery_mode')==1)
        {
            $('#delivery_mode').prop("checked", true).trigger('change');
        }
        else
        {
            $('#delivery_mode').prop("checked", false).trigger('change');
        }
        <?php } ?>
        ItemnTotals();

        var radio_opt = 1;
        var cate_id = 0;
        $('input[name="option-input"]').on('ifChecked', function (event) {
            radio_opt = $(this).val();
        });

        $("#add_item").autocomplete({
            source: function (request, response) {
                if (!$('#slcustomer').val()) {
                    $('#add_item').val('').removeClass('ui-autocomplete-loading');
                    bootbox.alert('<?=lang('select_above');?>');
                    $('#add_item').focus();
                    return false;
                }
                $.ajax({
                    type: 'get',
                    url: '<?= site_url('productions/suggestions'); ?>',
                    dataType: "json",
                    data: {
                        term: request.term,
                        warehouse_id: $("#slwarehouse").val(),
                        customer_id: $("#slcustomer").val(),
                        radio_opt: radio_opt,
                        cate_id: cate_id
                    },
                    success: function (data) {
                        response(data);
                    }
                });
            },
            minLength: 1,
            autoFocus: false,
            delay: 200,
            response: function (event, ui) {
                if ($(this).val().length >= 16 && ui.content[0].id == 0) {
                    //audio_error.play();
                    bootbox.alert('<?= lang('no_match_found') ?>', function () {
                        $('#add_item').focus();
                    });
                    $(this).removeClass('ui-autocomplete-loading');
                    $(this).val('');
                }
                else if (ui.content.length == 1 && ui.content[0].id != 0) {
                    ui.item = ui.content[0];
                    $(this).data('ui-autocomplete')._trigger('select', 'autocompleteselect', ui);
                    $(this).autocomplete('close');
                    $(this).removeClass('ui-autocomplete-loading');
                }
                else if (ui.content.length == 1 && ui.content[0].id == 0) {
                    //audio_error.play();
                    bootbox.alert('<?= lang('no_match_found') ?>', function () {
                        $('#add_item').focus();
                    });
                    $(this).removeClass('ui-autocomplete-loading');
                    $(this).val('');

                }
            },
            select: function (event, ui) {
                event.preventDefault();

                // console.log(billers);
                // if (ui.item.id !== 0) {
                //     var row = add_invoice_item(ui.item, billers);
                //     if (row)
                //         $(this).val('');
                // } else {
                //     //audio_error.play();
                //     bootbox.alert('<?= lang('no_match_found') ?>');
                // }


                if(radio_opt == 1){
                    if (ui.item.id !== 0) {
                        var row = add_invoice_item(ui.item, billers, 'edit_again');
                        if (row)
                            $(this).val('');
                    } else {
                        //audio_error.play();
                        bootbox.alert('<?= lang('no_match_found') ?>');
                    }
                }else{
                    // xử lý lúc chọn vào list danh mục
                    cate_id = ui.item.item_id;
                    $.ajax({
                        type: 'get',
                        url: '<?= site_url('productions/suggestions'); ?>',
                        dataType: "json",
                        data: {
                            term: ui.label,
                            warehouse_id: $("#slwarehouse").val(),
                            customer_id: $("#slcustomer").val(),
                            radio_opt: radio_opt,
                            cate_id: cate_id
                        },
                        success: function (data) {
                            if (data[0].error) {
                                bootbox.alert('<?= lang('no_match_found') ?>');
                            }else{
                                for (key in data){
                                    if (ui.item.id !== 0) {
                                        var row = add_invoice_item(data[key], billers, 'edit_again');
                                        if (row)
                                            $(this).val('');
                                    } else {
                                        bootbox.alert('<?= lang('no_match_found') ?>');
                                    }
                                }
                            }
                            cate_id = 0;

                        },
                        error: function (request, error) {
                            alert(" Can't do because: " + error);
                        },
                    });

                }


            }
        });
        $('#add_item').bind('keypress', function (e) {
            if (e.keyCode == 13) {
                e.preventDefault();
                $(this).autocomplete("search");
            }
        });

        $(window).bind('beforeunload', function (e) {
            localStorage.setItem('remove_slls', true);
            if (count > 1) {
                var message = "You will loss data!";
                return message;
            }
        });
        $('#reset').click(function (e) {
            $(window).unbind('beforeunload');
        });
        $('#edit_sale').click(function () {
            $(window).unbind('beforeunload');
            $('form.edit-so-form').submit();
        });
    });
</script>
<style type="text/css">
    .select2-container.select2-container-multi.form-control.select{
        display: inline-table !important;
    }
</style>
    <ul id="myTab" class="nav nav-tabs">
        <li class=""><a href="#report-con" class="tab-grey">Thông tin lệnh sản xuất</a></li>
        <li class=""><a href="#statistics-con" class="tab-grey">Sửa lệnh sản xuất</a></li>
    </ul>
    <div class="tab-content">
            <div id="report-con" class="tab-pane fade in">
                <div class="box">
                    <div class="box-header">
                        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= lang('Sửa lệnh sản xuất'); ?></h2>
                    </div>
                    <div class="box-content">
                        <div class="row">



                    <div class="col-md-12">
                        <p class="introtext"><?php echo lang('enter_info'); ?></p>
                        <div class="panel panel-info">
                            <div class="panel-heading">Thông tin lệnh sản xuất</div>
                            <div class="panel-body">
                            <?php
                            if($a->sale_status == 'completed' || $a->sale_status == 'cancel'){
                                $attrib = array('data-toggle' => 'validator', 'role' => 'form', 'class' => 'edit-so-form completed');
                            }else{
                                $attrib = array('data-toggle' => 'validator', 'role' => 'form', 'class' => 'edit-so-form');
                            }
                            echo form_open_multipart("productions/edit/" . $inv->id, $attrib)
                            ?>
                        <!-- <?php if ($Owner || $Admin) { ?>
                        <div class="col-md-6">
                            <div class="form-group">
                                <?= lang("date", "sldate"); ?>
                                <?php echo form_input('date', (isset($_POST['date']) ? $_POST['date'] : $this->sma->hrld($inv->date)), 'class="form-control input-tip date" id="sldate" required="required"'); ?>
                            </div>
                        </div>
                        <?php } ?> -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <?= lang("Số đơn hàng", "slref"); ?>
                                <?php echo form_input('reference_no', (isset($_POST['reference_no']) ? $_POST['reference_no'] : ''), 'class="form-control input-tip" id="slref" required="required"'); ?>
                            </div>
                        </div>
                        <!-- <div class="col-md-6">
                            <div class="form-group">
                                <?= lang("Ngày giao hàng", "due_date"); ?>
                                <?php echo form_input('due_date', (isset($_POST['due_date']) ? $_POST['due_date'] : $this->sma->hrsd($inv->due_date)), 'class="form-control input-tip date" id="due_date" '); ?>
                            </div>
                        </div> -->

                        <div class="col-md-6">
                            <div class="form-group">
                                <?= lang("Đơn vị thực hiện", "implementation_unit"); ?>
                                <?php echo form_input('implementation_unit', (isset($_POST['implementation_unit']) ? $_POST['implementation_unit'] : $inv->working), 'class="form-control input-tip" id="implementation_unit"'); ?>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <?= lang("customer", "slcustomer"); ?>
                                    <?php
                                    echo form_input('customer', (isset($_POST['customer']) ? $_POST['customer'] : ""), 'id="slcustomer" data-placeholder="' . lang("select") . ' ' . lang("customer") . '" required="required" class="form-control input-tip" style="width:100%;"');
                                    ?>
                                </div>
                            </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="checkbox" class="checkbox" name="delivery_mode" value="1" id="delivery_mode" checked="checked" >
                               <label for="attributes"  class="padding05"><?= lang('delivery_mode'); ?></label> <!-- <?= lang('eg_sizes_colors'); ?> -->
                            </div>
                        </div>
                        <div class="col-md-12" id="one" style="display: <?=($inv->delivery_mode==1)? 'block' : 'none' ?>;">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <?= lang("date", "sldate"); ?>
                                    <?php echo form_input('date', (isset($_POST['date']) ? $_POST['date'] : ""), 'class="form-control input-tip date" id="sldate" required="required"'); ?>
                                </div>
                            </div>
                             <div class="col-md-6">
                                <div class="form-group">
                                    <?= lang("Ngày giao hàng", "due_date"); ?>
                                    <?php echo form_input('due_date', (isset($_POST['due_date']) ? $_POST['due_date'] : $this->sma->hrsd(date("Y-m-d",strtotime("+ 7 day")))), 'class="form-control input-tip date" id="due_date" '); ?>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12" id="more" style="display: <?=($inv->delivery_mode!=1)? 'block' : 'none' ?>;">
                            <div class="panel panel-warning">
                                <div class="panel-heading"><?=lang('delivery_time')?>
                                <button type="button" class="btn btn-primary btn-xs" id="addDeliveryTime"><i class="fa fa-plus"></i></button>

                                </div>
                                <div class="panel-body">
                                <?php $i=0; foreach ($inv->deliveries as $key => $value) { ?>



                                <div class="row delivery_date">
                                    <button type="button" class="close" data-dismiss="alert">
                                    <span aria-hidden="true"><i class="fa fa-trash-o fa-1"></i></span>
                                    <span class="sr-only"></span>
                                    </button>
                                    <div style="clear:both;height:5px;"></div>
                                    <?=form_hidden('delivery_date['.$i.'][id]',$value->id)?>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <?= lang("Ngày bắt đầu","delivery_date_start"); ?>
                                            <?php echo form_input('delivery_date['.$i.'][start]', (isset($_POST['delivery_date['.$i.'][start]']) ? $_POST['delivery_date['.$i.'][start]'] : $this->sma->hrsd($value->delivery_date_start)), 'class="form-control input-tip date" id="delivery_date_start'.$i.'" required="required"'); ?>
                                        </div>
                                    </div>
                                     <div class="col-md-4">
                                        <div class="form-group">
                                            <?= lang("Ngày giao hàng","delivery_date_end"); ?>
                                            <?php echo form_input('delivery_date['.$i.'][end]', (isset($_POST['delivery_date['.$i.'][end]']) ? $_POST['delivery_date['.$i.'][end]'] : $this->sma->hrsd($value->delivery_date_end)), 'class="form-control input-tip date" id="delivery_date_end'.$i.'" '); ?>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <?= lang("Phần trăm giao hàng","delivery_date_end"); ?>
                                            <?php echo form_input('delivery_date['.$i.'][percent]', (isset($_POST['delivery_date['.$i.'][percent]']) ? $_POST['delivery_date['.$i.'][percent]'] : $value->delivery_percent), 'class="form-control input-tip" id="delivery_date_percent'.$i.'" '); ?>
                                        </div>
                                    </div>
                                    </div>
                                    <?php $i++; } ?>
                                    <div id="dest"></div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <input type="radio" name="option-input" class="form-group" id="option-hand" checked="checked" value="1"> Xuất thủ công
                                </div>
                                <div class="col-md-6">
                                    <input type="radio" name="option-input" class="form-group" id="option-cate" value="2"> Xuất theo danh mục
                                </div>
                            </div>
                        </div>
                        </br>

                        <div class="col-md-12" id="sticker">
                            <div class="well well-sm">
                                <div class="form-group" style="margin-bottom:0;">
                                    <div class="input-group wide-tip">
                                        <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                            <i class="fa fa-2x fa-barcode addIcon"></i></a></div>
                                        <?php echo form_input('add_item', '', 'class="form-control input-lg" id="add_item" placeholder="' . lang("add_product_to_order") . '"'); ?>
                                        <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                            <a href="#" id="addManually"><i class="fa fa-2x fa-plus-circle addIcon" id="addIcon"></i></a></div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="control-group table-group">
                                <label class="table-label"><?= lang("order_items"); ?> *</label>

                                <div class="controls table-controls">
                                    <table id="slTable"
                                           class="table items table-striped table-bordered table-condensed table-hover">
                                        <thead>
                                        <tr>
                                            <th><?= lang("product_name") . " (" . lang("product_code") . ")"; ?></th>
                                            <th>Số lượng cấu thành</th>
                                            <th>Giá</th>
                                            <th>Trọng lượng</th>
                                            <th><?= lang("Số lượng sản xuất"); ?></th>
                                            <th>Tổng số chi tiết</th>
                                            <th>Tổng tiền</th>
                                            <th>Tổng khối lượng</th>
                                            <th>Nhân viên</th>
                                            <th style="width: 30px !important; text-align: center;"><i
                                                    class="fa fa-trash-o"
                                                    style="opacity:0.5; filter:alpha(opacity=50);"></i></th>
                                        </tr>
                                        </thead>
                                        <tbody></tbody>
                                        <tfoot></tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <?= lang("document", "document") ?>
                                <input id="document" type="file" name="document" data-show-upload="false"
                                       data-show-preview="false" class="form-control file">
                            </div>
                        </div>
                        <div class="col-md-12">
                        <div class="form-group">
                            <?= lang("note", "slnote"); ?>
                            <?php echo form_textarea('note', (isset($_POST['note']) ? $_POST['note'] : ""), 'class="form-control" id="slnote" style="margin-top: 10px; height: 100px;"'); ?>

                        </div>
                        </div>

                            <div class="col-md-12 ">
                                <div class="fprom-group"><?php echo form_submit('edit_sale', lang("submit"), 'id="edit_sale" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                                    <button type="button" class="btn btn-danger" id="reset"><?= lang('reset') ?></button>
                                </div>
                            </div>
                            <?php echo form_close(); ?>
                            </div>
                        </div>
                    </div>

                        </div>
                    </div>
                </div>

            </div>
            <div id="statistics-con" class="tab-pane fade">
                <div class="box">
                    <div class="box-header">
                        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= lang('Kế hoạch sản xuất'); ?></h2>
                    </div>
                    <div class="box-content">
                        <div class="row">
                            <div class="col-md-12 ">
                                <div class="row">
                                    <div class="col-md-12">


                                    <div class="col-md-12">
                                        <div class="panel panel-info">
                                            <div class="panel-heading">Kế hoạch sản xuất</div>
                                            <div class="panel-body">
                                            <?php
                                            $attrib = array('data-toggle' => 'validator', 'role' => 'form');
                                            echo form_open("productions/norm_detail/".$inv->id, $attrib);
                                            if ($quote_id) {
                                                echo form_hidden('quote_id', $quote_id);
                                            }
                                            ?>
                                            <div class="form-group all">
                                                <?= lang("product", "items") ?>
                                                <?php
                                                $cat[''] = "";
                                                foreach ($items as $item) {
                                                    $cat[$item->product_id] = $item->product_name;
                                                }
                                                echo form_dropdown('items', $cat, (isset($_POST['items']) ? $_POST['items'] : ''), 'class="form-control select" id="items" placeholder="' . lang("select") . " " . lang("product") . '" style="width:100%"')
                                                ?>
                                            </div>

                                            <div class="col-md-12 <?php echo ($a->sale_status == 'completed' || $a->sale_status == 'cancel') ? 'completed' : '' ?>">
                                                <div  id="detail"></div>
                                                <div  id="enquiry">

                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="fprom-group <?php echo ($a->sale_status == 'completed' || $a->sale_status == 'cancel') ? 'completed' : '' ?>"><?php echo form_submit('edit_sale', lang("submit"), 'id="edit_sale" class="btn btn-primary" style="padding: 6px 15px; margin:15px 0;"'); ?>
                                                    <!-- <button type="button" class="btn btn-info" id="request"><?= lang('Tạo đơn hàng ') ?></button> -->
                                                </div>
                                            </div>
                                            <?php echo form_close(); ?>
                                            </div>
                                        </div>
                                    </div>






                                    </div>
                                </div>




                            </div>

                        </div>
                    </div>
                </div>
            </div>
    </div>


<div class="modal" id="prModal" tabindex="-1" role="dialog" aria-labelledby="prModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i
                            class="fa fa-2x">&times;</i></span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="prModalLabel"></h4>
            </div>
            <div class="modal-body" id="pr_popover_content">
                <form class="form-horizontal" role="form">
                    <?php if ($Settings->tax1) { ?>
                        <div class="form-group">
                            <label class="col-sm-4 control-label"><?= lang('product_tax') ?></label>
                            <div class="col-sm-8">
                                <?php
                                $tr[""] = "";
                                foreach ($tax_rates as $tax) {
                                    $tr[$tax->id] = $tax->name;
                                }
                                echo form_dropdown('ptax', $tr, "", 'id="ptax" class="form-control pos-input-tip" style="width:100%;"');
                                ?>
                            </div>
                        </div>
                    <?php } ?>
                    <?php if ($Settings->product_serial) { ?>
                        <div class="form-group">
                            <label for="pserial" class="col-sm-4 control-label"><?= lang('serial_no') ?></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="pserial">
                            </div>
                        </div>
                    <?php } ?>
                    <div class="form-group">
                        <label for="pquantity" class="col-sm-4 control-label"><?= lang('quantity') ?></label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="pquantity">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="poption" class="col-sm-4 control-label"><?= lang('product_option') ?></label>

                        <div class="col-sm-8">
                            <div id="poptions-div"></div>
                        </div>
                    </div>
                    <?php if ($Settings->product_discount) { ?>
                        <div class="form-group">
                            <label for="pdiscount"
                                   class="col-sm-4 control-label"><?= lang('product_discount') ?></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="pdiscount">
                            </div>
                        </div>
                    <?php } ?>
                    <div class="form-group">
                        <label for="pprice" class="col-sm-4 control-label"><?= lang('unit_price') ?></label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="pprice">
                        </div>
                    </div>
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th style="width:25%;"><?= lang('net_unit_price'); ?></th>
                            <th style="width:25%;"><span id="net_price"></span></th>
                            <th style="width:25%;"><?= lang('product_tax'); ?></th>
                            <th style="width:25%;"><span id="pro_tax"></span></th>
                        </tr>
                    </table>
                    <input type="hidden" id="punit_price" value=""/>
                    <input type="hidden" id="old_tax" value=""/>
                    <input type="hidden" id="old_qty" value=""/>
                    <input type="hidden" id="old_price" value=""/>
                    <input type="hidden" id="row_id" value=""/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="editItem"><?= lang('submit') ?></button>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="mModal" tabindex="-1" role="dialog" aria-labelledby="mModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i
                            class="fa fa-2x">&times;</i></span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="mModalLabel"><?= lang('add_product_manually') ?></h4>
            </div>
            <div class="modal-body" id="pr_popover_content">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="mcode" class="col-sm-4 control-label"><?= lang('product_code') ?> *</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="mcode">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="mname" class="col-sm-4 control-label"><?= lang('product_name') ?> *</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="mname">
                        </div>
                    </div>
                    <?php if ($Settings->tax1) { ?>
                        <div class="form-group">
                            <label for="mtax" class="col-sm-4 control-label"><?= lang('product_tax') ?> *</label>

                            <div class="col-sm-8">
                                <?php
                                $tr[""] = "";
                                foreach ($tax_rates as $tax) {
                                    $tr[$tax->id] = $tax->name;
                                }
                                echo form_dropdown('mtax', $tr, "", 'id="mtax" class="form-control input-tip select" style="width:100%;"');
                                ?>
                            </div>
                        </div>
                    <?php } ?>
                    <div class="form-group">
                        <label for="mquantity" class="col-sm-4 control-label"><?= lang('quantity') ?> *</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="mquantity">
                        </div>
                    </div>
                    <?php if ($Settings->product_serial) { ?>
                        <div class="form-group">
                            <label for="mserial" class="col-sm-4 control-label"><?= lang('product_serial') ?></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="mserial">
                            </div>
                        </div>
                    <?php } ?>
                    <?php if ($Settings->product_discount) { ?>
                        <div class="form-group">
                            <label for="mdiscount"
                                   class="col-sm-4 control-label"><?= lang('product_discount') ?></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="mdiscount">
                            </div>
                        </div>
                    <?php } ?>
                    <div class="form-group">
                        <label for="mprice" class="col-sm-4 control-label"><?= lang('unit_price') ?> *</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="mprice">
                        </div>
                    </div>
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th style="width:25%;"><?= lang('net_unit_price'); ?></th>
                            <th style="width:25%;"><span id="mnet_price"></span></th>
                            <th style="width:25%;"><?= lang('product_tax'); ?></th>
                            <th style="width:25%;"><span id="mpro_tax"></span></th>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="addItemManually"><?= lang('submit') ?></button>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
$(document).ready(function () {
    function stages(data_stages_current,data_variants,indexx,caption='', current_product)
    {
        var html='';
        html+='<div class="table-responsive">';
        html+='<table id="attrTable'+indexx+'" class="table table-bordered table-condensed table-striped" style="margin-bottom: 0; margin-top: 10px;"><caption>'+caption+'</caption>';
        html+='<thead><tr class="active"><th style="width:20% !important"><?= lang('name') ?></th><th style="width: 11%;"><?= lang('Ngày bắt đầu') ?></th><th style="width: 11%;"><?= lang('Ngày kết thúc') ?><th style="width: 9%;">Phần trăm</th></th><th><?= lang('Phân công') ?></th><th class="text-center" style="width: 4%;"><i class="fa fa-times attr-remove-all"></i></th></tr></thead><tbody>';
        // console.log(indexx);
        // console.log('data 1:',data_variants_current);
        // console.log('data variants:',data_variants);

        console.log('data_stages_current',data_stages_current);
        if(data_stages_current!=null && data_stages_current!=false)
        {
            $.each(data_stages_current, function( index, vbillerslue ) {
                html += '<tr class="attr"><td><input type="hidden" name="delivery_times[]" value="'+indexx+'"><input type="hidden" name="attr_name[]" value="'+this.stage+'">'+this.stage+'</td><td style="width:135px"><input type="text" name="date_start[]" value="'+fsd(this.date_start)+'" class="form-control input-tip date date-start" id="date_start'+index+'"  data-original-title="" title="" data-bv-field="date"></td><td style="width:135px"><input type="text" name="date_end[]" value="'+fsd(this.date_end)+'" class="form-control input-tip date date-end" id="date_end'+index+'" data-original-title="" title="" data-bv-field="date"></td><td class="text-center">'+this.stage_percent+'</td><td style="width:200px"><input type="text" name="emp[]" value="'+this.employee+'" class="form-control select" id="emp'+index+'"  placeholder="Chọn danh sách nhân viên trước" /></td><td class="text-center"><i class="fa fa-times delAttr"></i></td></tr>'
            });
        }
       else
       {
            var current_emp;
            // console.log(production_items);
            for(i in production_items){
                if(production_items[i].product_id == current_product){
                    current_emp = production_items[i].employees;
                    // console.log('emp', production_items[i]);
                }
            }
            // console.log('emp', data_variants);
            $.each(data_variants, function( index, vbillerslue) {
                // console.log(index, vbillerslue);
                // console.log('day', production_items);
                // console.log('inv:', <?=$inv->id?>);

                html += '<tr class="attr"><td><input type="hidden" name="delivery_times[]" value="'+indexx+'"><input type="hidden" name="attr_name[]" value="'+vbillerslue.name+'">'+vbillerslue.name+'</td><td style="width:135px"><input type="text" name="date_start[]" value="" class="form-control input-tip date date-start" id="date_start'+index+'" style="width:99px" data-original-title="" title="" data-bv-field="date"></td><td style="width:135px"><input type="text" name="date_end[]" value="" class="form-control input-tip date date-end" id="date_end'+index+'" style="width:99px" data-original-title="" title="" data-bv-field="date"></td> <td style="text-align: center"><input type="hidden" name="stages_percent[]" value="'+vbillerslue.percent+'"><input type="hidden" name="stage_id[]" value="'+vbillerslue.id+'">'+vbillerslue.percent+'</td><td style="width: 100px"><input type="text" name="emp[]" value="'+current_emp+'" class="form-control select" id="emp'+index+'" placeholder="Chọn danh sách nhân viên trước" /></td><td class="text-center" ><i class="fa fa-times delAttr"></i></td></tr>'
            });
       }
       html+='</tbody></table></div>';
       return html;
    }
    var deliveries=<?=json_encode($deliveries)?>;
    $('#addDeliveryTime').click(function(e){
        var row=$('div.delivery_date').length;
        var html="";
            html+='<div class="row delivery_date"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true"><i class="fa fa-trash-o fa-1"></i></span><span class="sr-only">Close</span></button><div style="clear:both;height:5px;"></div>';
            html+='<div class="col-md-4"><div class="form-group"><label for="delivery_date_start'+row+'">Ngày bắt đầu</label><input type="text" name="delivery_date['+row+'][start]" value="" class="form-control input-tip date" id="delivery_date_start'+row+'" required="required"></div></div>';
             html+='<div class="col-md-4"><div class="form-group"><label for="delivery_date_end'+row+'">Ngày giao hàng</label><input type="text" name="delivery_date['+row+'][end]" value="" class="form-control input-tip date" id="delivery_date_start'+row+'" required="required"></div></div>';
             html+='<div class="col-md-4"><div class="form-group"><label for="delivery_date_percent'+row+'">Phần trăm giao hàng</label><input type="text" name="delivery_date['+row+'][percent]" value="" class="form-control input-tip" id="delivery_date_percent'+row+'" required="required"></div></div>';
            $('#dest').append(html);
    });



    $('#delivery_mode').on('ifChecked', function (event) {
        $('#one').slideDown();
        $('#more').slideUp();
    });
    $('#delivery_mode').on('ifUnchecked', function (event) {
        $('#one').slideUp();
        $('#more').slideDown();
    });
    v = null;
    var item_quantity=0;
        $('#items').change(function () {
            var v = $(this).val();
            $('#modal-loading').show();
            if (v) {
                $.ajax({
                    type: "get",
                    async: false,
                    url: "<?= site_url('productions/getProductByID') ?>/" + <?=$inv->id?>+'/'+v,
                    dataType: "json",
                    success: function (scdata) {

                        console.log("scdata:", scdata);

                        if (scdata != null) {

                         item_quantity = scdata['qproduction'];

                         $('#detail').html('');
                           var html='';
                           var enquiry='';
                           // Khai bao May moc
                           html+='<div class="form-group all"><?= lang("Định mức máy móc ", "cf6") ?> ('+scdata.product.cf6+')';
                             html+='<div class="form-group all"><?= lang("Chọn xưởng ", "wps") ?><select name="wps" class="form-control select" id="wps" style="width: 100%" >';
                           var wps=<?=json_encode($wps)?>;
                           // console.log(<?=json_encode($wps)?>);
                            $.each(wps, function( index, vbillerslue ) {
                                if(scdata.machinery_norms[0]!=null && scdata.machinery_norms[0].working_place_id==this.id)
                                {
                                    html += '<option value="'+ this.id +'" selected="selected">'+ this.working_place +'</option>'
                                }
                                else{
                                   html += '<option value="'+ this.id +'">'+ this.working_place +'</option>';
                               }
                            });
                           html += '</select></div>';
                           var selected=new Array;
                           $.each(scdata.selectedMachine,function(k,v){
                                selected.push(v.machine_id);
                           })
                           // console.log(scdata.selectedMachine);
                           html+='<input type="text" name="machine" value="'+selected.join(',')+'" class="form-control" id="machine"  placeholder="Chọn xưởng để tải dữ liệu" />';
                           // Khai bao Nhân công
                           html += '<div class="form-group all">'


                           // html += '<?= lang("Định mức nhân công ", "cf3") ?> ('+scdata.product.cf3+') <select name="employees[]" class="form-control select" id="employees" style="width: 100%" multiple="multiple">';

                           // var billers =<?=json_encode($billers)?>;
                           // var emp=new Array();
                           // var arr=new Array();
                           //   $.each(scdata.selectedEmp,function(ke,ve){
                           //                  emp.push(ve.employee_id);
                           //                  arr.push({id:ve.employee_id,text:ve.employee})
                           //       });

                           //   $.each(billers, function( index, vbillerslue ) {
                           //          html += '<option value="'+ vbillerslue['id'] +'">'+ vbillerslue['name'] +'</option>';
                           //  });
                           //   // });

                           // html += '</select></div>'

                           // Khai bao Giai doan SX

                           // html+='<div class="form-group all"><?= lang("Giai đoạn sản xuất", "NON") ?>';
                           // html+='<div class="well well-sm" id="attr-con"><div class="form-group" id="ui" style="margin-bottom: 0;"><div class="input-group"><input type="text" name="attributesInput" value="" class="form-control select-tags" id="attributesInput" placeholder="Giai đoạn" /><div class="input-group-addon" style="padding: 2px 5px;"><a href="#" id="addAttributes"><i class="fa fa-2x fa-plus-circle" id="addIcon"></i></a></div></div><div style="clear:both;"></div></div>';
                           if(deliveries.mode==1)
                           {
                                var caption='';
                                caption='<strong>Giao hàng '+'('+fsd(deliveries.deliveries[0].delivery_date_start)+' - '+fsd(deliveries.deliveries[0].delivery_date_end)+')</strong>';
                                html+=stages(scdata.stage_norms[0].delivery_times,scdata.variants,deliveries.deliveries[0].id,caption,v);
                           }
                           else
                           {
                                $.each(deliveries.deliveries, function( index, valdel ) {
                                    $.each(scdata.stage_norms, function( inx, valdelx ){
                                        if(valdelx.id==valdel.id)
                                        {
                                            var caption='';
                                            caption='Đợt '+(index+1)+'('+fsd(valdel.delivery_date_start)+' - '+fsd(valdel.delivery_date_end)+')';
                                            html+=stages(valdelx.delivery_times,scdata.product.cf4,valdel.id,caption,v);
                                        }
                                    });

                                });
                           }

                           html+='</div></div>';
                           // Khai bao NVL
                           if(scdata.productions.sale_status =='padding')
                           {
                           html+='<div class="form-group all"><?= lang("Bổ sung nguyên liệu", "NON") ?>';
                            // var items =scdata.product.cf5;
                           }
                           else
                           {
                            html+='<div class="form-group all"><?= lang("Nguyên vật liệu", "NON") ?>';
                           }
                           html+='<div class="well well-sm" id="attr-con"><div class="form-group" id="ui" style="margin-bottom: 0;"><div class="input-group">';
                            html+='<select name="additem" class="form-control select" id="additem" style="width: 100%" multiple="multiple">';
                            var list=<?=json_encode($itemss)?>;

                            $.each(list, function( index, value ) {
                               html += '<option value="'+ this.id +'">'+ this.item +'</option>'
                            });
                            html+='</select>';
                           html+='<div class="input-group-addon" style="padding: 2px 5px;"><a href="#" id="addAttrConfig"><i class="fa fa-2x fa-plus-circle" id="addIcon"></i></a></div></div><div style="clear:both;"></div></div>';
                           html+='<div class="table-responsive"><table id="attrTableConfig" class="table table-bordered table-condensed table-striped" style="margin-bottom: 0; margin-top: 10px;"><thead><tr class="active"><th><?= lang('Nguyên vật liệu') ?></th><th><?= lang('Số lượng') ?></th><th><?= lang('Tổng số lượng') ?></th><th style="width :35px"><i class="fa fa-times attr-remove-all"></i></th></tr></thead><tbody>';

                           if(scdata.material_norms!=null && scdata.material_norms!=false)
                           {

                                if(scdata.productions['sale_status'] == 'not_start' || scdata.productions['sale_status'] == 'completed' ){
                                    $.each(scdata.material_norms, function( index, vbillerslue ) {

                                    html +='<tr data-id="'+ vbillerslue['item_id'] +'" class="attr"><td><input type="hidden" name="id[]" value="'+this.item_id+'"><input type="hidden" name="item[]" value="'+this.item+'">'+this.item+'</td><td><input type="hidden" name="ord_quantity[]" id="ord_quantity'+index+'" value="'+this.ord_quantity+'"><input type="text" name="quantity[]"  class="form-control" id="quantity'+index+'" value="'+this.quantity+'"/></td><td><input type="text" name="total_quantity[]"  class="form-control" id="total_quantity'+index+'" value="'+this.total_quantity+'"/></td><td class="text-center" ><i class="fa fa-times delAttr"></i></td></tr>'

                                    });
                                }

                           }
                           else
                           {
                                if (scdata.product.cf5) {
                                    $.each(scdata.product.cf5, function( index, vbillerslue ) {
                                    var total_quantity=0;

                                    if(this.total_quantity===undefined)
                                    {
                                        total_quantity=item_quantity*this.quantity;

                                    }

                                    html +='<tr class="attr"><td><input type="hidden" name="id[]" value="'+this.id+'"><input type="hidden" name="item[]" value="'+this.item+'">'+this.item+'</td><td><input type="hidden" name="ord_quantity[]" id="ord_quantity'+index+'" value="'+item_quantity+'"><input type="text" name="quantity[]"  class="form-control" id="quantity'+index+'" value="'+this.quantity+'"/></td><td><input type="text" name="total_quantity[]"  class="form-control" id="total_quantity'+index+'" value="'+total_quantity+'" readonly/></td><td class="text-center"><i class="fa fa-times delAttr"></i></td></tr>'
                                    });
                                }else{
                                    if(confirm("Thành phẩm "+ scdata.product.name + " chưa khai báo Định mức nguyên vật liệu, bạn có muốn quay lại chỉnh sửa thành phẩm "+ scdata.product.name + " không?")){
                                        window.location.href = '<?= base_url(); ?>products/edit/'+ scdata.product.id;
                                    }
                                    return;
                                }



                           }

                           html+='</tbody></table></div></div></div>';


                           $('#detail').append(html);


                            // arr_emps =new Array();
                            // for(i in production_items){
                            //     if (production_items[i].product_id == v) {
                            //         var str = production_items[i].employees;
                            //         var res = str.split(",");

                            //         for(j in res){
                            //             for(k in billers){
                            //                 if(res[j] == billers[k].id){
                            //                     // console.log(billers[k].name);
                            //                     arr_emps.push({id:billers[k].id,text:billers[k].name});
                            //                 }
                            //             }
                            //         }
                            //     }
                            // }
                            arr_billers =new Array();
                            for(biller in billers){
                                arr_billers.push({id:billers[biller].id,text:billers[biller].name});
                            }
                            console.log(arr_billers);
                            $("table input[name='emp[]']").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn nhân viên') ?>").select2({
                                placeholder: "<?= lang('Chọn nhân viên') ?>",
                                data: arr_billers,
                                multiple: true,

                            });



                            // $.each(production_items, function( index, vbillerslue ) {
                            //     var str = production_items[index].employees;
                            //     var res = str.split(",");
                            //     console.log('res', res);
                            //     var name='';
                            //     arr.push({id:$(this).val(),text:$(this).text()});
                            // });

                            // if(arr)
                            // {
                            //     $("table input[name='emp[]']").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn nhân viên') ?>").select2({
                            //         placeholder: "<?= lang('Chọn nhân viên') ?>",
                            //         data: arr,
                            //         multiple: true
                            //     });
                            //     console.log(arr);
                            // }




                           if(scdata['group_material_norms']){


                            enquiry +='<div class="title_enquiry ">Số lượng vật liệu chung cần nhập hàng</div>'
                            enquiry +='<table style="margin: 15px auto;width: 95%;" class="table table-bordered table-condensed table-striped ">'
                            enquiry +='<thead><tr><td>Nguyên vật liệu</td><td>Số lượng cần nhập</td></tr></thead>'
                            ltotal=0;
                            enquiry +='<tbody>'
                                $.each(scdata['group_material_norms'], function( index, vbillerslue ) {


                                    if((vbillerslue['total_quantity1']*1) > (vbillerslue['rquatity']*1)){

                                        ltotal = vbillerslue['rquatity']-vbillerslue['total_quantity1'];
                                        if(ltotal <= 0){

                                            enquiry +='<tr data-id="'+vbillerslue['item_id'] +'"><td>'+ vbillerslue['item'] +'</td><td>'+ ltotal +'</td><input type="hidden" name="item_total[]" value="'+ (ltotal*-1) +'"></tr>'
                                        }

                                    }

                                })
                            enquiry +='</tbody>'
                            enquiry +='</table>'

                            enquiry +='<div class="col-md-6 text-left "><a style="text-decoration: underline;" id="quick_enquiry" href="javascript:void(0)">Thêm hàng tự động</a></div>'
                            enquiry +='<div class="col-md-6 text-right "><a style="text-decoration: underline;"   href="enquiry/add">Thêm hàng thủ công</a></div>'
                            $('#enquiry').css({'display':'block'});
                            $('#enquiry').empty().html(enquiry);
                           }





                            if(scdata.machine_list!=null)
                            {
                            $("#machine").select2("destroy").empty().attr("placeholder", "<?= lang('Hãy chọn máy') ?>").select2({
                                data: scdata.machine_list,
                                multiple: true
                             });
                            }
                            // if(scdata.selectedEmp!=null)
                            // {
                            //  $("table input[name='emp[]']").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn nhân viên') ?>").select2({
                            //         placeholder: "<?= lang('Chọn nhân viên') ?>",
                            //         data: arr,
                            //         multiple: true
                            //     });
                            // }
                            // $('#detail #employees').select2({
                            //   placeholder: "Chọn nhân viên"
                            // }).select2('val',emp);


                           $('#detail #wps').select2({
                              placeholder: "Chọn xưởng"
                            });
                           $('#detail #additem').select2();

                          var variants = <?=json_encode($vars);?>;

                        $(".select-tags").select2({
                            tags: variants,
                            tokenSeparators: [","],
                            multiple: true
                        });

                        }
                    }
                });



            } else {
                $("#subcategory").select2("destroy").empty().attr("placeholder", "<?= lang('select_category_to_load') ?>").select2({
                    placeholder: "<?= lang('select_category_to_load') ?>",
                    data: [{id: '', text: '<?= lang('select_category_to_load') ?>'}]
                });
            }
            $('#modal-loading').hide();
        });

        $('#detail').on('click','#addAttrConfig',function(e){
            var index = 0;
            e.preventDefault();

            var attrs_val = $('#additem').select2('val'), attrs;
            arr=new Array();
            $.each($('#additem option:selected'),function(k,v){
                arr.push({id:$(this).val(),item:$(this).text(),item_quantity: item_quantity})
            });




            for (var i in arr) {

                if (arr[i] !== '') {
                    index = ($('#attrTableConfig tbody tr').length);

                      var id = <?php echo $id; ?>;
                      var id_pro = $('#items option:checked').val();
                        $.ajax({
                                type: "get",
                                async: false,
                                url: "<?= site_url('productions/addQuick') ?>" ,
                                dataType: "json",
                                data:{
                                    'id':id,
                                    'quantity':1,
                                    'id_item':arr[i].id,
                                    'id_pro' : id_pro,
                                    'item':arr[i].item,
                                    'ord_quantity' : 0,
                                    'total_quantity' : 0,
                                },
                                success: function (scdata) {

                                    $('#attrTableConfig tbody').append('<tr data-id="'+ arr[i].id +'" class="attr"><td><input type="hidden" name="id[]" value="'+arr[i].id+'"><input type="hidden" name="item[]" value="'+arr[i].item+'">'+arr[i].item+'</td><td><input type="hidden" name="ord_quantity[]" id="ord_quantity'+index+'" value="'+arr[i].item_quantity+'"><input type="text" name="quantity[]"  class="form-control" id="quantity'+index+'" value="'+''+'"/></td><td><input type="text" name="total_quantity[]"  class="form-control" id="total_quantity'+index+'" value="'+''+'"/></td><td class="text-center"><i class="fa fa-times delAttr"></i></td></tr>');
                                },
                         });


                }



            }
            var arr=new Array();
            $.each($('#employees option:selected'),function(k,v){
                arr.push({id:$(v).val(),text:$(v).text()})
            });



            $("#attrTable input[name='emp[]']").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn nhân viên') ?>").select2({
                    placeholder: "<?= lang('Chọn nhân viên') ?>",
                    data: arr,
                    multiple: true
            });


        });

        $('#detail').on('click','#addAttributes',function(e){
            var index = 0;
            e.preventDefault();
            var attrs_val = $('#attributesInput').val(), attrs;
            attrs = attrs_val.split(',');

            for (var i in attrs) {



                if (attrs[i] !== '') {
                    index = ($('#attrTable tbody tr').length);

                    $('#attrTable tbody').append('<tr  class="attr"><td><input type="hidden" name="attr_name[]" value="' + attrs[i] + '"><span>' + attrs[i] + '</span></td><td style="width:135px"><input type="text" name="date_start[]" value="" class="form-control input-tip date date-start" id="date_start'+index+'"  data-original-title="" title="" data-bv-field="date"></td><td style="width:135px"><input type="text" name="date_end[]" value="" class="form-control input-tip date date-end" id="date_end'+index+'" data-original-title="" title="" data-bv-field="date"></td><td style="width:200px"><input type="text" name="emp[]" value="" class="form-control select" id="emp'+index+'"  placeholder="Chọn danh sách nhân viên trước" /></td><td class="text-center"><i class="fa fa-times delAttr"></i></td></tr>');
                }

            }
            var arr=new Array();
            $.each($('#additem option:selected'),function(k,v){
                arr.push({id:$(v).val(),text:$(v).text()})
            })


            $("#attrTable input[name='emp[]']").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn nhân viên') ?>").select2({
                    placeholder: "<?= lang('Chọn nhân viên') ?>",
                    data: arr,
                    multiple: true
                });


        });

        $('#detail').on('keyup', 'input[name="quantity[]"]', function (e) {


            var id_item = $(this).parent().prev().find('input[name="id[]"]').val();
            var ord_quantity=$(this).prev().val();
            var quantity=$(this).val();

            $(this).parent().next().find('input').val(parseFloat(ord_quantity)*parseFloat(quantity))


            var id = <?php echo $id; ?>;

            var v = parseFloat(ord_quantity)*parseFloat(quantity);
            var id_pro = $('#items option:checked').val();


             if (id) {
                 $.ajax({
                    type: "get",
                    async: false,
                    url: "<?= site_url('productions/getItemQuantity') ?>/" + v,
                    dataType: "json",
                    data:{
                        'id':id,
                        'quantity':v,
                        'id_item':id_item,
                        'id_pro' : id_pro,
                    },
                    success: function (scdata) {

                        if(scdata['group']!=null && scdata['item']!=false){
                            $('#enquiry tr[data-id="'+ scdata['group'][0]['item_id']+'"]').remove();
                            if((scdata['total_new']*1) < 0 ){
                             $('#enquiry table tbody').prepend('<tr data-id="'+  scdata['group'][0]['item_id'] +'"><td>'+ scdata['group'][0]['item']+'</td><td>'+ scdata['total_new'] +'</td><input type="hidden" name="item_total[]" value="'+ (scdata['total_new']*-1) +'"></tr>')
                           }
                       }
                    },
             });
            };
        });

        // $("input[name='quantity[]']").keyup(function(){
        // alert('sdvd');
        // });


        $(document).on('click', '.delAttr', function () {
            $(this).closest("tr").remove();
        });

        $(document).on('click', '.delAttrConfig', function () {
            $(this).closest("tr").remove();
        });



        // định mức nhân công
        // $('#detail').on('change','#employees',function(){
        //     arr =new Array();
        //     $.each($('#employees option:selected'), function( index, vbillerslue ) {
        //     var name='';
        //         arr.push({id:$(this).val(),text:$(this).text()});
        //     });

        //     if(arr)
        //     {
        //         $("table input[name='emp[]']").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn nhân viên') ?>").select2({
        //             placeholder: "<?= lang('Chọn nhân viên') ?>",
        //             data: arr,
        //             multiple: true
        //         });
        //         console.log(arr);
        //     }
        //     else
        //     {
        //         $("table input[name='emp[]']").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn danh sách nhân viên trước') ?>").select2({
        //                 placeholder: "<?= lang('Chọn danh sách nhân viên trước') ?>",
        //                 data: [{id: '', text: '<?= lang('Chọn danh sách nhân viên trước') ?>'}]
        //         });
        //     }
        // });



        function toDate(dateStr) {
            var parts = dateStr.split("/");
            return new Date(parts[2], parts[1] - 1, parts[0]);
        }
        //validate ngày bắt đầu
        // $('#detail').on('change','.date-start',function(){
        //     var date=toDate($('#sldate').val());// ngay tao lenh san xuat
        //     // alert(date);
        //     var duedate=toDate($('#due_date').val());// ngay giao hang
        //     if(toDate($(this).val())<date){

        //          bootbox.alert('<?= lang('Ngày bắt đầu không được nhỏ hơn ngày tạo lệnh sản xuất!') ?>');
        //          $(this).val('');
        //     }
        //     if(toDate($(this).val())>duedate){
        //          bootbox.alert('<?= lang('Ngày bắt đầu không được lớn hơn ngày giao hàng!') ?>');
        //          $(this).val('');
        //     }
        // });

         //validate ngày kết thúc
        // $('#detail').on('change','.date-end',function(){
        //     var date=toDate($('#sldate').val());// ngay tao lenh san xuat
        //     var duedate=toDate($('#due_date').val());// ngay giao hang
        //     if(toDate($(this).val())<date){

        //          bootbox.alert('<?= lang('Ngày kết thúc không được nhỏ hơn ngày tạo lệnh sản xuất!') ?>');
        //          $(this).val('');
        //     }
        //     if(toDate($(this).val())>duedate){
        //          bootbox.alert('<?= lang('Ngày kết thúc không được lớn hơn ngày giao hàng!') ?>');
        //          $(this).val('');
        //     }
        // });

        // $('#detail').on('change','.date',function(){
        //     var datestart=toDate($('input[name="date_start[]"]').val());// ngay tao lenh san xuat
        //     var dateend=toDate($('input[name="date_end[]"]').val());// ngay giao hang
        //     var n = datestart.getTime();
        //     var n1 = dateend.getTime();
        //     if(n>n1){
        //         bootbox.alert('<?= lang('Ngày bắt đầu phải nhỏ hơn ngày kết thúc giai đoạn!') ?>');
        //         $(this).val('');
        //     }
        // });



        $('#detail').on('keyup','input[name="total_quantity[]"]',function(){

            var id = <?php echo $id; ?>;
            var id_item = $(this).parent().prev().prev().find('input[name="id[]"]').val();
            var v = $(this).val();
            var id_pro = $('#items option:checked').val();


             if (id) {
                 $.ajax({
                    type: "get",
                    async: false,
                    url: "<?= site_url('productions/getItemQuantity') ?>/" + v,
                    dataType: "json",
                    data:{
                        'id':id,
                        'quantity':v,
                        'id_item':id_item,
                        'id_pro' : id_pro,
                    },
                    success: function (scdata) {

                        $('#enquiry tr[data-id="'+ scdata['group'][0]['item_id']+'"]').remove();
                       if((scdata['total_new']*1) < 0 ){


                         $('#enquiry table tbody').prepend('<tr data-id="'+  scdata['group'][0]['item_id'] +'"><td>'+ scdata['group'][0]['item']+'</td><td>'+ scdata['total_new'] +'</td><input type="hidden" name="item_total[]" value="'+ (scdata['total_new']*-1) +'"></tr>')
                       }
                    },
             });
            };

        });

         $('#detail').on('change','#wps',function(){
            var v = $(this).val();
            if (v) {
                $.ajax({
                    type: "get",
                    async: false,
                    url: "<?= site_url('working_places/getAllMechines') ?>/" + v,
                    dataType: "json",
                    success: function (scdata) {
                        if (scdata != null) {
                           $("#machine").select2("destroy").empty().attr("placeholder", "<?= lang('Hãy chọn máy') ?>").select2({
                    placeholder: "<?= lang('Chọn xưởng để tải dữ liệu') ?>",
                    data: scdata,
                    multiple: true
                });

                        }
                        else{
                            $("#machine").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn xưởng để tải dữ liệu') ?>").select2({
                            placeholder: "<?= lang('Chọn xưởng để tải dữ liệu') ?>",
                            data: [{id: '', text: '<?= lang('Chọn xưởng để tải dữ liệu') ?>'}]
                        });
                        }
                    },
                    error: function () {
                        bootbox.alert('<?= lang('ajax_error') ?>');
                        $('#modal-loading').hide();
                    }

                });
            } else {
                $("#machine").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn xưởng để tải dữ liệu') ?>").select2({
                    placeholder: "<?= lang('Chọn xưởng để tải dữ liệu') ?>",
                    data: [{id: '', text: '<?= lang('Chọn xưởng để tải dữ liệu') ?>'}]
                });
            }
            $('#modal-loading').hide();
        });


        $('#code').bind('keypress', function (e) {
            if (e.keyCode == 13) {
                e.preventDefault();
                return false;
            }
        });



        $('#enquiry').on('click','#quick_enquiry',function(){
           var arr = [];
            $.each( $('#enquiry').find('tbody tr'), function( key, value ) {
                var obj = {};
                obj.id = $(value).attr('data-id');
                obj.value = $(value).find('input[name="item_total[]"]').val();
                arr.push(obj);
            });

            if(arr){
                  $.ajax({
                    type: "get",
                    async: false,
                    url: "<?= site_url('productions/addQuickEnquiry') ?>/",
                    data : {
                        'arr' : arr,
                        'warehouse_id' : $('#slwarehouse option:checked').val(),
                    },
                    dataType: "json",
                    success: function (scdata) {

                        if(scdata){
                            bootbox.alert('<?= lang('Thêm yêu cầu nhập hàng thành công') ?>');
                            $('#enquiry tbody').empty();
                            $('#modal-loading').hide();
                        }else{
                            bootbox.alert('<?= lang('Thêm yêu cầu nhập hàng thất bại') ?>');

                            $('#modal-loading').hide()
                        }
                    },

                });
            }

        });
    });

    $(document).on("focus", '.rquantity', function () {
        old_row_qty = $(this).val();
        // console.log('select', $('[name=employees_41]').val());
    }).on("change", '.rquantity', function () {
        // console.log('bill', billers);

        var row = $(this).closest('tr');
        total_detail = $(this).closest('tr').find('.quantity-config').text()*$(this).val();
        total_money = $(this).closest('tr').find('.price').attr('attr-price')*$(this).val();
        total_weight = $(this).closest('tr').find('.weight').text()*$(this).val();
        $(this).closest('tr').find('.total-detail').text(formatMoney(total_detail));
        $(this).closest('tr').find('.total-money').val(total_money);
        $(this).closest('tr').find('.text-total-money').text(formatMoney(total_money));
        $(this).closest('tr').find('.total-weight').text(formatMoney(total_weight));
        // if (!is_numeric($(this).val())) {
        //     $(this).val(old_row_qty);
        //     bootbox.alert(lang.unexpected_value);
        //     return;
        // }
        // var new_qty = parseFloat($(this).val()),
        // item_id = row.attr('data-item-id');
        // slitems[item_id].row.qty = new_qty;
        // localStorage.setItem('slitems', JSON.stringify(slitems));

        // // console.log(JSON.stringify(slitems));
        // loadItems(billers);
    });

</script>

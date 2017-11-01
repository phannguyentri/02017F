<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i><?= lang('edit_product'); ?></h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-md-12">

                <p class="introtext"><?php echo lang('enter_info'); ?></p>

                <?php
                $attrib = array('data-toggle' => 'validator', 'role' => 'form');
                echo form_open_multipart("products/edit/".$product->id, $attrib)
                ?>

                <div class="col-md-6">
                <div class="panel panel-info">
                    <div class="panel-heading">Thông tin thành phẩm</div>
                    <div class="panel-body">
                        <div class="form-group all">
                            <?= lang("Thành phẩm", "unit_id") ?>
                            <?php
                                foreach ($categories as $category) {
                                    $cate[$category->id] = $category->name;
                                }
                                echo form_dropdown('category_id', $cate, isset($_POST['category_id']) ? $_POST['category_id'] : $product->category_id, 'class="form-control select" id="unit_id"
                                 placeholder="' . lang("select") . " " . lang("danh mục") . '" required="required" style="width:100%"');
                            ?>
                            <?php echo form_hidden('unit', ''); ?>
                        </div>
                        <?php echo form_hidden('unit', ''); ?>
                        <div class="form-group all">
                            <?= lang("Tên bán thành phẩm", "name") ?>
                            <?= form_input('name', (isset($_POST['name']) ? $_POST['name'] : ($product ? $product->name : '')), 'class="form-control" id="name" required="required"'); ?>
                        </div>
                        <div class="form-group all">
                            <?= lang("Mã bán thành phẩm", "code") ?>
                            <?= form_input('code', (isset($_POST['code']) ? $_POST['code'] : ($product ? $product->code : '')), 'class="form-control" id="code"') ?>
                            <!-- <span class="help-block"><?= lang('you_scan_your_barcode_too') ?></span> -->
                        </div>
                        <div class="form-group all">
                            <label>Đơn giá nguyên công</label>
                            <?= form_input('wage', (isset($_POST['wage']) ? $_POST['wage'] : ($product ? $product->wage : '')), 'class="form-control" id="wage"'); ?>
                        </div>
                        <div class="form-group all">
                            <?= lang("Quy cách", "cf1") ?>
                            <?= form_input('cf1', (isset($_POST['cf1']) ? $_POST['cf1'] : ($product ? $product->cf1 : '')), 'class="form-control" id="cf1
                            "'); ?>
                        </div>
                        <div class="form-group all">
                            <?= lang("Trọng lượng", "cf2") ?>
                            <?= form_input('cf2', (isset($_POST['cf2']) ? $_POST['cf2'] : ($product ? $product->cf2 : '')), 'class="form-control" id="cf2"'); ?>
                        </div>
                        <div class="form-group all">
                            <label class="control-label" for="unit"><?= lang("Đơn vị") ?></label>
                            <?= form_input('unit', (isset($_POST['unit']) ? $_POST['unit'] : ($product ? $product->unit : '')), 'class="form-control tip" id="unit"') ?>
                        </div>
                        <div class="form-group all">
                            <?= lang("product_price", "price") ?>
                            <?= form_input('price', (isset($_POST['price']) ? $_POST['price'] : ($product ? $this->sma->formatDecimal($product->price) : '')), 'class="form-control tip" id="price" required="required"') ?>
                        </div>
                        <!-- <div class="form-group all">
                            <?= lang("quantity", "wh_qty_1") ?>
                            <?= form_hidden('wh_1', 1) ?>
                            <?= form_input('wh_qty_1', (isset($_POST['wh_qty_1']) ? $_POST['wh_qty_1'] : ($product ? $this->sma->formatDecimal($product->quantity) : '')), 'class="form-control tip" id="wh_qty_1"') ?>
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
                                        echo '<div class="col-md-6 col-sm-6 col-xs-6" style="padding-bottom:15px;">' . $warehouse->name . '<br><div class="form-group">' . form_hidden('wh_' . $warehouse->id, $warehouse->id) . form_input('wh_qty_' . $warehouse->id, (isset($_POST['wh_qty_' . $warehouse->id]) ? $_POST['wh_qty_1' . $warehouse->id] : (isset($warehouse->quantity) ? $warehouse->quantity : '')), 'class="form-control wh" id="wh_qty_' . $warehouse->id . '" placeholder="' . lang('quantity') . '" ') . '</div>';
                                        if ($this->Settings->racks) {
                                            echo '<div class="form-group">' . form_input('rack_' . $warehouse->id, (isset($_POST['rack_' . $warehouse->id]) ? $_POST['rack_' . $warehouse->id] : (isset($warehouse->rack) ? $warehouse->rack : '')), 'class="form-control wh" id="rack_' . $warehouse->id . '" placeholder="' . lang('rack') . '"') . '</div>';
                                        }
                                        echo '</div>';
                                    }
                                    echo '</div><div class="clearfix"></div></div></div></div>';
                                }
                                ?>
                            </div>
                        <div class="form-group all">
                            <?= lang("product_image", "product_image") ?>
                            <input id="product_image" type="file" name="product_image" data-show-upload="false"
                                   data-show-preview="false" accept="image/*" class="form-control file">
                        </div>

                        <div class="form-group all">
                            <?= lang("product_gallery_images", "images") ?>
                            <input id="images" type="file" name="userfile[]" multiple="true" data-show-upload="false"
                                   data-show-preview="false" class="form-control file" accept="image/*">
                        </div>
                        <div id="img-details"></div>
                    </div>
                </div>

                </div>
                <div class="col-md-6">
                <div class="panel panel-info">
                    <div class="panel-heading">Thông tin định mức</div>
                    <div class="panel-body">
                    <div class="form-group all">
                        <?= lang("Định mức máy móc", "cf6") ?>
                        <?= form_input('cf6', (isset($_POST['cf6']) ? $_POST['cf6'] : ($product ? $product->cf6 : '')), 'class="form-control" id="cf6"'); ?>
                    </div>
                    <div class="form-group all">
                        <?= lang("Định mức nhân công", "cf3") ?>
                        <?= form_input('cf3', (isset($_POST['cf3']) ? $_POST['cf3'] : ($product ? $product->cf3 : '')), 'class="form-control" id="cf3"'); ?>
                    </div>
                    <div class="form-group all">
                        <?= lang("Số lượng cấu thành", "cf3") ?>
                        <?= form_input('quantity_config', (isset($_POST['quantity_config']) ? $_POST['quantity_config'] : ($product ? $product->quantity_config : '')), 'class="form-control" id="cf3"'); ?>
                    </div>



                    <div class="form-group">
                        <input type="checkbox" class="checkbox" name="attrConfig"
                               id="attrConfig" <?= $this->input->post('attrConfig') || $product->cf5 ? 'checked="checked"' : ''; ?>>
                       <label for="attrConfig"  class="padding05">Định mức nguyên vật liệu</label> <!-- <?= lang('eg_sizes_colors'); ?> -->
                    </div>

                    <div class="well well-sm" id="attr-config"
                         style="<?= $this->input->post('attrConfig') || $product->cf5 ? '' : 'display:none;'; ?>">
                        <div class="form-group" id="ui" style="margin-bottom: 0;">
                            <div class="input-group">
                                <?php
                                $it[''] = "";
                                $list=array();
                                foreach ($product->cf5 as  $value) {
                                    $list[]=$value->id;
                                }
                                foreach ($items as $item) {
                                    $it[$item->id] = $item->item;
                                }
                                echo form_dropdown('attrConfigInput', $it, (isset($_POST['attrConfigInput']) ? $_POST['attrConfigInput'] : ''), 'class="form-control" multiple id="attrConfigInput" placeholder="' . lang("select") . " " . lang("items") . '" style="width:100%"') ?>
                                <div class="input-group-addon" style="padding: 2px 5px;"><a href="#" id="addAttrConfig"><i class="fa fa-2x fa-plus-circle" id="addIcon"></i></a></div>
                            </div>
                            <div style="clear:both;"></div>
                        </div>
                        <div class="table-responsive">
                            <table id="attrTableConfig" class="table table-bordered table-condensed table-striped"
                                   style="margin-bottom: 0; margin-top: 10px;">
                                <thead>
                                <tr class="active">
                                    <!-- <th><?= lang('STT') ?></th> -->
                                    <th><?= lang('Nguyên vật liệu') ?></th>
                                    <th class="text-center"><?= lang('quantity') ?></th>
                                    <th><i class="fa fa-times attr-remove-all-config"></i></th>
                                </tr>
                                </thead>
                                <tbody>
                                <?php $i=1; foreach ($product->cf5 as $key => $value) { ?>
                                <tr class="attrconfig">
                                    <!-- <td class="text-center"><?= $i++ ?></td> -->
                                    <td><?=form_hidden('attr_id[]',$value->id)?><?=form_hidden('attr_item[]',$value->item)?><span><?= $value->item ?></span></td>
                                    <td class="text-center"><?=form_hidden('attr_quantity[]',$value->quantity)?><span><?= $this->sma->formatNumber($value->quantity) ?></span></td>
                                    <td class="text-center"><i class="fa fa-times delAttrConfig"></i></td>
                                </tr>
                                <?php } ?>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    </div>
                </div>


                </div>
                <div class="col-md-12">


                    <div class="form-group all">
                        <?= lang("product_details", "product_details") ?>
                        <?= form_textarea('product_details', (isset($_POST['product_details']) ? $_POST['product_details'] : ($product ? $product->product_details : '')), 'class="form-control" id="details"'); ?>
                    </div>

                    <div class="form-group">
                        <?php echo form_submit('edit_product', $this->lang->line("edit_product"), 'class="btn btn-primary"'); ?>
                    </div>

                </div>
                <?= form_close(); ?>

            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var audio_success = new Audio('<?= $assets ?>sounds/sound2.mp3');
        var audio_error = new Audio('<?= $assets ?>sounds/sound3.mp3');
        var items = {};
        <?php
        if($combo_items) {
            foreach($combo_items as $item) {
            //echo 'ietms['.$item->id.'] = '.$item.';';
                if($item->code) {
                    echo 'add_product_item('.  json_encode($item).');';
                }
            }
        }
        ?>
        <?=isset($_POST['cf']) ? '$("#extras").iCheck("check");': '' ?>
        $('#extras').on('ifChecked', function () {
            $('#extras-con').slideDown();
        });
        $('#extras').on('ifUnchecked', function () {
            $('#extras-con').slideUp();
        });

        $('.attributes').on('ifChecked', function (event) {
            $('#options_' + $(this).attr('id')).slideDown();
        });
        $('.attributes').on('ifUnchecked', function (event) {
            $('#options_' + $(this).attr('id')).slideUp();
        });

        $("#add_item").autocomplete({
            source: '<?= site_url('products/suggestions'); ?>',
            minLength: 1,
            autoFocus: false,
            delay: 200,
            response: function (event, ui) {
                if ($(this).val().length >= 16 && ui.content[0].id == 0) {
                    //audio_error.play();
                    bootbox.alert('<?= lang('no_product_found') ?>', function () {
                        $('#add_item').focus();
                    });
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
                    bootbox.alert('<?= lang('no_product_found') ?>', function () {
                        $('#add_item').focus();
                    });
                    $(this).val('');

                }
            },
            select: function (event, ui) {
                event.preventDefault();
                if (ui.item.id !== 0) {
                    var row = add_product_item(ui.item);
                    if (row) {
                        $(this).val('');
                    }
                } else {
                    //audio_error.play();
                    bootbox.alert('<?= lang('no_product_found') ?>');
                }
            }
        });
        $('#add_item').bind('keypress', function (e) {
            if (e.keyCode == 13) {
                e.preventDefault();
                $(this).autocomplete("search");
            }
        });
        <?php
        if($this->input->post('type') == 'combo') {
            $c = sizeof($_POST['combo_item_code']);
            for ($r = 0; $r <= $c; $r++) {
                if(isset($_POST['combo_item_code'][$r]) && isset($_POST['combo_item_quantity'][$r]) && isset($_POST['combo_item_price'][$r])) {
                    $items[] = array('id' => $_POST['combo_item_id'][$r], 'name' => $_POST['combo_item_name'][$r], 'code' => $_POST['combo_item_code'][$r], 'qty' => $_POST['combo_item_quantity'][$r], 'price' => $_POST['combo_item_price'][$r]);
                }
            }
            echo '
            var ci = '.json_encode($items).';
            $.each(ci, function() { add_product_item(this); });
            ';
        }
        ?>
        function add_product_item(item) {
            if (item == null) {
                return false;
            }
            item_id = item.id;
            if (items[item_id]) {
                items[item_id].qty = (parseFloat(items[item_id].qty) + 1).toFixed(2);
            } else {
                items[item_id] = item;
            }

            $("#prTable tbody").empty();
            $.each(items, function () {
                var row_no = this.id;
                var newTr = $('<tr id="row_' + row_no + '" class="item_' + this.id + '"></tr>');
                tr_html = '<td><input name="combo_item_id[]" type="hidden" value="' + this.id + '"><input name="combo_item_name[]" type="hidden" value="' + this.name + '"><input name="combo_item_code[]" type="hidden" value="' + this.code + '"><span id="name_' + row_no + '">' + this.name + ' (' + this.code + ')</span></td>';
                tr_html += '<td><input class="form-control text-center" name="combo_item_quantity[]" type="text" value="' + formatDecimal(this.qty) + '" data-id="' + row_no + '" data-item="' + this.id + '" id="quantity_' + row_no + '" onClick="this.select();"></td>';
                tr_html += '<td><input class="form-control text-center" name="combo_item_price[]" type="text" value="' + formatDecimal(this.price) + '" data-id="' + row_no + '" data-item="' + this.id + '" id="combo_item_price_' + row_no + '" onClick="this.select();"></td>';
                tr_html += '<td class="text-center"><i class="fa fa-times tip del" id="' + row_no + '" title="Remove" style="cursor:pointer;"></i></td>';
                newTr.html(tr_html);
                newTr.prependTo("#prTable");
            });
            $('.item_' + item_id).addClass('warning');
            //audio_success.play();
            return true;

        }

        $(document).on('click', '.del', function () {
            var id = $(this).attr('id');
            delete items[id];
            $(this).closest('#row_' + id).remove();
        });
        var su = 2;
        $('#addSupplier').click(function () {
            if (su <= 5) {
                $('#supplier_1').select2('destroy');
                var html = '<div style="clear:both;height:15px;"></div><div class="row"><div class="col-md-8 col-sm-8 col-xs-8"><input type="hidden" name="supplier_' + su + '", class="form-control" id="supplier_' + su + '" placeholder="<?= lang("select") . ' ' . lang("supplier") ?>" style="width:100%;display: block !important;" /></div><div class="col-md-4 col-sm-4 col-xs-4"><input type="text" name="supplier_' + su + '_price" class="form-control tip" id="supplier_' + su + '_price" placeholder="<?= lang('supplier_price') ?>" /></div></div>';
                $('#ex-suppliers').append(html);
                var sup = $('#supplier_' + su);
                suppliers(sup);
                su++;
            } else {
                bootbox.alert('<?= lang('max_reached') ?>');
                return false;
            }
        });

        var _URL = window.URL || window.webkitURL;
        $("input#images").on('change.bs.fileinput', function () {
            var ele = document.getElementById($(this).attr('id'));
            var result = ele.files;
            $('#img-details').empty();
            for (var x = 0; x < result.length; x++) {
                var fle = result[x];
                for (var i = 0; i <= result.length; i++) {
                    var img = new Image();
                    img.onload = (function (value) {
                        return function () {
                            ctx[value].drawImage(result[value], 0, 0);
                        }
                    })(i);
                    img.src = 'images/' + result[i];
                }
            }
        });
        var variants = <?=json_encode($product->cf4);?>;
        // $('#attributesInput').select2('data',variants)

        $(".select-tags").select2({
            tags: variants,
            tokenSeparators: [","],
            multiple: true
        });
        $(document).on('ifChecked', '#attributes', function (e) {
            $('#attr-con').slideDown();
        });
        $(document).on('ifUnchecked', '#attributes', function (e) {
            $(".select-tags").select2("val", "");
            $('.attr-remove-all').trigger('click');
            $('#attr-con').slideUp();
        });

        $(document).on('ifChecked', '#attrConfig', function (e) {
            $('#attr-config').slideDown();
        });
        $(document).on('ifUnchecked', '#attrConfig', function (e) {
            $(".select-tags-config").select2("val", "");
            $('.attr-remove-all-config').trigger('click');
            $('#attr-config').slideUp();
        });
        $('#addAttributes').click(function (e) {
            e.preventDefault();
            var attrs_val = $('#attributesInput').val(), attrs;
            var percent=Math.round(100/attrs_val.length,1);
            for (var i in attrs_val) {
                if (attrs_val[i] !== '') {
                    $('#attrTable').show().append('<tr class="attr"><td><input type="hidden" name="attr_name[]" value="' + attrs_val[i] + '"><span>' + attrs_val[i] + '</span></td><td><input type="text" class="form-control" name="attr_percent[]" value="' + 0 + '"></td><td class="text-center"><i class="fa fa-times delAttr"></i></td></tr>');
                }
            }
        });

        $('#addAttrConfig').click(function (e) {
            e.preventDefault();
            var attrs_val = $('#attrConfigInput').val(), attrs;
            var data = $('#attrConfigInput').select2('data')

            for (var i in data) {
                if (data[i].id !== '') {
                    $('#attrTableConfig').show().append('<tr class="attrconfig"><td><input type="hidden" name="attr_id[]" value="' + data[i].id + '"><input type="hidden" name="attr_item[]" value="' + data[i].text + '"><span>' + data[i].text + '</span></td><td class="text-center"><input type="hidden" name="attr_quantity[]" value="' + 1.00 + '"><span>' + 1.00 + '</span></td><td class="text-center"><i class="fa fa-times delAttrConfig"></i></td></tr>');
                }
            }
        });

        $(document).on('click', '.delAttr', function () {
            $(this).closest("tr").remove();
        });

        $(document).on('click', '.delAttrConfig', function () {
            $(this).closest("tr").remove();
        });
        $(document).on('click', '.attr-remove-all', function () {
            $('#attrTable tbody').empty();
            $('#attrTable').hide();
        });
        $(document).on('click', '.attr-remove-all-config', function () {
            $('#attrTableConfig tbody').empty();
            $('#attrTableConfig').hide();
        });
        var row, warehouses = <?= json_encode($warehouses); ?>;
        $(document).on('click', '.attrconfig td:not(:last-child)', function () {
            row = $(this).closest("tr");
            $('#aModalLabel').text(row.children().eq(0).find('span').text());
            $('#aquantity').val(row.children().eq(1).find('span').text());
            $('#aitem').val(row.children().eq(0).find('span').text());
            $('#aModal').appendTo('body').modal('show');
        });

        $(document).on('click', '#updateAttr', function () {
            row.children().eq(1).html('<input type="hidden" name="attr_quantity[]" value="' + $('#aquantity').val() + '"><span>' + decimalFormat($('#aquantity').val()) + '</span>');
            $('#aModal').modal('hide');
        });
    });

    <?php if ($product) { ?>
    $(document).ready(function () {
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
        // $("#code").parent('.form-group').addClass("has-error");
        $("#code").focus();
        $("#product_image").parent('.form-group').addClass("text-warning");
        $("#images").parent('.form-group').addClass("text-warning");
        // $.ajax({
        //     type: "get", async: false,
        //     url: "<?= site_url('products/getSubCategories') ?>/" + <?= $product->category_id ?>,
        //     dataType: "json",
        //     success: function (scdata) {
        //         if (scdata != null) {
        //             $("#subcategory").select2("destroy").empty().attr("placeholder", "<?= lang('select_subcategory') ?>").select2({
        //                 placeholder: "<?= lang('select_category_to_load') ?>",
        //                 data: scdata
        //             });
        //         }
        //     }
        // });
        <?php if ($product->supplier1) { ?>
        select_supplier('supplier1', "<?= $product->supplier1; ?>");
        $('#supplier_price').val("<?= $product->supplier1price == 0 ? '' : $this->sma->formatDecimal($product->supplier1price); ?>");
        <?php } ?>
        <?php if ($product->supplier2) { ?>
        $('#addSupplier').click();
        select_supplier('supplier_2', "<?= $product->supplier2; ?>");
        $('#supplier_2_price').val("<?= $product->supplier2price == 0 ? '' : $this->sma->formatDecimal($product->supplier2price); ?>");
        <?php } ?>
        <?php if ($product->supplier3) { ?>
        $('#addSupplier').click();
        select_supplier('supplier_3', "<?= $product->supplier3; ?>");
        $('#supplier_3_price').val("<?= $product->supplier3price == 0 ? '' : $this->sma->formatDecimal($product->supplier3price); ?>");
        <?php } ?>
        <?php if ($product->supplier4) { ?>
        $('#addSupplier').click();
        select_supplier('supplier_4', "<?= $product->supplier4; ?>");
        $('#supplier_4_price').val("<?= $product->supplier4price == 0 ? '' : $this->sma->formatDecimal($product->supplier4price); ?>");
        <?php } ?>
        <?php if ($product->supplier5) { ?>
        $('#addSupplier').click();
        select_supplier('supplier_5', "<?= $product->supplier5; ?>");
        $('#supplier_5_price').val("<?= $product->supplier5price == 0 ? '' : $this->sma->formatDecimal($product->supplier5price); ?>");
        <?php } ?>
        function select_supplier(id, v) {
            $('#' + id).val(v).select2({
                minimumInputLength: 1,
                data: [],
                initSelection: function (element, callback) {
                    $.ajax({
                        type: "get", async: false,
                        url: "<?= site_url('suppliers/getSupplier') ?>/" + $(element).val(),
                        dataType: "json",
                        success: function (data) {
                            callback(data[0]);
                        }
                    });
                },
                ajax: {
                    url: site.base_url + "suppliers/suggestions",
                    dataType: 'json',
                    quietMillis: 15,
                    data: function (term, page) {
                        return {
                            term: term,
                            limit: 10
                        };
                    },
                    results: function (data, page) {
                        if (data.results != null) {
                            return {results: data.results};
                        } else {
                            return {results: [{id: '', text: 'No Match Found'}]};
                        }
                    }
                }
            });//.select2("val", "<?= $product->supplier1; ?>");
        }

        var whs = $('.wh');
        $.each(whs, function () {
            $(this).val($('#r' + $(this).attr('id')).text());
        });
    });
    <?php } ?>
</script>

<div class="modal" id="aModal" tabindex="-1" role="dialog" aria-labelledby="aModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i
                            class="fa fa-2x">&times;</i></span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="aModalLabel"><?= lang('add_product_manually') ?></h4>
            </div>
            <div class="modal-body" id="pr_popover_content">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="aitem" class="col-sm-4 control-label"><?= lang('Nguyên vật liệu') ?></label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="aitem" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="aquantity" class="col-sm-4 control-label"><?= lang('quantity') ?></label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="aquantity">
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="updateAttr"><?= lang('submit') ?></button>
            </div>
        </div>
    </div>
</div>

<style type="text/css">
    .text-right{text-align:right;}
</style>

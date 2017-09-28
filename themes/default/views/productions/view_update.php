<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?php echo lang('Cập nhật tiến độ'); ?></h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("productions/view_update/".$id, $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>
            <div class="form-group">
                <?= lang("Sản phẩm", "product_id") ?>
                <?php
                $cat[''] = "";
                foreach ($rows as $category) {
                    $cat[$category->product_id] = $category->product_name ;
                }
                echo form_dropdown('product_id', $cat, (isset($_POST['product_id']) ? $_POST['product_id'] : ($product ? $product->product_id_id : '')), 'class="form-control select" id="product_id" placeholder="' . lang("select") . " " . lang("Thành phẩm") . '"  style="width:100%" required="required"')
                ?>
            </div>
            <div>
                <?php
                    // echo "<pre>";
                    // print_r($inv);
                    // echo "</pre>";
                 ?>
            </div>
            <div class="form-group">
                <?= lang("Đợt giao hàng", "delivery_id") ?>
                <?php
                $cat=array();
                $cat[''] = "";
                $i=1;
                foreach ($deliveries as $delivery) {
                    $cat[$delivery->id] ="Đợt ".$i." (".$this->sma->hrsd($delivery->delivery_date_start)."-".$this->sma->hrsd($delivery->delivery_date_end).")" ;
                    $i++;
                }
                echo form_dropdown('delivery_id', $cat, (isset($_POST['product_id']) ? $_POST['product_id'] : ($product ? $product->product_id_id : '')), 'class="form-control select" id="delivery_id" placeholder="' . lang("select") . " " . lang("Thành phẩm") . '"  style="width:100%" required="required"')
                ?>
            </div>

            <div class="form-group">
                <?= lang("Giai đoạn", "stage_id") ?>
                <div class="controls"> <?php
                    echo form_input('stage_id', ($product ? $product->subcategory_id : ''), 'class="form-control" id="stage_id"  placeholder="' . lang("Chọn thành phẩm") . '" required="required"');
                    ?>
                </div>
            </div>

            <div class="form-group inline">
                <input type="radio" class="radio" name="stage_status"
                       id="not_start" value="0" checked="checked">
               <label for="not_start"  class="padding05"><?= lang('Chưa bắt đầu'); ?></label>
               <input type="radio" class="radio" name="stage_status"
                       id="pending" value="1">
               <label for="pending"  class="padding05"><?= lang('Đang xử lý'); ?></label>
               <input type="radio" class="radio" name="stage_status"
                       id="completed" value="2">
               <label for="stage_status"  class="padding05"><?= lang('Hoàn thành'); ?></label>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                    <?= lang("date", "sldate"); ?>
                    <?php echo form_input('date', (isset($_POST['date']) ? $_POST['date'] : ""), 'class="form-control input-tip date" id="sldate" required="required"'); ?>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group quantity" style="display: none">
                            <?= lang("Số lượng hoàn thành", "quantity") ?> <label id="lblquantity"></label>
                            <div class="controls"> <?php
                                echo form_input('quantity', ($product ? $product->subcategory_id : ''), 'class="form-control" id="quantity"  placeholder="' . lang("Số lượng") . '"');

                                ?>
                                <span class="notehidden" style="visibility: hidden;color: red">Không được quá </span>
                            </div>
                            <div style="display: none">
                            <?= lang("Số lượng lỗi", "error_quantity") ?>
                            <div class="controls"> <?php
                                echo form_input('error_quantity', ($product ? $product->subcategory_id : ''), 'class="form-control" id="error_quantity" readonly  placeholder="' . lang("Số lượng") . '"');
                                ?>
                            </div>
                            </div>
                    </div>
                    <div id="check-completed" class="form-group" style="display: none;">
                        <label>Số lượng đã hoàn thành</label>
                        <div class="controls">
                            <label id="current_completed" class="label label-success" style="font-size: 15px;"></label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <?= lang("Báo cáo", "note"); ?>
                <?php echo form_textarea('note', (isset($_POST['note']) ? $_POST['note'] : ""), 'class="form-control" id="note" style="margin-top: 10px; height: 100px;" required="required"'); ?>
            </div>
        </div>


            <div id="comment"></div>
        <div class="modal-footer">
            <?php echo form_submit('update_production', lang('Lưu'), 'class="btn btn-primary"'); ?>
        </div>
        </div>

    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" src="<?= $assets ?>js/custom.js"></script>
<?= $modal_js ?>
<script type="text/javascript">
    $(document).ready(function () {
        var current_quantity = 0;
        var quantity=0;
        $("#sldate").datetimepicker({
                format: site.dateFormats.js_ldate,
                fontAwesome: true,
                language: 'sma',
                weekStart: 1,
                todayBtn: 1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                forceParse: 0
            }).datetimepicker('update', new Date());
        $('#product_id,#delivery_id').change(function () {
            var v = $('#product_id').val();
            var delivery_id = $("#delivery_id option:checked").val();

            $('#current_completed').text('');
            $('#check-completed').slideUp();

            if (v && delivery_id) {

                var items=<?=$rowss?>;
                $.each(items, function( index, value ) {
                    if(value.product_id==v)
                    {
                        quantity=parseFloat(value.quantity);
                        $('#lblquantity').text('('+parseFloat(value.quantity)+')');

                        // $('#quantity').attr('max',1);
                    }
                });
                $.ajax({
                    type: "get",
                    async: false,
                    url: "<?= site_url('productions/getAllStagesNotNullDate') ?>/"+<?=$id?> + "/" + v
                    +"/"+ delivery_id,
                    dataType: "json",
                    success: function (scdata) {
                    console.log(v)
                        if (scdata != null) {

                            $("#stage_id").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn giai đoạn') ?>").select2({
                                placeholder: "<?= lang('Chọn giai đoạn') ?>",
                                data: scdata
                            });



                        }
                        else{
                            $("#stage_id").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn thành phẩm') ?>").select2({
                                placeholder: "<?= lang('Chọn thành phẩm') ?>",
                                data: [{id: '', text: '<?= lang('Chọn thành phẩm') ?>'}]
                            });
                        }
                    },
                    error: function () {
                        bootbox.alert('<?= lang('ajax_error') ?>');
                        $('#modal-loading').hide();
                    }

                });
            } else {
                $("#stage_id").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn thành phẩm') ?>").select2({
                    placeholder: "<?= lang('Chọn thành phẩm') ?>",
                    data: [{id: '', text: '<?= lang('Chọn thành phẩm') ?>'}]
                });
            }
            $('#modal-loading').hide();
        });

        $("#stage_id").change(function () {
            var stage_id = $(this).val();
            console.log(stage_id);
            var product = $("#product_id option:checked").val();
            var delivery_id = $("#delivery_id option:checked").val();
            var id = <?php echo $inv->id ?>;
            if (stage_id) {
                $.ajax({
                    type: "get",
                    url: "<?= site_url('productions/getStatus') ?>",
                    dataType: "json",
                    data:{
                        'id_stage':stage_id,
                        'id_product' : product,
                        'id_delivery' : delivery_id,
                        'id_pr' : id,
                    },
                    success: function (scdata) {
                        console.log(scdata);
                        if (scdata[0]['quantity'] == null) {
                            $('#current_completed').text(0);
                        }else{
                            $('#current_completed').text(scdata[0]['quantity']);
                        }

                        if(scdata['min']!= null && scdata['min']!= 0 ){
                            $('#lblquantity').text('('+scdata['min']+')');
                        }
                        else
                        {
                            //+scdata['completed']+'/'+quantity+
                            $('#lblquantity').text('('+quantity+')');
                        }

                        if(scdata[0]['stage_status'] == 'pending'){
                            $('.iradio_square-blue').removeClass('checked');
                            $('.iradio_square-blue').attr("aria-checked","false")
                            $('#not_start').removeAttr('checked');
                            $('#pending').parent().addClass('checked');
                            $('#pending').parent().attr("aria-checked","true");
                            $('.quantity').slideDown();
                        }
                    },


                });
            } else {
                $("#stage_id").select2("destroy").empty().attr("placeholder", "<?= lang('Chọn thành phẩm') ?>").select2({
                    placeholder: "<?= lang('Chọn thành phẩm') ?>",
                    data: [{id: '', text: '<?= lang('Chọn thành phẩm') ?>'}]
                });
            }
            $('#modal-loading').hide();
        });



        $(document).on('click', '.text-danger', function (e) {
            var id=$(this).parents('a').attr('data-id');
            var r = confirm('Bạn muốn xóa ghi chú này?');
            if (r == false) {
                return false;
            } else {
                $.get('<?=site_url()?>' + 'productions/remove_comment/' + id, function(response) {
                    if (response.success == true) {
                        // $(this).closest("tr").remove();
                        $('#TOData tr[data-id="'+ id +'"]').remove();

                    }
                }, 'json');
            }
        });


        $(document).on('ifChecked', '#pending', function (e) {
            $('.quantity').slideDown();
            $('#quantity').attr('required','required');
            // $('#error_quantity').attr('required','required');
        });
        $(document).on('ifUnchecked', '#pending', function (e) {
            $('.quantity').slideUp();
            $('#quantity').val('');
            // $('#error_quantity').val('');
            $('#quantity').removeAttr('required');
            // $('#error_quantity').removeAttr('required');
        });
        $(document).on('ifChecked', '#completed', function (e) {
            console.log('check');
            $('.quantity').slideUp();
            $('#quantity').val('');
            $('#quantity').removeAttr('required');

            $('#check-completed').slideDown();
        });
        $(document).on('ifUnchecked', '#completed', function (e) {
            $('#check-completed').slideUp();
        });


    });
</script>
<script type="text/javascript">
    $(document).keyup(function(e) {
    if (e.currentTarget.activeElement != undefined) {
     var input = $(e.currentTarget.activeElement).attr('id');
     var sol=$('#quantity').val();
     var slt = $('#lblquantity').text();
  }


   $('#quantity').keyup(function(){


    if($(this).val() <= parseFloat(slt.slice(1,4)))
    {
      $(this).css({"border":"1px solid #ccc"});
      $('.notehidden').css({"visibility":"hidden"});
      $('input[name="update_production"]').removeAttr('disabled');
    }

  })

});
</script>
<style type="text/css">
    .panel {
    border: 1px solid #ddd;
    background-color: #fcfcfc;
}
.panel .btn-group {
    margin: 15px 0 30px;
}
.panel .btn-group .btn {
    transition: background-color .3s ease;
}
.table-filter {
    background-color: #fff;
    border-bottom: 1px solid #eee;
}
.table-filter tbody tr:hover {
    cursor: pointer;
    background-color: #eee;
}
.table-filter tbody tr td {
    padding: 10px;
    vertical-align: middle;
    border-top-color: #eee;
}
.table-filter tbody tr.selected td {
    background-color: #eee;
}
.table-filter tr td:first-child {
    width: 38px;
}
.table-filter tr td:nth-child(2) {
    width: 35px;
}
.ckbox {
    position: relative;
}
.ckbox input[type="checkbox"] {
    opacity: 0;
}
.ckbox label {
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}
.ckbox label:before {
    content: '';
    top: 1px;
    left: 0;
    width: 18px;
    height: 18px;
    display: block;
    position: absolute;
    border-radius: 2px;
    border: 1px solid #bbb;
    background-color: #fff;
}
.ckbox input[type="checkbox"]:checked + label:before {
    border-color: #2BBCDE;
    background-color: #2BBCDE;
}
.ckbox input[type="checkbox"]:checked + label:after {
    top: 3px;
    left: 3.5px;
    content: '\e013';
    color: #fff;
    font-size: 11px;
    font-family: 'Glyphicons Halflings';
    position: absolute;
}
.table-filter .star {
    color: #ccc;
    text-align: center;
    display: block;
}
.table-filter .star.star-checked {
    color: #F0AD4E;
}
.table-filter .star:hover {
    color: #ccc;
}
.table-filter .star.star-checked:hover {
    color: #F0AD4E;
}
.table-filter .media-photo {
    width: 35px;
}
.table-filter .media-body {
    display: block;
    /* Had to use this style to force the div to expand (wasn't necessary with my bootstrap version 3.3.6) */
}
.table-filter .media-meta {
    font-size: 11px;
    color: #999;
}
.table-filter .media .title {
    color: #2BBCDE;
    font-size: 14px;
    font-weight: bold;
    line-height: normal;
    margin: 0;
}
.table-filter .media .title span {
    font-size: .8em;
    margin-right: 20px;
}
.table-filter .media .title span.pagado {
    color: #556055;
}
.table-filter .media .title span.pendiente {
    color: #f0ad4e;
}
.table-filter .media .title span.cancelado {
    color: #d9534f;
}
.table-filter .media .summary {
    font-size: 14px;
}
</style>

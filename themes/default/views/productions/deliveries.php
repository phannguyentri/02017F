
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Lịch sử giao nhận</h4>
        </div>

        <div class="modal-body">
                <div class="control-group table-group">
                    <div class="col-xs-5">
                        <p class="bold">
                            Lệnh sản xuất: <?=$production->reference_no ?><br>
                            Ngày tạo lệnh: <?=$production->date ?><br>
                            <br>

                        </p>
                    </div>

                    <?php if ($deliveries): ?>
                        <div class="controls table-controls">
                            <table id="slTable" class="table items table-striped table-bordered table-condensed table-hover">
                                <thead>
                                    <tr>
                                        <th>Tên sản phẩm</th>
                                        <th>Ngày giao hàng</th>
                                        <th>Số lượng giao</th>
                                        <th style="width: 30px !important; text-align: center;"><i class="fa fa-trash-o" style="opacity:0.5; filter:alpha(opacity=50);"></i></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php foreach ($deliveries as $value): ?>
                                    <tr id="<?=$value->id ?>">
                                        <td><?=$value->name ?></td>
                                        <td><?=$value->delivery_time ?></td>

                                        <td><?=$value->delivery_quantity ?></td>
                                        <td class="text-center" style="width: 8%;">
                                            <a href="<?=base_url().'productions/delete_delivery/'.$value->id ?>" class="po" title="Xóa đợt giao nhận" data-content="<p>Bạn có chắc không?</p><a class='btn btn-danger po-cancel' href='#' class='delete_deli' data-id='<?=$value->id ?>'>Vâng tôi chắc chắn</a> <button data-id='<?=$value->id ?>' class='btn po-close'>Không</button>" rel="popover"><i class="fa fa-trash-o"></i></a> <a href="<?=base_url() ?>productions/edit_delivery/<?=$value->id ?>" data-toggle="modal" data-target="#myModal2"><i class="fa fa-edit"></i> </a>
                                        </td>
                                        <!-- <th class="text-center"><a href="<?=base_url().'productions/delete_delivery/'.$value->id ?>" class="po" title="Xóa đợt giao nhận" data-content="<p>Bạn có chắc không?</p><a class='btn btn-danger po-cancel' href='<?=base_url().'productions/delete_delivery/'.$value->id ?>'>Vâng tôi chắc chắn</a> <button class='btn po-close'>Không</button>" rel="popover"><i class="fa fa-trash-o"></i></a></th> -->
                                    </tr>
                                <?php endforeach ?>

                                </tbody>
                                <tfoot>

                                </tfoot>
                            </table>
                        </div>

                    <?php else: ?>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button>Chưa có đợt giao nhận nào trong lệnh sản xuất <?=$production->reference_no ?></div>
                            </div>
                        </div>
                    <?php endif ?>

                </div>
        </div>

    </div>

</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('input[type="checkbox"],[type="radio"]').not('.skip').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });



    $(document).on('click','.po-cancel',function() {

            let a = $(this).val();
            console.log($(this).attr('data-id'));

            delivery_id = $(this).attr('data-id');
            $.ajax({
                type: 'get',
                url: '<?= site_url('productions/delete_delivery'); ?>/'+delivery_id,
                context: this,
                dataType: "json",
                data: {
                    delivery_id: delivery_id
                },
                success: function (response) {
                    console.log($('#'+delivery_id));
                    $('#'+delivery_id).remove();
                    $('.alert-danger').parent().remove();
                },
                error: function (request, error) {
                    alert(" Can't do because: " + error);
                },
            });


    });
</script>

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

                    <div class="controls table-controls">
                        <table id="slTable" class="table items table-striped table-bordered table-condensed table-hover">
                            <thead>
                                <tr>
                                    <th>Ngày bắt đầu</th>
                                    <th>Ngày giao hàng</th>
                                    <th>Trạng thái</th>
                                    <!-- <th style="width: 30px !important; text-align: center;"><i class="fa fa-trash-o" style="opacity:0.5; filter:alpha(opacity=50);"></i></th> -->
                                </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($deliveries as $value): ?>
                                <tr>
                                    <td><?=$value->delivery_date_start ?></td>
                                    <td><?=$value->delivery_date_end ?></td>
                                    <td class="text-center">
                                        <?php if ($value->delivery_status == 0): ?>
                                            <input type="checkbox" class="checkbox" name="delivery" attr-id="<?=$value->id ?>" attr-val="0">
                                        <?php else: ?>
                                            <input type="checkbox" class="checkbox" name="delivery" attr-id="<?=$value->id ?>" checked="checked" attr-val="1">
                                        <?php endif ?>

                                    </td>
                                </tr>
                            <?php endforeach ?>

                            </tbody>
                            <tfoot>

                            </tfoot>
                        </table>
                    </div>
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

    $('.checkbox').on('ifChecked', function (event) {
        delivery_id = $(this).attr('attr-id');
        current_status = $(this).attr('attr-val');
        console.log(current_status);

        $.ajax({
            type: 'get',
            url: '<?= site_url('productions/updateDelivery'); ?>',
            dataType: "json",
            context: this,
            data: {
                delivery_id: delivery_id,
                current_status: current_status
            },
            success: function (data) {
                $(this).attr('attr-val', 1);
                if (data.status_error == 0) {
                    bootbox.alert("Cập nhật thành công");
                }else{
                    bootbox.alert("Cập nhật thất bại");
                }

            }
        });

    });

    $('.checkbox').on('ifUnchecked', function (event) {

        delivery_id = $(this).attr('attr-id');
        current_status = $(this).attr('attr-val');

        $.ajax({
            type: 'get',
            url: '<?= site_url('productions/updateDelivery'); ?>',
            dataType: "json",
            context: this,
            data: {
                delivery_id: delivery_id,
                current_status: current_status
            },
            success: function (data) {
                $(this).attr('attr-val', 0);
                if (data.status_error == 0) {
                    bootbox.alert("Cập nhật thành công");
                }else{
                    bootbox.alert("Cập nhật thất bại");
                }

            }
        });

    });
</script>

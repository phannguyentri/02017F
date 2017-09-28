<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Lịch sử thanh toán</h4>
        </div>

        <div class="modal-body">
                <div class="control-group table-group">
                    <div class="col-xs-5">
                        <p class="bold">
                            Lệnh sản xuất: <?=$production->reference_no ?><br>
                            Ngày: <?=$production->date ?><br>
                            Trạng thái:
                                <?php
                                    if ($production->payment_status == 0) {
                                        echo "<span class='label label-warning'>Chưa thu đủ</span>";
                                    }else if($production->payment_status == 1){
                                        echo "<span class='label label-success'>Đã thanh toán</span>";
                                    }
                                 ?>

                            <br>

                        </p>
                    </div>

                    <div class="controls table-controls">
                        <table id="slTable" class="table items table-striped table-bordered table-condensed table-hover">
                            <thead>
                                <tr>
                                    <th>Ngày</th>
                                    <th>Hình thức thanh toán</th>
                                    <th>Số tiền</th>
                                    <th>Ghi chú</th>
                                    <th style="width: 30px !important; text-align: center;"><i class="fa fa-trash-o" style="opacity:0.5; filter:alpha(opacity=50);"></i></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($payments as $value): ?>
                                    <tr>
                                        <td><?=$value->date ?></td>
                                        <td>
                                            <?php
                                                if ($value->paid_by == 'cash') {
                                                    echo "Tiền mặt";
                                                }elseif($value->paid_by == 'CC'){
                                                    echo "Chuyển khoản";
                                                }elseif ($value->paid_by == 'visa') {
                                                    echo "Thẻ tín dụng";
                                                }
                                             ?>

                                        </td>
                                        <td class="amount" attr-amount="<?=$value->amount?>"><?=number_format($value->amount) ?></td>
                                        <td><?=$value->note ?></td>
                                        <td><i class="fa fa-times tip pointer sldel" id="<?=$value->id?>" title="Remove" style="cursor:pointer;"></i></td>
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
    $(document).on('click', '.sldel', function () {
        var row = $(this).closest('tr');
        payment_id = row.find('.sldel').attr('id');
        amount = row.find('.amount').attr('attr-amount');

        $.ajax({
            type: 'get',
            url: '<?= site_url('productions/deletePayment'); ?>',
            dataType: "json",
            data: {
                payment_id: payment_id,
                production_id : <?=$production->id ?>
            },
            success: function (data) {
                if (data.status_error == 0) {
                    bootbox.alert("Xóa thanh toán thành công");
                }else{
                    bootbox.alert("Xóa thất bại");
                }

            }
        });

        row.remove();

    });



</script>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Thông tin nguyên vật liệu cần xuất</h4>
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

                <?php if ($status): ?>
                    <?php if (!empty($group_material_norms)): ?>
                        <div class="controls table-controls">
                            <table id="slTable" class="table items table-striped table-bordered table-condensed table-hover">
                                <thead>
                                    <tr>
                                        <th>Mã nguyên vật liệu</th>
                                        <th>Tên nguyên vật liệu</th>
                                        <th>Số lượng có sẵn</th>
                                        <th>Số lượng cần</th>
                                        <th>Số lượng cần xuất kho</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php foreach ($group_material_norms as $material): ?>
                                    <tr>
                                        <td><?=$material->item_code ?></td>
                                        <td><?=$material->item ?></td>
                                        <td class='right'><?=$this->sma->formatMoney($material->available) ?></td>
                                        <td class='right'><?=$this->sma->formatMoney($material->total_quantity1) ?></td>
                                        <td class='right'><b><?=$this->sma->formatMoney($material->quantity_need_ex) ?></b></td>
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
                            <div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button><b>Đơn hàng sản xuất này chưa có bán sản phẩm nào được đưa vào kế hoạch sản xuất.</br>Bấm xác nhận để tiếp tục!</b></div>
                        </div>
                        </div>
                    <?php endif ?>

                <?php else: ?>
                    <div class="col-md-12">
                        <div class="alert alert-warning"><button type="button" class="close" data-dismiss="alert">×</button><b>Đơn hàng sản xuất này đã được đưa vào sản xuất.</b></div>
                    </div>
                <?php endif ?>

            </div>

        </div>
        <div class="modal-footer">
            <?php if ($status): ?>
                <?php echo form_open("productions/updateStatusProduction/".$id); ?>
                    <input type="submit" name="confirm" id="confirm" value="Xác nhận" class="btn btn-success">
                <?php echo form_close(); ?>

            <?php endif ?>
        </div>
    </div>

</div>

<script type="text/javascript"></script>

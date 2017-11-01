
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Thông tin nguyên vật liệu cần xuất</h4>
        </div>

        <div class="modal-body">
                <pre>
                <?php
                    print_r($group_material_norms);
                 ?>
                </pre>
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
                                        <th>Mã nguyên vật liệu</th>
                                        <th>Tên nguyên vật liệu</th>
                                        <th>Số lượng cần</th>
                                        <th>Số lượng có sẵn</th>
                                        <th>Số lượng còn lại</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php foreach ($deliveries as $value): ?>
                                    <tr id="<?=$value->id ?>">
                                        <td><?=$value->name ?></td>
                                        <td><?=$value->delivery_time ?></td>

                                        <td><?=$value->delivery_quantity ?></td>
                                        <td class="text-center"></td>
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

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Sửa giao nhận</h4>
        </div>

        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("productions/edit_delivery/".$id, $attrib); ?>
        <div class="modal-body">

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Ngày giao</label>
                        <?php echo form_input('delivery_time', $this->sma->hrsd($delivery->delivery_time), 'class="form-control input-tip date" id="date2" required="required"'); ?>
                    </div>
                </div>


                <div class="col-md-12">
                    <div class="controls table-controls">
                        <table id="slTable" class="table items table-striped table-bordered table-condensed table-hover">
                            <thead>
                                <tr>
                                    <th style="width: 65%;">Tên sản phẩm</th>
                                    <th>Số lượng giao</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <input type="hidden" name="product_id[]" value="71">
                                    <td><?=$delivery->name ?></td>
                                    <td>
                                        <input type="text" class="form-control quantity" data-name="<?=$delivery->name ?>" data-max="0" value="<?=$delivery->delivery_quantity ?>" name="quantity[]" required="">
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>

                            </tfoot>
                        </table>
                    </div>
                </div>


            </div>

        </div>


        <div id="comment"></div>
        <div class="modal-footer">
            <?php echo form_submit('update_production', lang('Lưu'), 'class="btn btn-primary"'); ?>
        </div>

        <?php echo form_close(); ?>
    </div>

</div>

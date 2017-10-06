<script type="text/javascript">
    // if (localStorage.getItem('date')) {
    //     localStorage.removeItem('date');
    // }
    // if (!localStorage.getItem('date')) {
    //     $("#date").datetimepicker('update', new Date());
    // }

</script>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Thêm giao nhận</h4>
        </div>

        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("productions/add_delivery/".$id, $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Ngày giao</label>
                        <?php echo form_input('delivery_time',$this->sma->hrsd(date("Y-m-d")),'class="form-control input-tip date" id="date2" required="required"'); ?>
                    </div>
                </div>

                <input type="hidden" name="production_id" value="<?=$id ?>">
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
                                <?php foreach ($products as $product): ?>
                                    <tr>
                                        <input type="hidden" name="product_id[]" value="<?=$product->product_id ?>">
                                        <td><?=$product->product_name ?></td>
                                        <?php
                                            $stages = $this->productions_model->getStage_ID($id, $product->product_id);
                                            $arr_quantity = array();
                                            foreach ($stages as $stage) {
                                                if ($stage->date_start && $stage->date_end) {
                                                    $arr_quantity[] = ($stage->quantity) ? $stage->quantity : 0;
                                                }
                                            }
                                            $real_completed = (min($arr_quantity)) ? (min($arr_quantity)) : 0;
                                         ?>
                                        <td>
                                            <input type="text" class="form-control quantity" data-name="<?=$product->product_name ?>" data-max="<?=$real_completed ?>" value="<?=$real_completed ?>" name="quantity[]" required>
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

            <div class="row">

            </div>

        </div>


        <div id="comment"></div>
        <div class="modal-footer">
            <?php echo form_submit('update_production', lang('Lưu'), 'class="btn btn-primary"'); ?>
        </div>

        <?php echo form_close(); ?>
    </div>

</div>
<script type="text/javascript">
    $(document).on('keyup', '.quantity', function () {

        if(Number.isInteger(parseInt($(this).val()))){
            if ($(this).val() >= 0) {
                if (parseInt($(this).val()) > parseInt($(this).attr('data-max'))) {
                    alert('Số lượng hoàn thành thực tế của '+$(this).attr('data-name')+' là '+$(this).attr('data-max')+', bạn không thể nhập số lớn hơn.');
                    $(this).val($(this).attr('data-max'));
                }
            }else{
                $(this).val($(this).attr('data-max'));
            }

        }else{
            $(this).val($(this).attr('data-max'));
        }

    });

</script>

<div class="modal-dialog modal-lg">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
        <h4 class="modal-title" id="myModalLabel"><?= $product->name; ?></h4>
    </div>
        <div class="modal-body">

            <div class="row">
                <div class="col-xs-5">
                    <img id="pr-image" src="<?= base_url() ?>assets/uploads/<?= $product->image ?>"
                    alt="<?= $product->name ?>" class="img-responsive img-thumbnail"/>

                    <div id="multiimages" class="padding10">
                        <?php if (!empty($images)) {
                            echo '<a class="img-thumbnail change_img" href="' . base_url() . 'assets/uploads/' . $product->image . '" style="margin-right:5px;"><img class="img-responsive" src="' . base_url() . 'assets/uploads/thumbs/' . $product->image . '" alt="' . $product->image . '" style="width:' . $Settings->twidth . 'px; height:' . $Settings->theight . 'px;" /></a>';
                            foreach ($images as $ph) {
                                echo '<a class="img-thumbnail change_img" href="' . base_url() . 'assets/uploads/' . $ph->photo . '" style="margin-right:5px;"><img class="img-responsive" src="' . base_url() . 'assets/uploads/thumbs/' . $ph->photo . '" alt="' . $ph->photo . '" style="width:' . $Settings->twidth . 'px; height:' . $Settings->theight . 'px;" /></a>';
                            }
                        }
                        ?>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="col-xs-7">
                    <div class="table-responsive">
                        <table class="table table-borderless table-striped dfTable table-right-left">
                            <tbody>
                                <tr>
                                    <td colspan="2" style="background-color:#FFF;"></td>
                                </tr>                                    
                                <tr>
                                    <td><?= lang("product_name"); ?></td>
                                    <td><?= $product->name; ?></td>
                                </tr>                                    
                                <tr>
                                    <td><?= lang("product_code"); ?></td>
                                    <td><?= $product->code; ?></td>
                                </tr>
                                <tr>
                                    <td><?= lang("Quy cách"); ?></td>
                                    <td><?= lang($product->cf1); ?></td>
                                </tr>
                                <tr>
                                    <td><?= lang("Trọng lượng"); ?></td>
                                    <td><?= $this->sma->formatNumber($product->cf2); ?></td>
                                </tr>
                                <tr>
                                    <td><?= lang("Đơn vị"); ?></td>
                                    <td><?= $product->unit; ?></td>
                                </tr>
                                <tr>
                                    <td><?= lang("quantity"); ?></td>
                                    <td><?= $this->sma->formatNumber($product->quantity); ?></td>
                                </tr>
                                <tr>
                                    <td><?= lang("Nhân công"); ?></td>
                                    <td><?= $product->cf3; ?></td>
                                </tr>
                                <tr>
                                    <td><?= lang("Giá bán"); ?></td>
                                    <td><?= $this->sma->formatMoney($product->price); ?></td>
                                </tr>
                                

                                
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="clearfix"></div>   
                <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12">
                                <?php if ($product->cf4) { ?>
                                <h3 class="bold"><?= lang('Giai đoạn sản xuất') ?></h3>
                                <div class="table-responsive">
                                    <table
                                    class="table table-bordered table-striped table-condensed dfTable">
                                    <thead>
                                        <tr>
                                            <th><?= lang('STT') ?></th>
                                            <th><?= lang('name') ?></th>
                                            <th><?= lang('percent') ?></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                            for ($i=0; $i < count($product->cf4); $i++) { ?>
                                                <tr>
                                                    <th class="text-center" style="min-width: 100px;width: 100px"><?=$i+1?></th>
                                                    <th><?=$product->cf4[$i]->attr_name?></th>
                                                    <th><?=$product->cf4[$i]->attr_percent?></th>
                                                </tr>
                                            
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php } ?>

                            <?php if ($product->cf5) { ?>
                            <h3 class="bold"><?= lang('Định mức cấu thành') ?></h3>
                            <div class="table-responsive">
                                <table
                                class="table table-bordered table-striped table-condensed dfTable ">
                                <thead>
                                    <tr>
                                        <th><?= lang('STT') ?></th>
                                        <th><?= lang('Nguyuyên vật liệu'); ?></th>
                                        <th><?= lang('quantity'); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $i=1; foreach ($product->cf5 as $item) {?>
                                    <tr>
                                        <th class="text-center"><?= $i++ ?></th>
                                        <th><?= $item->item ?></th>
                                        <th><?= $this->sma->formatNumber($item->quantity) ?></th>
                                    </tr>
                                    <?php } ?>
                                </tbody>
                            </table>
                        </div>
                        <?php } ?>
                    </div>
        </div>
    </div>                 

    <div class="col-xs-12">

        <?= $product->details ? '<div class="panel panel-success"><div class="panel-heading">' . lang('product_details_for_invoice') . '</div><div class="panel-body">' . $product->details . '</div></div>' : ''; ?>
        <?= $product->product_details ? '<div class="panel panel-primary"><div class="panel-heading">' . lang('product_details') . '</div><div class="panel-body">' . $product->product_details . '</div></div>' : ''; ?>

    </div>
</div>
<?php if (!$Supplier || !$Customer) { ?>
    <div class="buttons">
        <div class="btn-group btn-group-justified">
            <div class="btn-group">
                <a onclick="window.open('<?= site_url('products/single_barcode/' . $product->id) ?>', 'sma_popup', 'width=900,height=600,menubar=yes,scrollbars=yes,status=no,resizable=yes,screenx=0,screeny=0'); return false;"
                    href="#" class="tip btn btn-primary" title="<?= lang('barcode') ?>">
                    <i class="fa fa-print"></i>
                    <span class="hidden-sm hidden-xs"><?= lang('print_barcode') ?></span>
                </a>
            </div>
            <div class="btn-group">
                <a onclick="window.open('<?= site_url('products/single_label/' . $product->id) ?>', 'sma_popup', 'width=900,height=600,menubar=yes,scrollbars=yes,status=no,resizable=yes,screenx=0,screeny=0'); return false;"
                    href="#" class="tip btn btn-primary" title="<?= lang('label') ?>">
                    <i class="fa fa-print"></i>
                    <span class="hidden-sm hidden-xs"><?= lang('print_label') ?></span>
                </a>
            </div>
            <!-- <div class="btn-group">
                <a onclick="window.open('<?= site_url('products/single_label2/' . $product->id) ?>', 'sma_popup', 'width=900,height=600,menubar=yes,scrollbars=yes,status=no,resizable=yes,screenx=0,screeny=0'); return false;"
                    href="#" class="tip btn btn-primary" title="<?= lang('label_printer') ?>">
                    <i class="fa fa-print"></i>
                    <span class="hidden-sm hidden-xs"><?= lang('label_printer') ?></span>
                </a>
            </div> -->
            <div class="btn-group">
                <a href="<?= site_url('products/pdf/' . $product->id) ?>" class="tip btn btn-primary" title="<?= lang('pdf') ?>">
                    <i class="fa fa-download"></i>
                    <span class="hidden-sm hidden-xs"><?= lang('pdf') ?></span>
                </a>
            </div>
            <?php if($product->type == 'standard') { ?>
                <div class="btn-group"><a data-target="#myModal2" data-toggle="modal"
                    href="<?= site_url('products/add_adjustment/' . $product->id) ?>"
                    class="tip btn btn-warning" title="<?= lang('adjust_quantity') ?>"><i
                    class="fa fa-filter"></i> <span
                    class="hidden-sm hidden-xs"><?= lang('adjust_quantity') ?></span>
                </a>
            </div>
            <?php } ?>
            <div class="btn-group">
                <a href="<?= site_url('products/edit/' . $product->id) ?>" class="tip btn btn-warning tip" title="<?= lang('edit_product') ?>">
                    <i class="fa fa-edit"></i>
                    <span class="hidden-sm hidden-xs"><?= lang('edit') ?></span>
                </a>
            </div>
            <div class="btn-group">
                <a href="#" class="tip btn btn-danger bpo" title="<b><?= $this->lang->line("delete_product") ?></b>"
                    data-content="<div style='width:150px;'><p><?= lang('r_u_sure') ?></p><a class='btn btn-danger' href='<?= site_url('products/delete/' . $product->id) ?>'><?= lang('i_m_sure') ?></a> <button class='btn bpo-close'><?= lang('no') ?></button></div>"
                    data-html="true" data-placement="top">
                    <i class="fa fa-trash-o"></i>
                    <span class="hidden-sm hidden-xs"><?= lang('delete') ?></span>
                </a>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    $(document).ready(function () {
        $('.tip').tooltip();
    });
    </script>
<?php } ?>
</div>
</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $('.change_img').click(function(event) {
        event.preventDefault();
        var img_src = $(this).attr('href');
        $('#pr-image').attr('src', img_src);
        return false;
    });
});
</script>

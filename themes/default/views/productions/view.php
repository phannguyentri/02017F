<script type="text/javascript">
   $(document).ready(function () {
       $(document).on('click', '.sledit', function (e) {
           if (localStorage.getItem('slitems')) {
               e.preventDefault();
               var href = $(this).attr('href');
               bootbox.confirm("<?=lang('you_will_loss_sale_data')?>", function (result) {
                   if (result) {
                       window.location.href = href;
                   }
               });
           }
       });
   });
</script>
<?php
   foreach ($rows as $row) {
       $products[] = $row->product_name;
       $quantity[] = (($row->min/$row->quantity)*100);

   }
   ?>
<style type="text/css">
   g.highcharts-legend{display: none;}
   .collapse1:hover{cursor: pointer;}
   tr.borders{
   border-style:solid 1px ;
   border-color: red
   }
   .width20{
   width: 20% !important;
   white-space: nowrap;
   padding: 0px !important;
   }
   .border_item{
   border: 1px solid #ccc;
   padding: 5px 0px;
   }
</style>
<div class="box">
   <div class="box-header">
      <h2 class="blue"><i class="fa-fw fa fa-file"></i><?= lang("Lệnh sản xuất") . ' ' . $inv->reference_no; ?></h2>
   </div>
   <div class="box-content" id="hight">
      <div class="row">
         <div class="col-lg-12">
            <ul id="myTab" class="nav nav-tabs">
               <li class=""><a href="#proccess-con" class="tab-grey"><?= lang('Tiến độ') ?></a></li>
               <li class=""><a href="#material-norms" class="tab-grey">Kế hoạch nguyên vật liệu</a></li>
               <li class=""><a href="#report-con" class="tab-grey"><?= lang('Báo cáo') ?></a></li>
               <li class=""><a href="#statistics-con" class="tab-grey"><?= lang('Thống kê') ?></a></li>

            </ul>
            <div class="tab-content">
               <div id="report-con" class="tab-pane fade in">
                  <!-- Start -->
                  <div class="box-content">
                     <!-- row -->
                     <div class="row"  id="<?=$item->id_due?>">
                        <div class="table-responsive"  style="overflow-x: scroll;min-height: 300px;  max-width: 1800px;display: auto;overflow-y: hidden;height: auto;">
                           <table width="100%" border="1" cellspacing="0" cellpadding="15" class="table table-bordered">
                              <tr>
                                 <td colspan="<?php echo $sum_row ?>" align="center" bgcolor="green" scope="col"><strong style="color:#fff"><?=lang('Báo cáo tiến độ sản xuất')?></strong> <a style="float: left" href="#" id="xls" class="xls tip" title="" data-original-title="Tải về dạng XLS"><i class="icon fa fa-file-excel-o" style="background: #428bca; color: #fff; font-size: 20px;  margin-left: 9px;"></i></a>
                                    <a style="float: right" href="#" id="xls1" class="tip xls" title="" data-original-title="Tải về dạng XLS"><i class="icon fa fa-file-excel-o" style="background: #428bca; color: #fff; font-size: 20px;  margin-left: 9px;"></i></a>
                                 </td>
                              </tr>
                              <tr>
                                 <td colspan="<?php echo $sum_row ?>" >&nbsp;</td>
                              </tr>
                              <tr class="borders">
                                 <td rowspan="3" bgcolor="#D7E4BC" style="white-space: nowrap"><b>TT</b></td>
                                 <td rowspan="3" bgcolor="#D7E4BC" style="white-space: nowrap"><b>Tên chi tiết</b></td>
                                 <td rowspan="3" class="width20" bgcolor="#D7E4BC" style="white-space: nowrap"><b>ĐVT</b></td>
                                 <td rowspan="2" colspan="4" align="center" bgcolor="#D7E4BC" style="white-space: nowrap"><b>Chiết tính cho 01 bộ</b></td>
                                 <td rowspan="3" bgcolor="#D7E4BC" style="white-space: nowrap"><b>Số lượng bộ</b></td>
                                 <td rowspan="3" align="center" bgcolor="#D7E4BC" style="white-space: nowrap"><strong>Tổng số chi tiết</strong></td>
                                 <td rowspan="3" align="center" bgcolor="#D7E4BC" style="white-space: nowrap"><b>Tổng khối lượng</b></td>
                                 <td colspan="<?php echo count($variants) ?>" align="center" bgcolor="#9BBB59" style="white-space: nowrap"><strong>Số lượng cộng dồn</strong></td>
                                 <td colspan="<?php echo count($variants) ?>" align="center" bgcolor="#B6DDE8" style="white-space: nowrap"><strong>Khối lượng</strong></td>
                                 <td rowspan="2" align="center" bgcolor="#CCCCCC" style="white-space: nowrap"><strong>Mức độ hoàn thành quy đổi</strong></td>
                              </tr>
                              <tr class="borders">
                                 <?php if($variants){ ?>
                                 <?php foreach ($variants as $key => $variant) { ?>
                                 <td style="white-space: nowrap" bgcolor="#9BBB59"><?php echo $variant->stage ?></td>
                                 <?php }}else{?>
                                 <td style="white-space: nowrap" bgcolor="#9BBB59"></td>
                                 <?php } ?>
                                 <?php if($variants){ ?>
                                 <?php foreach ($variants as $key => $variant) { ?>
                                 <td style="white-space: nowrap" bgcolor="#B6DDE8"><?php echo $variant->stage ?></td>
                                 <?php }}else{?>
                                 <td style="white-space: nowrap" bgcolor="#B6DDE8"></td>
                                 <?php } ?>
                              </tr>
                              <tr class="borders">
                                 <td style="white-space: nowrap">Qui cách</td>
                                 <td style="white-space: nowrap">Kích thước</td>
                                 <td style="white-space: nowrap">Số lượng</td>
                                 <td style="white-space: nowrap">Trọng lượng</td>
                                 <?php if($variants){ ?>
                                 <?php foreach ($variants as $key => $variant) { ?>

                                 <td style="white-space: nowrap"><?php echo $variant->stage_percent ?></td>
                                 <?php }}else{?>
                                 <td style="white-space: nowrap"></td>
                                 <?php } ?>
                                 <?php if($variants){ ?>
                                 <?php foreach ($variants as $key => $variant) { ?>
                                 <td style="white-space: nowrap"><?php echo $variant->stage_percent ?></td>
                                 <?php }}else{?>
                                 <td style="white-space: nowrap"></td>
                                 <?php } ?>
                                 <td style="color:red"><?php echo $this->sma->formatNumber($sum_WT['sum_weightt_comp']/$sum_WT['sum_weight_comp']) ?>%</td>
                              </tr>
                               <tr style="color: red">
                                <td colspan="6">Tổng </td>
                                <td><?php echo $this->sma->formatNumber($sum_WT['sum_weight_comp']) ?></td>
                                <td></td>
                                <td></td>
                                <td></td>

                                <?php if($sum_row_ > 1){ ?>
                                  <td colspan="<?php echo $sum_row_ ?>"></td>
                                  <?php }else{ ?>
                                  <td colspan="2"></td>
                                <?php } ?>
                                <td><?php echo $this->sma->formatNumber($sum_WT['sum_weightt_comp']) ?></td>
                              </tr>
                              <?php $i=1; foreach ($rows1 as $row2):?>

                              <?php $total_quantity_item = 0 ; ?>
                              <?php foreach ($items as $key => $value){
                                 $total_quantity_item += $value->weight;
                                 } ?>
                                <tr style="color: blue">
                                  <td class="text-center"><?php echo $i; ?></td>
                                  <td colspan="5"><?php echo $row2->name ?></td>
                                  <td><?php echo $this->sma->formatNumber($row2->totalW) ?></td>
                                  <td><?php echo $this->sma->formatNumber($row->quantity) ?></td>
                                  <td></td>
                                  <td><?php echo $this->sma->formatNumber($row2->totalW * $row->quantity) ?></td>
                                  <?php if($sum_row_ > 1){ ?>
                                  <td colspan="<?php echo $sum_row_ ?>"></td>
                                  <?php }else{ ?>
                                  <td colspan="2"></td>
                                  <?php } ?>
                                   <td><?php echo $this->sma->formatNumber($row2->totalWT) ?></td>
                                </tr>
                              <?php foreach ($row2->row as $key => $row) { ?>

                              <tr>
                                 <td></td>
                                 <td><?php echo $row->product_name; ?></td>
                                 <td>
                                    <?php echo  $row->unit ?>
                                 </td>
                                 <td> <?php echo  $row->cf1 ?></td>
                                 <td><?php echo  $row->cf7 ?></td>
                                 <td><?php echo $this->sma->formatNumber($row->quantity_config) ?></td>
                                 <td><?php echo  $this->sma->formatNumber($row->cf2) ?></td>
                                 <td><?php echo $this->sma->formatNumber($row->quantity) ?></td>
                                 <td><?php echo $this->sma->formatNumber($row->quantity_config * $row->quantity) ?></td>
                                 <td><?php echo $this->sma->formatNumber($row->cf2 * $row->quantity) ?></td>
                                 <?php if($row->stages2){ ?>
                                 <?php foreach ($row->stages2 as $key1 => $value1) { ?>
                                 <?php if($value1->stages1 && $value1->stages1->quantity && $value1->stages1->quantity !=0){ ?>
                                 <td><?php echo $this->sma->formatNumber($value1->stages1->quantity) ?></td>
                                 <?php  }else{ ?>
                                 <td><?php echo $this->sma->formatNumber(0)?></td>
                                 <?php }}}else{ ?>
                                 <td></td>
                                 <td></td>
                                 <?php } ?>
                                 <?php $totalC = 0; ?>
                                 <?php foreach ($row->stages2 as $key1 => $value1) { ?>
                                 <?php if($value1->stages1 && $value1->stages1->quantity && $value1->stages1->quantity !=0){
                                    $totalC += ($value1->stages1->quantity)*(($row->cf2 * $row->quantity)/($row->quantity_config * $row->quantity));
                                    ?>
                                 <td><?php echo $this->sma->formatNumber(($value1->stages1->quantity)*(($row->cf2 * $row->quantity)/($row->cf2 * $row->quantity_config))) ?></td>
                                 <?php  }else{ ?>
                                 <td><?php echo $this->sma->formatNumber(0)?></td>
                                 <?php }} ?>
                                 <td><?php echo $this->sma->formatNumber($totalC) ?></td>
                              </tr>

                            <?php } ?>

                              <?php $i++; endforeach; ?>
                              <!-- <tr>
                                 <td rowspan="2">Rest</td>
                                 <td rowspan="2">Misc</td>
                                 <td rowspan="2">Hotel</td>
                                 <td rowspan="2" bgcolor="#FDEADB"  style="white-space: nowrap">Guide Paid</td>
                                 <td rowspan="2">In/Salse</td>
                                 <td rowspan="2">Deposit</td>
                                 <td rowspan="2">Bus</td>
                                 <td rowspan="2" bgcolor="#FDEADB" style="white-space: nowrap">CompPaid</td>
                                 <td rowspan="2" bgcolor="#FFEBEB">Paid</td>
                                 <td><b style="color: #00B050">Optional</b></td>
                                 <td colspan="8" align="center" style="color: #00B050"><b>Shopping</b></td>
                                 <td><b style="color: #00B050">Land/Tip</b></td>
                                 <td rowspan="2" bgcolor="#D7E4BC">COLECTED</td>
                                 <td rowspan="2" align="center"  style="color: #00B050;font-weight: bold;">Company</td>
                                 <td style="color: fuchsia;white-space: nowrap ;font-weight: bold;" rowspan="2" align="center">Guide Com</td>
                                 <td style="white-space: nowrap ;font-weight: bold;" rowspan="2" align="center">G-Refund</td>
                                 <td style="white-space: nowrap ;font-weight: bold;" rowspan="2" align="center">CO-Refund</td>
                                 <td rowspan="2" bgcolor="#666666">&nbsp;</td>
                                 <td colspan="2" rowspan="2" bgcolor="#999999">PAGE</td>
                                 </tr> -->
                              <!-- <tr>
                                 <td  bgcolor="#92D050">&nbsp;</td>
                                 <td>M.Latex</td>
                                 <td style="white-space: nowrap">Big Bee</td>
                                 <td>M.Gems</td>
                                 <td>Leather</td>
                                 <td>R.Snake</td>
                                 <td>Yanawa</td>
                                 <td style="white-space: nowrap">Total Shop</td>
                                 <td>Credit</td>
                                 <td  bgcolor="#92D050">&nbsp;</td>-->
                              <!-- <td style="white-space: nowrap">G-Refund</td> -->
                              <!-- </tr>  -->
                              <!-- <?php foreach ($item->tour as $value) {?> -->
                              <!-- <tr>
                                 <td><?=$value['no']?></td>
                                 <td style="white-space: nowrap"><a href="<?=(!$value['status']) ? site_url('total/edit/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=$value['agency']?></a></td>
                                 <td style="white-space: nowrap"><a href="<?=(!$value['status']) ? site_url('total/edit/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=$value['code']?></a></td>
                                 <td style="white-space: nowrap"><a href="<?=(!$value['status']) ? site_url('total/edit/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=$value['guide']?></a></td>
                                 <td style="white-space: nowrap"><a href="<?=(!$value['status']) ? site_url('total/edit/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=$value['tour']?></a>
                                     <?php if($value['filename']){?>
                                     <div class="btn-group">
                                             <a download href="<?= site_url('tour/download/' . $value['filename']) ?>" class="tip btn btn-primary" title="<?= lang('attachment') ?>">
                                                 <i class="fa fa-chain"></i>
                                                 <span class="hidden-sm hidden-xs"><?= lang('attachment') ?></span>
                                             </a>
                                     </div>
                                     <?php } ?>

                                 </td>

                                 <td><a href="<?=(!$value['status']) ? site_url('restaurant/register/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['rest'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('miscellaneous/register/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['misc'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('hotel/register/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['hotel'])?></a></td>
                                 <td style="color: #C0504D;"><?=number_format($value['guidpaid'])?></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('insurance/register/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['insale'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('deposit/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['deposit'])?></a></td>
                                 <td><?=number_format($value['bus'])?></td>
                                 <td style="color: #C0504D;"><?=number_format($value['comppaid'])?></td>
                                 <td style="color: red; font-weight: bold;"><?=number_format($value['paid'])?></td>

                                 <td ><a style="color: #00B050;" href="<?=(!$value['status']) ? site_url('optional/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['optional'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('modernlatex/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['mlatex'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('bigbee/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['bigbee'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('modern_gems/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['mgems'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('queen_leather/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['leather'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('royal_snake/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['rsnake'])?></a></td>
                                 <td><a href="<?=(!$value['status']) ? site_url('yanawa/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['yannawa'])?></a></td>
                                 <td style="color: #00B050;"><?=number_format($value['totalshop'])?></td>
                                 <td><?=number_format($value['credit'])?></td>
                                 <td><a style="color: #00B050;" href="<?=(!$value['status']) ? site_url('land_tip/index/'.$value['id_tour']): 'javascript:void(0)' ?>"><?=number_format($value['landtip'])?></td>
                                 <td><?=number_format($value['collected'])?></td>

                                 <td><?=number_format($value['company'])?></td>
                                 <td><?=number_format($value['guidecom'])?></td>
                                 <td><?=number_format($value['grefund'])?></td>
                                 <td><?=number_format($value['corefund'])?></td>
                                 <td><?=number_format($value['con'])?></td>
                                 <td><?=$value['page1']?><a href="#" class="btn btn-success btn-xs">
                                 <span class="fa fa-print"></span> Print
                                 </a></td>
                                 <td><?=$value['page2']?><a href="#" class="btn btn-success btn-xs">
                                 <span class="fa fa-print"></span> Print
                                 </a></td>

                                 </tr> -->
                              <!-- <?php if(!$item->tour){?>
                                 <tr>
                                     <td colspan="32" align="center" class="info" style="font-weight: bold;color: green"><?= lang('loading_data_from_server') ?></td>
                                 </tr>
                                 <?php } ?>
                                 <?php }?> -->
                           </table>
                        </div>
                     </div>
                     <!-- row -->
                     <div id="result_due"></div>
                  </div>
                  <!-- End -->
               </div>
               <div id="proccess-con" class="tab-pane fade in">
                  <!-- <div class="row"> -->
                  <div class="col-xs-12" style="position: relative;">
                     <div class="col-xs-1"><i class="fa fa-3x fa-file-text-o padding010 text-muted"></i></div>
                     <div class="col-xs-8">
                        <h2 class=""><?= lang("Mã ĐH"); ?>: <?= $inv->reference_no; ?></h2>
                        <p style="font-weight:bold;"><?= lang("date"); ?>: <?= $this->sma->hrsd($inv->date); ?></p>
                        <p style="font-weight:bold;"><?= lang("Trạng thái"); ?>: <?= lang($inv->sale_status); ?></p>
                     </div>
                     <div class="col-xs-3" style="text-align: right;position: absolute;bottom: 10px;right: -10px;"><a class="btn btn-primary" href="http://localhost/02017F/productions/view_update/<?= $inv->id ?>" data-toggle="modal" data-target="#myModal"><i style="padding-right:15px;" class="fa fa-plus-circle"></i> Cập nhật tiến độ</a></div>
                     <div class="clearfix"></div>
                  </div>
                  <div class="table-responsive">
                    <?php
                      $arr_final_progress = array();
                     ?>
                     <table class="table table-bordered table-hover table-striped print-table order-table">
                        <thead>
                           <tr>
                              <th><?= lang("#"); ?></th>
                              <th><?= lang("Thành phẩm"); ?> (<?= lang("code"); ?>)</th>
                              <th>Số lượng cấu thành</th>
                              <th>Số lượng sản xuất</th>
                              <th>Tổng số chi tiết</th>
                              <th><?= lang("Nhân viên"); ?></th>
                              <th><?= lang("Tiến độ"); ?></th>
                              <th><?= lang("Trạng thái"); ?></th>
                           </tr>
                        </thead>
                        <tbody>
                           <?php $r = 1;
                              $tax_summary = array();
                              foreach ($rows as $row):
                                 ?>
                            <tr >

                              <td class="collapse1" data-id="demo<?=$row->id?>"  style="text-align:center; width:40px; vertical-align:middle;"><span class="fa fa-plus " data-id="demo<?=$row->id?>"></span>
                              </td>
                              <td style="vertical-align:middle;"><?= $row->product_name . " (" . $row->product_code . ")"?> </td>
                              <td style="width: 100px; text-align:center; vertical-align:middle;"><?=$this->sma->formatNumber($row->quantity_config)?></td>
                              <td style="width: 100px; text-align:center; vertical-align:middle;"><?= $this->sma->formatNumber($row->quantity); ?></td>
                              <?php
                                $total_detail = $row->quantity_config*$row->quantity;
                               ?>
                              <td style="width: 100px; text-align:center; vertical-align:middle;"><?= $this->sma->formatNumber($total_detail) ?></td>
                              <?php
                                  // echo "<pre>";
                                  // print_r($row);
                                  // echo "</pre>";
                                 $emps="";
                                 foreach ($row->employees as  $val) {
                                     $emps.=' <span class="label label-info">'.$val->employee.'</span>';
                                 }
                                 ?>

                               <?php
                                $list_emp = array();
                                // echo "<pre>";print_r($row->delivery_time[0]->stages3);echo "</pre>";
                                foreach ($row->delivery_time[0]->stages3 as $value) {
                                  $arr_emp = explode(',', $value->employee);
                                  $list_emp[] = $arr_emp;
                                }

                                $group_emp = array();
                                foreach ($list_emp as $value) {
                                  foreach ($value as $value2) {
                                    if (!in_array($value2, $group_emp)) {
                                      $group_emp[] = $value2;
                                    }
                                  }
                                }
                               ?>

                              <td style="text-align:center; vertical-align:middle;">
                                <?php
                                  $emps = array();
                                  foreach ($group_emp as $value) {
                                    $bl = $this->data['biller'] = $this->site->getCompanyByID($value);
                                    $emps[] = $bl->name;
                                  }
                                  echo implode(', ', $emps);
                                 ?>
                              </td>
                              <td style="width: 100px; text-align:center; vertical-align:middle;">
                                <?php
                                  $count_stages = 0;
                                  foreach ($row->delivery_time[0]->stages3 as $value) {
                                    if ($value->date_start != NULL && $value->date_end != NULL) {
                                      $count_stages++;
                                    }
                                  }

                                  // $count_stages = count($row->delivery_time[0]->stages3);
                                  $progress = 0;
                                  foreach ($row->delivery_time[0]->stages3 as $value) {
                                    $progress += ($value->quantity > $row->quantity) ? 100 : ($value->quantity/$row->quantity)*100;
                                  }
                                  $final_progress = ($progress/($count_stages*100))*100;
                                  echo number_format($final_progress,2)."%";
                                  $arr_final_progress[] = $final_progress;
                                ?>
                              </td>
                              <!-- pending -->
                              <?php
                                 // if($row->stage_status = $row->status =='completed')
                                 // {


                                   if($row->status=='completed')
                                      {
                                        $status='<div class="text-center"><span class="label label-success">Hoàn thành</span></div>';
                                      }
                                 // }
                                 // else{

                                   if($row->status=='pending')
                                      {
                                        $status='<div class="text-center"><span class="label label-warning">Đang xử lí</span></div>';
                                      }
                                 // }
                                 ?>
                              <td style="text-align:right; width:120px; padding-right:10px;"><?=$status?></td>
                           </tr>

                           <tr class="collegg" id="demo<?=$row->id?>"  style="display: none" >
                              <td class="active" colspan="8">
                                 <div class="table-responsive">
                                    <?php  foreach ($row->delivery_time as $value) {  ?>
                                    <table class="table-bordered table-hover table-striped" style="width: 98%; margin-left: 31px; border-bottom: 0px;  padding: 6px; background: #428bca; color: #fff; font-size: 25px;">
                                       <thead>
                                          <tr>
                                             <th class="center">Đợt: <?php echo $this->sma->hrsd($value->delivery_date_start).' - '.$this->sma->hrsd($value->delivery_date_end) ?></th>
                                          </tr>
                                       </thead>
                                    </table>
                                    <table class="table-bordered table-hover table-striped" style="width: 98%; margin-left: 31px; background-color: #bddad6;margin-bottom: 20px;">
                                       <thead>
                                          <tr>
                                             <th style="width: 35px;"><?= lang("#"); ?></th>
                                             <th style="width: 75px"><?= lang("Giai đoạn"); ?></th>
                                             <th><?= lang("Chi tiết"); ?></th>
                                          </tr>
                                       </thead>

                                       <?php $i=1; $percent = 0;
                                          foreach ($value->stages3 as $key => $value1) {
                                            if ($value1->date_start != NULL && $value1->date_end != NULL) {
                                        ?>
                                       <tbody>
                                          <tr>
                                             <td class="text-center"><?=$i?></td>
                                             <td><?php echo $value1->stage ?></td>
                                             <td>
                                                <table class="table table-borderless table-striped dfTable table-right-left">
                                                   <tbody>
                                                      <div class="col-md-6" style="padding-top:10px">
                                                         <div class="col-md-12" style="padding:0px;">
                                                            <div class="col-md-12" style="padding:0px;">
                                                               <?php
                                                                  $percent = ($value1->quantity/$total_detail)*100;
                                                                  $percent = ($percent >100) ? 100 : $percent;
                                                                  ?>
                                                               <div class="col-md-12" style="padding:0px; font-weight: bold;">
                                                                  Tiến độ:
                                                               </div>
                                                               <div class="progress col-md-12" style="padding:0px;">
                                                                  <div class="progress-bar col-md-12 progress-bar-striped progress-bar-animated active" role="progressbar"  aria-valuenow="<?=$percent?>" aria-valuemin="0" aria-valuemax="100" style="padding:0px; width:<?=$percent?>%;"> <?=number_format($percent, 2)?>%
                                                                  </div>
                                                               </div>
                                                            </div>
                                                         </div>
                                                         <div class="col-md-12" style="padding:0px;">
                                                            <div class="col-md-12" style="padding:0px; font-weight: bold;">Thời gian:</div>
                                                            <div class="col-md-12" style="padding:0px;">
                                                               <div class="col-md-6">
                                                                  <span style="font-weight: bold;">Bắt đầu:</span>
                                                                   <?=$this->sma->hrsd($value1->date_start)?>

                                                                </div>
                                                               <div class="col-md-6" ><span style="font-weight: bold;">Kết thúc:</span> <?=$this->sma->hrsd($value1->date_end)?></div>
                                                            </div>
                                                         </div>
                                                         <div class="col-md-12" style="padding:0px;">
                                                            <div class="col-md-12" style="padding:0px;">
                                                               <div class="col-md-12" style="padding:0px; font-weight: bold;">
                                                                <?php
                                                                // echo "<pre>";
                                                                // print_r($value1);
                                                                // echo "</pre>";
                                                                 ?>
                                                                Trạng thái:
                                                                  <?php
                                                                    if($value1->stage_status=='pending')
                                                                    {

                                                                      $TT='<div class="TT1" style="display:inline-block"><span class="label label-warning" >Đang xử lí</span></div>';
                                                                    }
                                                                    else if($value1->stage_status=='completed')
                                                                    {
                                                                      $TT='<div class="TT" style="display:inline-block"><span class="label label-success">Hoàn thành</span></div>';
                                                                    }else if($value1->stage_status=='not_start'){
                                                                      $TT='<div class="TT" style="display:inline-block"><span class="label label-danger">Chưa bắt đầu</span></div>';
                                                                    }else{
                                                                      $TT= "NULL";
                                                                    }
                                                                    echo $TT;
                                                                  ?>
                                                               </div>
                                                            </div>
                                                            <div class="col-md-12" style="padding:0px;"><span style="padding:0px; font-weight: bold;">Số lượng hoàn thành:</span> <?=($value1->quantity) ? $value1->quantity : 0?></div>
                                                            <!--  <div class="col-md-12">Số lượng lỗi: <?=$value1->error_quantity?></div> -->
                                                         </div>
                                                         <div class="col-md-12" style="padding:0px;">
                                                            <div class="col-md-12" style="padding:0px;">
                                                               <span style="padding:0px; font-weight: bold;">Nhân viên</span>:
                                                               <div class="table-container box_comment col-md-12" style="padding:0px;">

                                                               <?php
                                                                  $arr_emp = explode(',', $value1->employee);
                                                                  $list_emp[] = $arr_emp;
                                                                  foreach ($arr_emp as $emp) {
                                                                    $bl = $this->data['biller'] = $this->site->getCompanyByID($emp);
                                                                    ?>

                                                                    <div class="col-md-12 " data-id="82" style="padding:5px 0px; border-bottom: 1px solid #ccc;">
                                                                      <div class="media col-md-2" style="padding:0px;">
                                                                         <a href="javascript:void(0)" class="pull-left">
                                                                         <img style="width: 32px;height: 32px;" src="http://localhost/02017F/assets/images/male1.png" class="media-photo">
                                                                         </a>
                                                                      </div>
                                                                      <div class="media-body col-md-10" style="padding:0px;">
                                                                         <div class="summary col-md-4">
                                                                            <h4 class="title" style="display:inline-block; font-weight: bold">
                                                                               <span class="pull-right pagado"><?php echo $bl->name;?></span>
                                                                            </h4>
                                                                         </div>
                                                                      </div>
                                                                    </div>
                                                                <?php } ?>

                                                              </div>


                                                            </div>
</div>



                                                      </div>
                                                      <div class="col-md-6" style="padding-top:10px">
                                                         <div class="col-md-12" style="padding:0px;">
                                                            <div class="col-md-12" style="padding:0px; font-weight: bold;">
                                                               Báo cáo:
                                                            </div>
                                                            <div class="table-container box_comment col-md-12" style="padding:0px;">
                                                               <?php foreach ($value1->comments as $value2) {?>
                                                               <div class="col-md-12 " data-id="<?=$value1->id?>" style="padding:5px 0px;    border-bottom: 1px solid #ccc;">
                                                                  <div class="media col-md-2" style="padding:0px;">
                                                                     <a href="javascript:void(0)" class="pull-left">
                                                                     <img style=" width: 55px;height: 55px;" src="<?=base_url('assets/images/user-placeholder.jpg')?>" class="media-photo">
                                                                     </a>
                                                                  </div>
                                                                  <div class="media-body col-md-10" style="padding:0px;">
                                                                     <div class="summary col-md-4">
                                                                        <h4 class="title" style="display:inline-block;">
                                                                           <span class="pull-right pagado">(<?=$value2->user_name?>)</span>
                                                                        </h4>
                                                                     </div>
                                                                     <div class="summary col-md-4">
                                                                        <h4><?=str_replace(array("\r", "\n"), "", $this->sma->decode_html($value2->note))?></h4>
                                                                     </div>
                                                                     <div class="col-md-4">
                                                                        <h4 style="font-size: 13px;font-weight: bold; color: #636262" class="media-meta pull-right"><?=$this->sma->hrld($value2->date)?></h4>
                                                                     </div>
                                                                  </div>
                                                               </div>
                                                               <?php }?>
                                                            </div>
                                                         </div>
                                                      </div>
                                                      <div class="clear-fix"></div>
                                                   </tbody>
                                                </table>
                                             </td>
                                          </tr>
                                       </tbody>
                                       <?php $i++; }} ?>
                                    </table>
                                    <?php  } ?>
                                 </div>
                              </td>
                           </tr>
                           <?php
                              $r++;
                              endforeach;
                              ?>
                        </tbody>
                     </table>
                  </div>
                  <!-- </div> -->
               </div>










               <div id="material-norms" class="tab-pane fade in">
                  <div class="col-xs-12" style="position: relative;">
                     <div class="col-xs-1"><i class="fa fa-3x fa-file-text-o padding010 text-muted"></i></div>
                     <div class="col-xs-8">
                        <h2 class=""><?= lang("Mã ĐH"); ?>: <?= $inv->reference_no; ?></h2>
                        <p style="font-weight:bold;"><?= lang("date"); ?>: <?= $this->sma->hrsd($inv->date); ?></p>
                        <p style="font-weight:bold;"><?= lang("Trạng thái"); ?>: <?= lang($inv->sale_status); ?></p>
                     </div>
                     <div class="col-xs-3" style="text-align: right;position: absolute;bottom: 10px;right: -10px;"><a class="btn btn-primary" href="http://localhost/02017F/productions/view_update/<?= $inv->id ?>" data-toggle="modal" data-target="#myModal"><i style="padding-right:15px;" class="fa fa-plus-circle"></i> Cập nhật tiến độ</a></div>
                     <div class="clearfix"></div>
                  </div>

                  <div class="table-responsive">
                    <?php
                      $arr_final_progress = array();

                      $arr_purchases_id = array();
                      foreach ($enquiery as $value) {
                        if ($this->productions_model->getPurchasesByParentId($value)) {
                          foreach ($this->productions_model->getPurchasesByParentId($value) as $value2) {
                            $arr_purchases_id[] = $value2->id;
                          }
                        }
                      }

                     ?>

                     <?php
                      echo "<pre>";
                      print_r($material_norms);
                      echo "</pre>";


                      echo "<pre>";
                      print_r($inv->id);
                      echo "</pre>";

                      echo "<pre>";
                      $ids = $this->productions_model->getPurchasesByProductionId($inv->id);
                      print_r($this->productions_model->getPurchasesByParentArrayId($ids));
                      echo "</pre>";

                      ?>

                     <table class="table table-bordered table-hover table-striped print-table order-table">
                        <thead>
                           <tr>
                              <th>Tên nguyên vật liệu</th>
                              <th>Đơn giá</th>
                              <th>Số lượng cần sử dụng</th>
                              <th>Số lượng tồn kho</th>
                              <th>Số lượng cần thu mua</th>
                              <th>Ngày nhập</th>
                              <th>Số lượng đã thu mua</th>
                              <th>Trạng thái</th>
                           </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($material_norms as $value): ?>
                            <tr>
                                <td><?=$value->item ?></td>
                                <td><?=$this->sma->formatNumber($value->cost) ?></td>
                                <td><?=$this->sma->formatNumber($value->total_quantity) ?></td>
                                <td>
                                  <?php
                                    if ($value->total_quantity <= $value->items_quantity){
                                      $purchase = 0;
                                      echo $this->sma->formatNumber($value->total_quantity);
                                    }else{
                                      $purchase = $value->total_quantity - $value->items_quantity;
                                      echo $this->sma->formatNumber($value->items_quantity);
                                    }
                                   ?>
                                </td>
                                <td><?=$this->sma->formatNumber($purchase) ?></td>
                                <td class="text-center">
                                  <?php
                                    if (!empty($arr_purchases_id)) {
                                    $final_purchases = $this->productions_model->getPurchasesJoinPurchaseItems($arr_purchases_id, $value->item_id);
                                      foreach ($final_purchases as $val) {
                                        echo $val->date."</br>";
                                      }
                                    }
                                  ?>


                                </td>
                                <td>
                                  <?php if ($purchase == 0): ?>
                                    <div class="text-center">
                                      <span class="label label-success">Đã đủ</span>
                                    </div>
                                  <?php else: ?>
                                    <div class="text-center">
                                      <span class="label label-warning">Chưa thu đủ</span>
                                    </div>
                                  <?php endif ?>
                                </td>
                            </tr>

                        <?php endforeach ?>
                        </tbody>
                      </table>
               </div>




               <div id="statistics-con" class="tab-pane fade in">
                  <div id="ov-chart" style="min-width: 100% ; max-width: 100%; height: 400px; margin: 0 auto"></div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<script src="<?= $assets; ?>js/hc/highcharts.js"></script>
<script type="text/javascript">
    console.log(<?= json_encode($products); ?>);
   $(function () {
           Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
               return {
                   radialGradient: {cx: 0.5, cy: 0.3, r: 0.7},
                   stops: [[0, color], [1, Highcharts.Color(color).brighten(-0.3).get('rgb')]]
               };
           });
           $width = $('#hight.box-content .row .tab-content').width()-50;

           $('#ov-chart').highcharts({
               shared: true,
               followPointer: true,
               chart: {type: 'bar',width: $width },
               credits: {enabled: false},
               title: {text: ''},
               xAxis: {categories: <?= json_encode($products); ?>},
               legend: {
                   layout: 'vertical',
                   align: 'right',
                   verticalAlign: 'top',
                   x: -40,
                   y: 80,
                   floating: true,
                   borderWidth: 1,
                   backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
                   shadow: true
               },

               plotOptions: {
                   bar: {
                       dataLabels: {
                           enabled: true
                       }
                   }
               },
               yAxis: {
                   min: 0,
                   title: {
                       text: 'Tiến độ hoàn thành (%)',
                       align: 'high'
                   },
                   labels: {
                       overflow: 'justify'
                   }
               },
               tooltip: {
                   valueSuffix: ' '
               },
               series: [{
                   name:'Tiến độ hoàn thành (%)',
                   data: [<?php echo implode(',', $arr_final_progress); ?>]
               }],
           });
       });

</script>
<script type="text/javascript">
   $('.collapse1').click(function(){
        $id = $(this).data('id');
       $('.collegg').css({"display": "none"});

       $('tr[id="'+$id+'"]').slideToggle();

   })
</script>
<style type="text/css">
   .table-right-left-new td { width: 16.666%; }
   .table-right-left-new td:nth-child(odd) { text-align: right;font-weight: bold; }
   .table-right-left-new td:nth-child(even) { text-align: left; }
   .progress-bar-mini {
   height: 10px!important;
   }
</style>
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
   .box_comment  .media-body .summary p {
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
   }
   .box_comment{ overflow-y: scroll;max-height: 200px; }
   .table-right-left td:nth-child(even) { text-align: left !important; font-weight: normal!important; }
   .table-right-left td:nth-child(odd) { text-align: right;font-style: italic; }
   }
</style>
<script type="text/javascript">
   $(document).ready(function () {

       $('.xls').click(function (event) {
           event.preventDefault();
           window.location.href = "<?=site_url('productions/view_process/0/xls/?v=1'.'&id='.$inv->id.'&xls=1')?>";
           return false;
       });

   });
</script>

<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Salaries extends MY_Controller
{

    function __construct()
    {
        parent::__construct();

        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            redirect('login');
        }

        $this->popup_attributes = array('width' => '900', 'height' => '600', 'window_name' => 'sma_popup', 'menubar' => 'yes', 'scrollbars' => 'yes', 'status' => 'no', 'resizable' => 'yes', 'screenx' => '0', 'screeny' => '0');
        $this->lang->load('settings', $this->Settings->language);
        $this->load->model('timekeepers_model');
        $this->load->library('form_validation');

        // $this->load->model('categories_model');
    }

    public function view(){

        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');
        $bc                  = array(
            array(
                'link' => base_url(),
                'page' => lang('home')
            ),
            array(
                'link' => '#',
                'page' => 'Tính lương'
            )
        );
        $meta = array(
            'page_title' => 'Tính lương',
            'bc' => $bc
        );

        $this->load->model('departments_model');
        $this->load->model('productions_model');

        $this->data['departments'] = $this->departments_model->getAllDepartments();

        $this->data['productions'] = $this->productions_model->getProductionByYearMonth(2017, 7);

        $this->page_construct('salaries/view', $meta, $this->data);
    }

    public function getAllTimekeeperDetails(){
        $this->load->model('productions_model');
        $this->load->model('departments_model');

        $department_id  = $this->input->get('department_id');
        $year           = $this->input->get('year');
        $month          = $this->input->get('month');

        $data['timekeeperDetailsName']  = $this->timekeepers_model->getTimekeeperDetailsName($department_id, $year, $month);
        $data['timekeeperDetails']      = $this->timekeepers_model->getTimekeeperDetails($department_id, $year, $month);
        $data['timekeeperDetailIds']    = $this->timekeepers_model->getTimekeeperDetailsId($department_id, $year, $month);
        $data['companyIds']             = $this->timekeepers_model->getCompanyIds($department_id, $year, $month);
        $data['efficiencys'] = $this->timekeepers_model->getTimekeeperDetailsEfficiency($department_id, $year, $month);

        $data['productionsInMonthYear'] = false;
        if ($this->departments_model->isProductionById($department_id)) {
            $data['productionsInMonthYear'] = $this->productions_model->getProductionByYearMonth($year, $month);
        }


        $data['basicSalaries']          = $this->timekeepers_model->getBasicCompanies($department_id, $year, $month);


        echo json_encode($data);
    }

    public function xls(){

        $department_id  = $this->input->get('department_id');
        $month          = $this->input->get('month');
        $year           = $this->input->get('year');


        if ($department_id && $month && $year) {
            $this->load->model('timekeepers_model');
            $this->load->model('productions_model');
            $this->load->model('departments_model');

            $dataCompanyId = $this->timekeepers_model->getCompanyIds($department_id, $year, $month);
            $dataName  = $this->timekeepers_model->getTimekeeperDetailsName($department_id, $year, $month);
            $dataEfficiency = $this->timekeepers_model->getTimekeeperDetailsEfficiency($department_id, $year, $month);
            $arrInfoCompanies = array();

            $onlyDayTimekeeperDetails = $this->timekeepers_model->getTimekeeperDetails($department_id, $year, $month);
            foreach ($dataCompanyId as $key => $val) {
                if ($key % 2 == 0) {
                    $hours = 0;

                    foreach ($onlyDayTimekeeperDetails[$key] as  $detail) {
                        $hours += $detail;
                    }

                    $arrInfoCompanies[$val->company_id] = array(
                        'name'          => $dataName[$key]->name,
                        'efficiency'    => $dataEfficiency[$key]->efficiency,
                        'workday'       => $hours/8
                    );
                }
            }

            $allInfoTimekeeperDetails = $this->timekeepers_model->getAllInfoTimekeeperDetails($department_id, $year, $month);

            // echo "<pre>";
            // print_r($arrInfoCompanies);
            // echo "</pre>";

            if ($this->departments_model->isProductionById($department_id)) {
                $productionsInMonthYear = $this->productions_model->getProductionByYearMonth($year, $month);
            }


            $this->load->library('excel');
            $this->excel->setActiveSheetIndex(0);

// Init Head
            $styleDefault = array(
                'font' => array(
                    'name' => "Times New Roman"
                ),
                'borders' => array(
                  'allborders' => array(
                      'style' => PHPExcel_Style_Border::BORDER_THIN
                  )
                ),
                'alignment' => array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                )
            );

            $styleHead = array(
                'font'  => array(
                    'bold'  => true,
                    'size'  => 12,
                    'name' => "Times New Roman"
                ),
                'alignment' => array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                ),
                'borders' => array(
                  'allborders' => array(
                      'style' => PHPExcel_Style_Border::BORDER_THIN
                  )
                )
            );

            $styleSub = array(
                'font'  => array(
                    'size'  => 12,
                    'name' => "Times New Roman"
                ),
                'alignment' => array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                ),
                'borders' => array(
                  'allborders' => array(
                      'style' => PHPExcel_Style_Border::BORDER_THIN
                  )
                )
            );

            $styleTitle = array(
                'font'  => array(
                    'bold'  => true,
                    'size'  => 15,
                    'name' => "Times New Roman"
                ),
                'alignment' => array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                ),
                'borders' => array(
                  'allborders' => array(
                      'style' => PHPExcel_Style_Border::BORDER_THIN
                  )
                )
            );

            $styleSunday = array(
                'font'  => array(
                    'name' => "Times New Roman"
                ),
                'fill' => array(
                    'type' => PHPExcel_Style_Fill::FILL_SOLID,
                    'color' => array('rgb' => '07ABEA')
                ),
                'borders' => array(
                  'allborders' => array(
                      'style' => PHPExcel_Style_Border::BORDER_THIN
                  )
                ),
                'alignment' => array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                )
            );

            $styleName = array(
                'font'  => array(
                    'color' => array('rgb' => '3c45f2'),
                    'bold'  => true,
                    'name' => "Times New Roman"
                ),
                'borders' => array(
                  'allborders' => array(
                      'style' => PHPExcel_Style_Border::BORDER_THIN
                  )
                ),
                'alignment' => array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_LEFT,
                    'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                )
            );

            $styleNameProduct = array(
                'font'  => array(
                    'name' => "Times New Roman"
                ),
                'borders' => array(
                    'allborders' => array(
                      'style' => PHPExcel_Style_Border::BORDER_THIN
                    )
                ),
                'alignment' => array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_LEFT,
                    'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                )
            );

            $this->excel->getDefaultStyle()->applyFromArray($styleDefault);
            $this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);

            $this->excel->getActiveSheet()->setTitle('Bảng tính lương');

            $this->excel->getActiveSheet()->SetCellValue('B1', 'Bảng tính lương tháng '.$month.' năm '.$year.' phòng ban');
            $this->excel->getActiveSheet()->mergeCells('B1:AF1');
            $this->excel->getActiveSheet()->getStyle("B1:AF1")->applyFromArray($styleTitle);


            $this->excel->getActiveSheet()->SetCellValue('B2', 'Ngày trong tháng');
            $this->excel->getActiveSheet()->mergeCells('B2:AF2');
            $this->excel->getActiveSheet()->getStyle("B2:AF2")->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->mergeCells('A1:A3');
            $this->excel->getActiveSheet()->SetCellValue('A1', 'Họ và tên');
            $this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(16);
            $this->excel->getActiveSheet()->getStyle('A1:A3')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AG2', 'Tổng cộng');
            $this->excel->getActiveSheet()->getColumnDimension('AG')->setWidth(12);
            $this->excel->getActiveSheet()->getStyle('AG2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AH2', 'Chủ nhật');
            $this->excel->getActiveSheet()->getColumnDimension('AH')->setWidth(12);
            $this->excel->getActiveSheet()->getStyle('AH2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AI2', 'Tăng ca');
            $this->excel->getActiveSheet()->getStyle('AI2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AJ2', 'Lễ');
            $this->excel->getActiveSheet()->getColumnDimension('AJ')->setWidth(6);
            $this->excel->getActiveSheet()->getStyle('AJ2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AK2', 'P');
            $this->excel->getActiveSheet()->getColumnDimension('AK')->setWidth(5);
            $this->excel->getActiveSheet()->getStyle('AK2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AL2', 'Ro');
            $this->excel->getActiveSheet()->getColumnDimension('AL')->setWidth(5);
            $this->excel->getActiveSheet()->getStyle('AL2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AM2', 'R');
            $this->excel->getActiveSheet()->getColumnDimension('AM')->setWidth(5);
            $this->excel->getActiveSheet()->getStyle('AM2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AN2', 'Ô');
            $this->excel->getActiveSheet()->getColumnDimension('AN')->setWidth(5);
            $this->excel->getActiveSheet()->getStyle('AN2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AO2', 'Đ');
            $this->excel->getActiveSheet()->getColumnDimension('AO')->setWidth(5);
            $this->excel->getActiveSheet()->getStyle('AO2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AP2', 'NB');
            $this->excel->getActiveSheet()->getColumnDimension('AP')->setWidth(5);
            $this->excel->getActiveSheet()->getStyle('AP2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AQ2', 'V');
            $this->excel->getActiveSheet()->getColumnDimension('AQ')->setWidth(5);
            $this->excel->getActiveSheet()->getStyle('AQ2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AR2', 'L');
            $this->excel->getActiveSheet()->getColumnDimension('AR')->setWidth(5);
            $this->excel->getActiveSheet()->getStyle('AR2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AS2', 'Lương cơ bản(VNĐ)');
            $this->excel->getActiveSheet()->getColumnDimension('AS')->setWidth(23);
            $this->excel->getActiveSheet()->getStyle('AS2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AT2', 'Tổng lương ngày công(VNĐ)');
            $this->excel->getActiveSheet()->getColumnDimension('AT')->setWidth(29);
            $this->excel->getActiveSheet()->getStyle('AT2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AU2', 'Tổng lương sản phẩm(VNĐ)');
            $this->excel->getActiveSheet()->getColumnDimension('AU')->setWidth(29);
            $this->excel->getActiveSheet()->getStyle('AU2')->applyFromArray($styleHead);

            $this->excel->getActiveSheet()->SetCellValue('AV2', 'Tổng lương(VNĐ)');
            $this->excel->getActiveSheet()->getColumnDimension('AV')->setWidth(20);
            $this->excel->getActiveSheet()->getStyle('AV2')->applyFromArray($styleHead);


            $ordColA = ord('A');
            $countHeadOnce = 1;
            $countHeadSecond = 0;

            for ($i=0; $i < 31; $i++) {
                if ($i < 25) {
                    $this->excel->getActiveSheet()->SetCellValue(chr($ordColA+$countHeadOnce).'3', $i+1);
                    $this->excel->getActiveSheet()->getColumnDimension(chr($ordColA+$countHeadOnce))->setWidth(5);
                    $countHeadOnce++;
                }else{
                    $this->excel->getActiveSheet()->SetCellValue('A'.chr($ordColA+$countHeadSecond).'3', $i+1);
                    $this->excel->getActiveSheet()->getColumnDimension('A'.chr($ordColA+$countHeadSecond))->setWidth(5);
                    $countHeadSecond++;
                }

            }
// END Init Head

// Init Rows
            $dayWork = 0;
            for ($i=0; $i < cal_days_in_month(CAL_GREGORIAN, $month, $year); $i++) {
                if (date("w",strtotime(($i+1).'-'.$month.'-'.$year)) != 0) {
                    $dayWork++;
                }
            }

            $countRow = 4;

            foreach ($allInfoTimekeeperDetails as $key => $detail) {
                $companyID = $detail->company_id;
                $countHeadOnceDetail = 1;
                $countHeadSecondDetail = 0;
                if ($key % 2 == 0) {
                    $p  = 0;
                    $ro = 0;
                    $r  = 0;
                    $d  = 0;
                    $v  = 0;
                    $l  = 0;
                    $this->excel->getActiveSheet()->SetCellValue('A'.$countRow, $detail->name);
                    $this->excel->getActiveSheet()->getStyle('A'.$countRow)->applyFromArray($styleName);
                    $this->excel->getActiveSheet()->SetCellValue('AS'.$countRow, $this->sma->formatMoney($detail->basic_salary));

                    $basicSalary = $detail->basic_salary;
                }

                $arrProductId = array();
                $allInfoProduct = array();

                if ($productionsInMonthYear) {
                  foreach ($productionsInMonthYear as $production) {
                    $empIds = explode(',', $production->employee);
                    foreach ($empIds as $emp) {
                      if ($emp == $companyID) {
                        if (!in_array($production->product_id, $arrProductId)) {
                          $arrProductId[] = $production->product_id;
                          $allInfoProduct[$production->product_id]['name'] = $production->product_name;
                          $allInfoProduct[$production->product_id]['quantity_config'] = $production->quantity_config;
                          $allInfoProduct[$production->product_id]['wage'] = $production->wage;
                        }
                      }
                    }
                  }
                }

                unset($detail->name);
                unset($detail->basic_salary);
                unset($detail->company_id);

                $salaryEachDay = $basicSalary/$dayWork;
                $i = 0;
                $hours = 0;
                $overTime = 0;
                $overTimeSunDay = 0;
                foreach ($detail as $keyDetail => $val) {
                    if($val == "P"){
                        $p++;
                    }elseif ($val == "Ro") {
                        $ro++;
                        $text = $val;
                    }elseif ($val == "R") {
                        $r++;
                        $text = $val;
                    }elseif ($val == "Đ") {
                        $d++;
                        $text = $val;
                    }elseif ($val == "V") {
                        $v++;
                        $text = $val;
                    }elseif ($val == "L") {
                        $l++;
                        $text = $val;
                    }else{
                        $text = ($val == 0) ? "" : $val;
                    }

                    if ($i < 25) {
                        if ($key % 2 == 0) {
                            $hours = $hours + $val;
                        }else{
                            if (date("w",strtotime(($i+1).'-'.$month.'-'.$year)) != 0) {
                                $overTime = $overTime + $val;
                            }else{
                                $overTimeSunDay = $overTimeSunDay + $val;
                            }

                        }

                        $this->excel->getActiveSheet()->SetCellValue(chr($ordColA+$countHeadOnceDetail).$countRow, $text);

                        if (date("w",strtotime(($i+1).'-'.$month.'-'.$year)) == 0) {
                            $this->excel->getActiveSheet()->getStyle(chr($ordColA+$countHeadOnceDetail).$countRow)->applyFromArray($styleSunday);
                        }
                        $countHeadOnceDetail++;
                    }else{
                        if ($key % 2 == 0) {
                            $hours = $hours + $val;
                        }else{
                            if (date("w",strtotime(($i+1).'-'.$month.'-'.$year)) != 0) {
                                $overTime = $overTime + $val;
                            }else{
                                $overTimeSunDay = $overTimeSunDay + $val;
                            }
                        }
                        if (date("w",strtotime(($i+1).'-'.$month.'-'.$year)) == 0) {
                            $this->excel->getActiveSheet()->getStyle('A'.chr($ordColA+$countHeadSecondDetail).$countRow)->applyFromArray($styleSunday);
                        }
                        $this->excel->getActiveSheet()->SetCellValue('A'.chr($ordColA+$countHeadSecondDetail).$countRow, $text);
                        $countHeadSecondDetail++;
                    }
                    $i++;
                }

                if ($key % 2 == 0) {
                    $total = $hours/8;
                    $this->excel->getActiveSheet()->SetCellValue('AG'.$countRow, $total);


                    $this->excel->getActiveSheet()->SetCellValue('AK'.$countRow, $p);
                    $this->excel->getActiveSheet()->SetCellValue('AL'.$countRow, $ro);
                    $this->excel->getActiveSheet()->SetCellValue('AM'.$countRow, $r);
                    $this->excel->getActiveSheet()->SetCellValue('AO'.$countRow, $d);
                    $this->excel->getActiveSheet()->SetCellValue('AQ'.$countRow, $v);
                    $this->excel->getActiveSheet()->SetCellValue('AR'.$countRow, $l);
                    $this->excel->getActiveSheet()->SetCellValue('AT'.$countRow, $this->sma->formatMoney($salaryEachDay*$total));
                }else{
                    $this->excel->getActiveSheet()->SetCellValue('AH'.($countRow-1), $overTimeSunDay);
                    $this->excel->getActiveSheet()->SetCellValue('AI'.($countRow-1), $overTime);

                    if (!empty($arrProductId)) {
                      $countRow++;
                      $this->excel->getActiveSheet()->SetCellValue('B'.$countRow, 'Đơn giá nguyên công');
                      $this->excel->getActiveSheet()->mergeCells('B'.$countRow.':I'.$countRow);
                      $this->excel->getActiveSheet()->getStyle('B'.$countRow.':I'.$countRow)->applyFromArray($styleSub);

                      $this->excel->getActiveSheet()->SetCellValue('J'.$countRow, 'Số lượng cấu thành');
                      $this->excel->getActiveSheet()->mergeCells('J'.$countRow.':Q'.$countRow);
                      $this->excel->getActiveSheet()->getStyle('J'.$countRow.':Q'.$countRow)->applyFromArray($styleSub);

                      $this->excel->getActiveSheet()->SetCellValue('R'.$countRow, 'Hoàn thành thực tế');
                      $this->excel->getActiveSheet()->mergeCells('R'.$countRow.':Y'.$countRow);
                      $this->excel->getActiveSheet()->getStyle('R'.$countRow.':Y'.$countRow)->applyFromArray($styleSub);

                      $this->excel->getActiveSheet()->SetCellValue('Z'.$countRow, 'Tổng tiền(VNĐ)');
                      $this->excel->getActiveSheet()->mergeCells('Z'.$countRow.':AF'.$countRow);
                      $this->excel->getActiveSheet()->getStyle('Z'.$countRow.':AF'.$countRow)->applyFromArray($styleSub);
                      foreach ($arrProductId as $productId) {
                        $soluonghoanthanh   = array();
                        $realCompleted      = 0;
                        $tmpIdProt          = null;
                        $sameEmp            = false;
                        $teamEmp            = array();
                        $currentWorkDay     = $arrInfoCompanies[$companyID]['workday'];
                        $currentEfficiency  = $arrInfoCompanies[$companyID]['efficiency'];
                        $moneyBonusProduct  = 0;

                        // var_dump($currentWorkDay);
                        // var_dump($currentEfficiency);
                        // echo "<pre>";
                        // print_r($productionsInMonthYear);
                        // echo "</pre>";
                        // die();

                        foreach ($productionsInMonthYear as $kProt => $production) {
                            if ($production->product_id == $productId) {

                                $tempEmp = explode(',', $production->employee);

                                if (($kProt != 0) && ($production->id != $tmpIdProt) && ($tmpIdProt != null)) {
                                    if ($sameEmp == true) {
                                        $min = min($soluonghoanthanh);
                                        $realCompleted = $realCompleted + $min;

                                        $countEmp = count($teamEmp);
                                        $totalWorkDay = 0;
                                        $totalEfficiency = 0;

                                        foreach ($teamEmp as $teamEmpId) {
                                            $totalWorkDay = $totalWorkDay + $arrInfoCompanies[$teamEmpId]['workday'];
                                            $totalEfficiency = $totalEfficiency + $arrInfoCompanies[$teamEmpId]['efficiency'];
                                        }

                                        $a  = $production->wage*$min*$countEmp;



                                        $b  = $totalWorkDay*$totalEfficiency;

                                        $moneyBonusProduct += (($a/$b) * $currentWorkDay * $currentEfficiency);
                                        // var_dump($moneyBonusProduct);die();
                                    }
                                    $sameEmp = false;

                                    $teamEmp = array();
                                    $soluonghoanthanh = array();
                                }


                                foreach ($tempEmp as $empId) {
                                    if ($empId == $companyID) {
                                        $sameEmp = true;
                                    }
                                    if (!in_array($empId, $teamEmp)) {
                                        $teamEmp[] = $empId;
                                    }
                                }

                                $tmpIdProt = $production->id;

                                $soluonghoanthanh[] = $production->soluonghoanthanh;
                            }
                        }
                        if ($sameEmp == true) {

                            $realCompleted = $realCompleted + min($soluonghoanthanh);

                            $min = min($soluonghoanthanh);
                            $countEmp = count($teamEmp);
                            $totalWorkDay = 0;
                            $totalEfficiency = 0;

                            foreach ($teamEmp as $teamEmpId) {
                                $totalWorkDay = $totalWorkDay + $arrInfoCompanies[$teamEmpId]['workday'];
                                $totalEfficiency = $$totalEfficiency + $arrInfoCompanies[$teamEmpId]['efficiency'];
                            }

                            $a  = $production->wage*$min*$countEmp;
                            $b  = $totalWorkDay*$totalEfficiency;

                            $moneyBonusProduct +=  (($a/$b) * $currentWorkDay * $currentEfficiency);
                            var_dump($moneyBonusProduct);
                            die();
                        }

                        $allInfoProduct[$productId]['realCompleted'] = $realCompleted;
                        $allInfoProduct[$productId]['moneyBonusProduct'] = $moneyBonusProduct;
                      }
                    }

                    // die('1');
                    $totalBonus = 0;
                    foreach ($allInfoProduct as $product) {

                        $countRow++;
                        $this->excel->getActiveSheet()->SetCellValue('A'.$countRow, $product['name']);
                        $this->excel->getActiveSheet()->getStyle('A'.$countRow)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
                        $this->excel->getActiveSheet()->getStyle('A'.$countRow)->applyFromArray($styleNameProduct);
                        $this->excel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);

                        $this->excel->getActiveSheet()->SetCellValue('B'.$countRow, $product['wage']);
                        $this->excel->getActiveSheet()->mergeCells('B'.$countRow.':I'.$countRow);

                        $this->excel->getActiveSheet()->SetCellValue('J'.$countRow, $product['quantity_config']);
                        $this->excel->getActiveSheet()->mergeCells('J'.$countRow.':Q'.$countRow);

                        $this->excel->getActiveSheet()->SetCellValue('R'.$countRow, $product['realCompleted']);
                        $this->excel->getActiveSheet()->mergeCells('R'.$countRow.':Y'.$countRow);

                        $totalProductBonus = $product['wage']*$product['realCompleted']*$product['quantity_config'];
                        $totalBonus = $totalBonus + $product['moneyBonusProduct'];

                        $this->excel->getActiveSheet()->SetCellValue('Z'.$countRow, $this->sma->formatMoney($product['moneyBonusProduct']));
                        $this->excel->getActiveSheet()->mergeCells('Z'.$countRow.':AF'.$countRow);

                    }

                    if (!empty($arrProductId)) {

                        $beyondRow = $countRow - (count($allInfoProduct) + 2);
                        $salaryWorkDay = $this->excel->getActiveSheet()->getCell('AT'.$beyondRow)->getValue();
                        $salaryWorkDay = (float)str_replace(',','',$salaryWorkDay);
                        $finalSalary =  $salaryWorkDay + $totalBonus;

                        $this->excel->getActiveSheet()->SetCellValue('AU'.$beyondRow, $this->sma->formatMoney($totalBonus));
                        $this->excel->getActiveSheet()->SetCellValue('AV'.$beyondRow, $this->sma->formatMoney($finalSalary));

                    }else{
                        $beyondRow = $countRow - 1;
                        $salaryWorkDay = $this->excel->getActiveSheet()->getCell('AT'.$beyondRow)->getValue();
                        $this->excel->getActiveSheet()->SetCellValue('AU'.$beyondRow, 0);
                        $this->excel->getActiveSheet()->SetCellValue('AV'.$beyondRow, $salaryWorkDay);
                    }
                }


                $countRow++;
            }

// END Init Rows

            $filename = 'salaries-view-'.$month.'-'.$year.'-'.$department_id;
            header('Content-Type: application/vnd.ms-excel');
            header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
            header('Cache-Control: max-age=0');
            ob_clean();
            $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
            $objWriter->save('php://output');

            exit();

        }else{
            $this->session->set_flashdata('error', lang('nothing_found'));
            redirect($_SERVER["HTTP_REFERER"]);
        }
    }

}

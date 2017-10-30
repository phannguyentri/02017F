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
        $this->load->model('salaries_model');

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
        $data['infoCompanies']          = $this->timekeepers_model->getInfoCompanies($department_id, $year, $month);
        $data['salaries']               = $this->salaries_model->getAllSalaries($year, $month);

        echo json_encode($data);
    }

    public function saveSalaries(){

        $month = $this->input->post('month');
        $year  = $this->input->post('year');
        $dataSalaries = $this->input->post('dataSalaries');

        $this->load->model('salaries_model');
        if ($this->salaries_model->save($dataSalaries, $month, $year)) {
            echo json_encode(array('status' => 'success'));
        }else{
            echo json_encode(array('status' => 'error'));
        }
    }


    public function xlsGeneral(){
        $department_id  = $this->input->get('department_id');
        $month          = $this->input->get('month');
        $year           = $this->input->get('year');


        if ($department_id && $month && $year) {
            $this->load->model('timekeepers_model');
            $this->load->model('productions_model');
            $this->load->model('departments_model');
            $this->load->model('salaries_model');

            $allInfoTimekeeperDetails = $this->timekeepers_model->getAllInfoTimekeeperDetails($department_id, $year, $month);

            if ($this->departments_model->isProductionById($department_id)) {
                $productionsInMonthYear = $this->productions_model->getProductionByYearMonth($year, $month);
            }

            $dataCompanyId      = $this->timekeepers_model->getCompanyIds($department_id, $year, $month);
            $dataName           = $this->timekeepers_model->getTimekeeperDetailsName($department_id, $year, $month);
            $dataSalaries       = $this->salaries_model->getAllSalaries($year, $month);
            $arrInfoCompanies   = $this->timekeepers_model->getInfoCompanies($department_id, $year, $month);
            if ($this->departments_model->isProductionById($department_id)) {
                $productionsInMonthYear = $this->productions_model->getProductionByYearMonth($year, $month);
            }

            $allInfoCompanies   = array();


            $onlyDayTimekeeperDetails = $this->timekeepers_model->getTimekeeperDetails($department_id, $year, $month);
            foreach ($dataCompanyId as $key => $val) {
                if ($key % 2 == 0) {
                    $hours          = 0;
                    $hoursOverTime  = 0;
                    $hoursSunday    = 0;

                    $i = 1;

                    foreach ($onlyDayTimekeeperDetails[$key+1] as $detail) {
                        if (date("w",strtotime($i.'-'.$month.'-'.$year)) != 0) {
                            $hoursOverTime += $detail;
                        }else{
                            $hoursSunday += $detail;
                        }
                        $i++;
                    }


                    foreach ($onlyDayTimekeeperDetails[$key] as $detail) {
                        $hours += $detail;
                    }

                    $allInfoCompanies[$val->company_id] = array(
                        'workday'         => $hours/8,
                        'hoursOverTime'   => $hoursOverTime,
                        'hoursSunday'     => $hoursSunday
                    );

                    foreach ($arrInfoCompanies[$key] as $kTitle => $info) {
                        $allInfoCompanies[$val->company_id][$kTitle] = $info;
                    }

                    foreach ($dataSalaries as $salary) {
                        if ($val->company_id == $salary->company_id) {
                            $allInfoCompanies[$val->company_id]['salaries'] = $salary;
                        }
                    }
                }
            }


            // echo "<pre>";
            // print_r($allInfoCompanies);
            // echo "</pre>";die();


            $dayWorkInMonth = 0;
            for ($i=0; $i < cal_days_in_month(CAL_GREGORIAN, $month, $year); $i++) {
                if (date("w",strtotime(($i+1).'-'.$month.'-'.$year)) != 0) {
                    $dayWorkInMonth++;
                }
            }

            $this->load->library('excel');
            $this->excel->setActiveSheetIndex(0);

            // Init Head
            $styleDefault = array(
                'font' => array(
                    'name'  => "Times New Roman",
                    'size'  => 10
                ),
                'borders' => array(
                ),
                'alignment' => array(
                    'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                    'wrap' => true
                )
            );

            $styleTitle = array(
                'font'  => array(
                    'bold'  => true,
                    'size'  => 15,
                    'name' => "Times New Roman"
                ),
                'borders' => array(
                    'allborders' => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN
                    )
                )
            );

            $colorRed = array(
                'font'  => array(
                    'color' => array('rgb' => 'ff0000'),
                    'bold'  => true
                ),
                'borders' => array(
                    'allborders' => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN
                    )
                ),
            );

            $styleBold = array(
                'font'  => array(
                    'bold'  => true
                ),
                'borders' => array(
                    'allborders' => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN
                    )
                ),
            );

            $styleStatic = array(
                'fill' => array(
                    'type' => PHPExcel_Style_Fill::FILL_SOLID,
                    'color' => array('rgb' => 'c2e3f4')
                ),
                'borders' => array(
                  'allborders' => array(
                      'style' => PHPExcel_Style_Border::BORDER_THIN
                  )
                )
            );


            $this->excel->getDefaultStyle()->applyFromArray($styleDefault);

            $this->excel->getActiveSheet()->setTitle('Bảng tính lương');

            $this->excel->getActiveSheet()->SetCellValue('A1', 'Bảng tính lương tháng '.$month.' năm '.$year.' phòng ban');
            $this->excel->getActiveSheet()->mergeCells('A1:M1');
            $this->excel->getActiveSheet()->getStyle("A1:M1")->applyFromArray($styleTitle);

            $this->excel->getActiveSheet()->SetCellValue('A2', 'STT');
            $this->excel->getActiveSheet()->mergeCells('A2:A4');

            $this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(25);
            $this->excel->getActiveSheet()->SetCellValue('B2', 'Họ và tên');
            $this->excel->getActiveSheet()->mergeCells('B2:B4');

            $this->excel->getActiveSheet()->SetCellValue('C2', 'Chức danh');
            $this->excel->getActiveSheet()->mergeCells('C2:C4');


            $this->excel->getActiveSheet()->SetCellValue('D2', 'Lương đóng BHXH');
            $this->excel->getActiveSheet()->mergeCells('D2:D4');
            $this->excel->getActiveSheet()->getColumnDimension('D')->setAutoSize(true);

            $this->excel->getActiveSheet()->SetCellValue('E2', 'Ngày công làm việc');
            $this->excel->getActiveSheet()->mergeCells('E2:E4');
            $this->excel->getActiveSheet()->getStyle("E2:E4")->applyFromArray($colorRed);

            $this->excel->getActiveSheet()->SetCellValue('F2', 'Hệ số HTCV');
            $this->excel->getActiveSheet()->mergeCells('F2:F4');



            $this->excel->getActiveSheet()->SetCellValue('G2', 'Hệ số');
            $this->excel->getActiveSheet()->mergeCells('G2:M2');


            $this->excel->getActiveSheet()->SetCellValue('G3', 'Lương và các khoản phụ cấp lương');
            $this->excel->getActiveSheet()->mergeCells('G3:I3');

            $this->excel->getActiveSheet()->SetCellValue('J3', 'Thâm niên');
            $this->excel->getActiveSheet()->mergeCells('J3:K3');


            $this->excel->getActiveSheet()->SetCellValue('L3', 'H.Suất');
            $this->excel->getActiveSheet()->mergeCells('L3:M3');

            $this->excel->getActiveSheet()->SetCellValue('G4', 'Hệ số lương');

            $this->excel->getActiveSheet()->SetCellValue('H4', 'HS quản lý');

            $this->excel->getActiveSheet()->SetCellValue('I4', 'HS kỹ năng chuyên môn');

            $this->excel->getActiveSheet()->getColumnDimension('G')->setWidth(12);
            $this->excel->getActiveSheet()->getColumnDimension('H')->setWidth(12);
            $this->excel->getActiveSheet()->getColumnDimension('I')->setWidth(12);

            $this->excel->getActiveSheet()->SetCellValue('J4', 'Hệ số');

            $this->excel->getActiveSheet()->SetCellValue('K4', '%');

            $this->excel->getActiveSheet()->SetCellValue('L4', 'Hệ số');

            $this->excel->getActiveSheet()->SetCellValue('M4', '%');

            $this->excel->getActiveSheet()->freezePane('N2');

            $this->excel->getActiveSheet()->SetCellValue('N2', 'Lương cơ bản, phụ cấp');
            $this->excel->getActiveSheet()->mergeCells('N2:U2');
            $this->excel->getActiveSheet()->getColumnDimension('N')->setAutoSize(true);

            $this->excel->getActiveSheet()->SetCellValue('N3', 'Mức lương');
            $this->excel->getActiveSheet()->mergeCells('N3:N4');
            $this->excel->getActiveSheet()->getColumnDimension('N')->setWidth(20);


            $this->excel->getActiveSheet()->SetCellValue('O3', 'Lương quản lý');
            $this->excel->getActiveSheet()->mergeCells('O3:O4');
            $this->excel->getActiveSheet()->getColumnDimension('O')->setAutoSize(true);

            $this->excel->getActiveSheet()->SetCellValue('P3', 'Lương kỹ năng chuyên môn');
            $this->excel->getActiveSheet()->mergeCells('P3:P4');
            $this->excel->getActiveSheet()->getColumnDimension('P')->setWidth(14);

            $this->excel->getActiveSheet()->SetCellValue('Q3', 'Thâm niên');
            $this->excel->getActiveSheet()->mergeCells('Q3:Q4');
            $this->excel->getActiveSheet()->getColumnDimension('Q')->setWidth(15);

            $this->excel->getActiveSheet()->SetCellValue('R3', 'Lương hiệu suất');
            $this->excel->getActiveSheet()->mergeCells('R3:R4');
            $this->excel->getActiveSheet()->getColumnDimension('R')->setWidth(12);

            $this->excel->getActiveSheet()->SetCellValue('S3', 'Công tác phí, ĐT+ Đồng phục + Nhà ở + Đi lại');
            $this->excel->getActiveSheet()->mergeCells('S3:S4');
            $this->excel->getActiveSheet()->getColumnDimension('S')->setWidth(16);

            $this->excel->getActiveSheet()->SetCellValue('T3', 'Chuyên cần');
            $this->excel->getActiveSheet()->mergeCells('T3:T4');
            $this->excel->getActiveSheet()->getColumnDimension('T')->setWidth(12);

            $this->excel->getActiveSheet()->SetCellValue('U3', 'Thu hút');
            $this->excel->getActiveSheet()->mergeCells('U3:U4');

            $this->excel->getActiveSheet()->SetCellValue('V2', 'Tăng ca');
            $this->excel->getActiveSheet()->mergeCells('V2:W2');

            $this->excel->getActiveSheet()->SetCellValue('V3', 'Số giờ tăng ca');
            $this->excel->getActiveSheet()->mergeCells('V3:V4');
            $this->excel->getActiveSheet()->getStyle("V3:V4")->applyFromArray($colorRed);

            $this->excel->getActiveSheet()->SetCellValue('W3', 'Thành tiền');
            $this->excel->getActiveSheet()->mergeCells('W3:W4');
            $this->excel->getActiveSheet()->getColumnDimension('W')->setWidth(12);

            $this->excel->getActiveSheet()->SetCellValue('X2', 'Ngày Chủ Nhật');
            $this->excel->getActiveSheet()->mergeCells('X2:Y2');

            $this->excel->getActiveSheet()->SetCellValue('X3', 'Số giờ làm thêm');
            $this->excel->getActiveSheet()->mergeCells('X3:X4');
            $this->excel->getActiveSheet()->getStyle("X3:X4")->applyFromArray($colorRed);

            $this->excel->getActiveSheet()->SetCellValue('Y3', 'Thành tiền');
            $this->excel->getActiveSheet()->mergeCells('Y3:Y4');
            $this->excel->getActiveSheet()->getColumnDimension('Y')->setWidth(12);

            $this->excel->getActiveSheet()->SetCellValue('Z2', 'Tổng tiền lương theo hệ số HTCV(100%)');
            $this->excel->getActiveSheet()->mergeCells('Z2:Z4');
            $this->excel->getActiveSheet()->getColumnDimension('Z')->setWidth(18);


            $this->excel->getActiveSheet()->SetCellValue('AA2', 'Các khoản thu nhập khác');
            $this->excel->getActiveSheet()->mergeCells('AA2:AD2');

            $this->excel->getActiveSheet()->SetCellValue('AA3', 'Tiền ăn giữa ca');
            $this->excel->getActiveSheet()->mergeCells('AA3:AC3');

            $this->excel->getActiveSheet()->SetCellValue('AA4', 'Số suất ăn');

            $this->excel->getActiveSheet()->SetCellValue('AB4', 'Thành tiền');

            $this->excel->getActiveSheet()->SetCellValue('AC4', 'Tiền ăn tăng ca');

            $this->excel->getActiveSheet()->SetCellValue('AD3', '18%BHXH, 3%BHYT, 2%KPCN, 1%BHTN (24%)');
            $this->excel->getActiveSheet()->mergeCells('AD3:AD4');

            $this->excel->getActiveSheet()->getColumnDimension('AA')->setWidth(12);
            $this->excel->getActiveSheet()->getColumnDimension('AB')->setWidth(12);
            $this->excel->getActiveSheet()->getColumnDimension('AC')->setWidth(12);
            $this->excel->getActiveSheet()->getColumnDimension('AD')->setWidth(12);

            $this->excel->getActiveSheet()->SetCellValue('AE2', 'Tổng thu nhập');
            $this->excel->getActiveSheet()->mergeCells('AE2:AE4');
            $this->excel->getActiveSheet()->getStyle('AE2:AE4')->applyFromArray($styleBold);
            $this->excel->getActiveSheet()->getColumnDimension('AE')->setAutoSize(true);

            $this->excel->getActiveSheet()->SetCellValue('AF2', 'Thuế TNCN');
            $this->excel->getActiveSheet()->mergeCells('AF2:AG2');

            $this->excel->getActiveSheet()->SetCellValue('AF3', 'Giảm trừ gia cảnh');


            $this->excel->getActiveSheet()->SetCellValue('AG3', 'Thu nhập chịu thuế');
            $this->excel->getActiveSheet()->mergeCells('AG3:AG4');

            $this->excel->getActiveSheet()->getColumnDimension('AF')->setWidth(18);
            $this->excel->getActiveSheet()->getColumnDimension('AG')->setWidth(18);

            $this->excel->getActiveSheet()->SetCellValue('AH2', 'Các khoản phải thu');
            $this->excel->getActiveSheet()->mergeCells('AH2:AK2');

            $this->excel->getActiveSheet()->SetCellValue('AH3', 'TỨ đợt 1');
            $this->excel->getActiveSheet()->mergeCells('AH3:AH4');

            $this->excel->getActiveSheet()->SetCellValue('AI3', '8%BHXH, 1.5%BHYT 1%BHTN (10.5%)');
            $this->excel->getActiveSheet()->mergeCells('AI3:AI4');
            $this->excel->getActiveSheet()->getColumnDimension('AI')->setWidth(13);

            $this->excel->getActiveSheet()->SetCellValue('AJ3', 'Thuế TNCN');
            $this->excel->getActiveSheet()->mergeCells('AJ3:AJ4');
            $this->excel->getActiveSheet()->getColumnDimension('AJ')->setAutoSize(true);

            $this->excel->getActiveSheet()->SetCellValue('AK3', 'Cộng');
            $this->excel->getActiveSheet()->mergeCells('AK3:AK4');
            $this->excel->getActiveSheet()->getColumnDimension('AK')->setAutoSize(true);

            $this->excel->getActiveSheet()->SetCellValue('AL2', 'Tổng lương sản phẩm');
            $this->excel->getActiveSheet()->mergeCells('AL2:AL4');
            $this->excel->getActiveSheet()->getStyle('AL2:AL4')->applyFromArray($styleBold);

            $this->excel->getActiveSheet()->SetCellValue('AM2', 'Tiền lương được lĩnh');
            $this->excel->getActiveSheet()->mergeCells('AM2:AM4');
            $this->excel->getActiveSheet()->getStyle('AM2:AM4')->applyFromArray($styleBold);
            $this->excel->getActiveSheet()->getColumnDimension('AM')->setAutoSize(true);

            $this->excel->getActiveSheet()->SetCellValue('AN2', 'Ký nhận');
            $this->excel->getActiveSheet()->mergeCells('AN2:AN4');
            $this->excel->getActiveSheet()->getColumnDimension('AN')->setWidth(11);

            $this->excel->getActiveSheet()->SetCellValue('AO2', 'Tổng lương');
            $this->excel->getActiveSheet()->mergeCells('AO2:AO4');
            $this->excel->getActiveSheet()->getStyle('AO2:AO4')->applyFromArray($styleBold);

            // END Init Rows

            $i = 1;
            $row = 4;

            foreach ($allInfoCompanies as $key => $info) {
                $row++;
                $realBasicSalary = $info['basic_salary']*$info['coefficient_salary'];
                $companyID = $key;




                $arrProductId = array();

                if ($productionsInMonthYear) {
                  foreach ($productionsInMonthYear as $production) {
                    $empIds = explode(',', $production->employee);
                    foreach ($empIds as $emp) {
                      if ($emp == $companyID) {
                        if (!in_array($production->product_id, $arrProductId)) {
                          $arrProductId[] = $production->product_id;
                        }
                      }
                    }
                  }
                }

                if (!empty($arrProductId)) {
                    foreach ($arrProductId as $productId) {
                        $soluonghoanthanh   = array();
                        $realCompleted      = 0;
                        $tmpIdProt          = null;
                        $sameEmp            = false;
                        $teamEmp            = array();
                        $currentWorkDay     = $info['workday'];
                        $currentEfficiency  = $info['efficiency'];
                        $moneyBonusProduct  = 0;
                    }

                    foreach ($productionsInMonthYear as $kProt => $production) {
                        if ($production->product_id == $productId) {

                            $tempEmp = explode(',', $production->employee);
                            $currentWage = $production->wage;

                            if (($kProt != 0) && ($production->id != $tmpIdProt) && ($tmpIdProt != null)) {
                                if ($sameEmp == true) {
                                    $min = min($soluonghoanthanh);
                                    $realCompleted = $realCompleted + $min;

                                    $countEmp = count($teamEmp);
                                    $totalWorkDay = 0;
                                    $totalEfficiency = 0;

                                    foreach ($teamEmp as $teamEmpId) {
                                        $totalWorkDay = $totalWorkDay + $allInfoCompanies[$teamEmpId]['workday'];
                                        $totalEfficiency = $totalEfficiency + $allInfoCompanies[$teamEmpId]['efficiency'];
                                    }

                                    $a  = $currentWage*$min*$countEmp;

                                    $b  = $totalWorkDay*$totalEfficiency;

                                    $moneyBonusProduct += (($a/$b) * $currentWorkDay * $currentEfficiency);

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
                            $totalWorkDay = $totalWorkDay + $allInfoCompanies[$teamEmpId]['workday'];
                            $totalEfficiency = $totalEfficiency + $allInfoCompanies[$teamEmpId]['efficiency'];
                        }

                        $a  = $currentWage*$min*$countEmp;
                        $b  = $totalWorkDay*$totalEfficiency;

                        $moneyBonusProduct += (($a/$b) * $currentWorkDay * $currentEfficiency);

                    }
                    // echo "<pre>";
                    // print_r($moneyBonusProduct);
                    // echo "</pre>";die();
                }



                $this->excel->getActiveSheet()->SetCellValue('A'.$row, $i);
                $this->excel->getActiveSheet()->SetCellValue('B'.$row, $info['name']);
                $this->excel->getActiveSheet()->getStyle('B'.$row)->getAlignment()
                 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
                $this->excel->getActiveSheet()->SetCellValue('D'.$row, $this->sma->formatMoney($this->checkZero($info['social_insurance'])));
                $this->excel->getActiveSheet()->SetCellValue('E'.$row, $info['workday']);
                $this->excel->getActiveSheet()->getStyle('E'.$row)->applyFromArray($colorRed);
                $this->excel->getActiveSheet()->SetCellValue('F'.$row, $this->checkZero($info['coefficient_htcv']));
                $this->excel->getActiveSheet()->SetCellValue('G'.$row, $this->checkZero($info['coefficient_salary']));
                $this->excel->getActiveSheet()->SetCellValue('H'.$row, $this->checkZero($info['coefficient_manage']));
                $this->excel->getActiveSheet()->SetCellValue('I'.$row, $this->checkZero($info['coefficient_specialize']));
                $this->excel->getActiveSheet()->SetCellValue('J'.$row, $this->checkZero($info['coefficient_seniority']));
                $this->excel->getActiveSheet()->SetCellValue('K'.$row, $this->checkZero($info['percent_seniority']));
                $this->excel->getActiveSheet()->SetCellValue('L'.$row, $this->checkZero($info['efficiency']));
                $this->excel->getActiveSheet()->SetCellValue('M'.$row, $this->checkZero($info['percent_efficiency']));

                $wageSalary         = $info['coefficient_salary']*$realBasicSalary/$dayWorkInMonth*$info['workday']*$info['coefficient_htcv'];
                $manageSalary       = $info['coefficient_manage']*$realBasicSalary/$dayWorkInMonth*$info['workday']*$info['coefficient_htcv'];
                $specializeSalary   = $info['coefficient_specialize']*500000/$dayWorkInMonth*$info['workday']*$info['coefficient_htcv'];
                $senioritySalary    = $info['coefficient_seniority']*500000/$dayWorkInMonth*$info['workday']*$info['coefficient_htcv']*$info['percent_seniority'];
                $efficiencySalary   = $info['efficiency']*500000*$info['percent_efficiency']*$info['workday']/$dayWorkInMonth;
                $overTimeSalary     = ($wageSalary/$dayWorkInMonth/8)*1.5*$info['hoursOverTime'] + ($specializeSalary/$dayWorkInMonth/8*$info['hoursOverTime']);
                $moreTimeSalary     = ($wageSalary/$dayWorkInMonth/8)*2*$info['hoursSunday'] + ($specializeSalary/$dayWorkInMonth/8*$info['hoursSunday']);

                $checkSalaries = ($info['salaries']) ? true : false;

                if ($checkSalaries) {

                    $otherCosts     = ($info['salaries']->other_costs) ? $info['salaries']->other_costs : 0;
                    $diligence      = ($info['salaries']->diligence) ? $info['salaries']->diligence : 0;
                    $attractive     = ($info['salaries']->attractive) ? $info['salaries']->attractive : 0;

                    if ($info['salaries']->set_eat == null) {
                        if (($info['workday'] - floor($info['workday']) == 0.5)) {
                            $numberSetEat = floor($info['workday']);
                        }else{
                            $numberSetEat = round($info['workday']);
                        }
                    }else{
                        $numberSetEat   = $info['salaries']->set_eat;
                    }

                    $moneyEatOverTime   = $info['salaries']->money_eat_overtime;
                    $familyAllowances   = $info['salaries']->family_allowances;
                    $advancePayment     = $info['salaries']->advance_payment;
                }else{
                    $otherCosts         = 0;
                    $diligence          = 0;
                    $attractive         = 0;
                    $numberSetEat       = round($info['workday']);
                    $moneyEatOverTime   = 0;
                    $familyAllowances   = 0;
                    $advancePayment     = 0;
                }

                // die();
                $totalHTCV          = $wageSalary+$manageSalary+$specializeSalary+$senioritySalary
                 +$efficiencySalary+$otherCosts+$diligence+$attractive+$overTimeSalary+$moreTimeSalary;
                $moneyEat           = $numberSetEat*15000;
                $socialInsurance    = $info['social_insurance']*0.24;
                $totalIncome        = $totalHTCV+$moneyEat+$moneyEatOverTime+$socialInsurance;
                $socialInsurance2   = $info['social_insurance']*0.15;
                $personalIncomeTax  = $totalHTCV-$socialInsurance2-9000000-$familyAllowances;
                $personalIncomeTax2 = $this->calculatorTNCN($personalIncomeTax);
                $sumAJ              = $advancePayment+$socialInsurance2+$personalIncomeTax2;
                $salaryReceive      = $totalIncome-$socialInsurance-$sumAJ;

                $this->excel->getActiveSheet()->SetCellValue('N'.$row, $this->checkZero($wageSalary, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('O'.$row, $this->checkZero($manageSalary, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('P'.$row, $this->checkZero($specializeSalary, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('Q'.$row, $this->checkZero($senioritySalary, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('R'.$row, $this->checkZero($efficiencySalary, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('S'.$row, $this->checkZero($other_costs, '-'));
                $this->excel->getActiveSheet()->SetCellValue('T'.$row, $this->checkZero($diligence, '-'));
                $this->excel->getActiveSheet()->SetCellValue('U'.$row, $this->checkZero($attractive, '-'));
                $this->excel->getActiveSheet()->SetCellValue('V'.$row, $this->checkZero($info['hoursOverTime'], '-'));
                $this->excel->getActiveSheet()->getStyle('V'.$row)->applyFromArray($colorRed);
                $this->excel->getActiveSheet()->SetCellValue('W'.$row, $this->checkZero($overTimeSalary, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('X'.$row, $this->checkZero($info['hoursSunday'], '-'));
                $this->excel->getActiveSheet()->getStyle('X'.$row)->applyFromArray($colorRed);
                $this->excel->getActiveSheet()->SetCellValue('Y'.$row, $this->checkZero($moreTimeSalary, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('Z'.$row, $this->checkZero($totalHTCV, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AA'.$row, $this->checkZero($numberSetEat, '-'));
                $this->excel->getActiveSheet()->SetCellValue('AB'.$row, $this->checkZero($moneyEat, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AC'.$row, $this->checkZero($moneyEatOverTime, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AD'.$row, $this->checkZero($socialInsurance, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AE'.$row, $this->checkZero($totalIncome, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AF'.$row, $this->checkZero($familyAllowances, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AG'.$row, $this->checkZero($personalIncomeTax, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AH'.$row, $this->checkZero($advancePayment, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AI'.$row, $this->checkZero($socialInsurance2, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AJ'.$row, $this->checkZero($personalIncomeTax2, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AK'.$row, $this->checkZero($sumAJ, '-', true));
                $this->excel->getActiveSheet()->SetCellValue('AM'.$row, $this->checkZero($salaryReceive, '-', true));
                /*----- to be continue -----*/


                $i++;

            }

            $this->excel->getActiveSheet()->getStyle('A2:'.'AO'.$row)->getBorders()->getAllBorders()
             ->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);
            $this->excel->getActiveSheet()->getStyle('G2:'.'M'.$row)->applyFromArray($styleStatic);


            $filename = 'salaries-general-view-'.$month.'-'.$year.'-'.$department_id;
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

//-------------------------------------------------------------------------------------------

    private function checkZero($number, $text = '', $optionFormat = false){
        if ($number == 0) {
            return $text;
        }
        return ($optionFormat) ? $this->sma->formatMoney($number) : $number;
    }

//-------------------------------------------------------------------------------------------
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


                        foreach ($productionsInMonthYear as $kProt => $production) {
                            if ($production->product_id == $productId) {


                                $tempEmp = explode(',', $production->employee);
                                $currentWage = $production->wage;

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

                                        $a  = $currentWage*$min*$countEmp;

                                        $b  = $totalWorkDay*$totalEfficiency;

                                        $moneyBonusProduct += (($a/$b) * $currentWorkDay * $currentEfficiency);

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
                                $totalEfficiency = $totalEfficiency + $arrInfoCompanies[$teamEmpId]['efficiency'];
                            }

                            $a  = $currentWage*$min*$countEmp;
                            $b  = $totalWorkDay*$totalEfficiency;

                            $moneyBonusProduct += (($a/$b) * $currentWorkDay * $currentEfficiency);

                        }

                        $allInfoProduct[$productId]['realCompleted'] = $realCompleted;
                        $allInfoProduct[$productId]['moneyBonusProduct'] = $moneyBonusProduct;
                      }
                    }


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

  private function calculatorTNCN($tncn){
    $a = 0;
    $b = 0;
    $c = 0;
    $d = 0;
    if ($tncn < 0 ) {
      $a = 0;
    }else{
      if ($tncn <= 5000000) {
        $a = $tncn*0.05;
      }else{
        if ($tncn > 5000000 && $tncn <= 10000000) {
          $a = 250000+($tncn-5000000)*0.1;
        }else{
          $a = 0;
        }
      }

    }

    if ($tncn > 10000000 && $tncn <= 18000000) {
      $b = 750000+($tncn - 10000000)*0.15;
    }

    if ($tncn > 18000000 && $tncn <= 32000000){
      $c = 1950000+($tncn-18000000)*0.2;
    }else{
      if ($tncn > 32000000 && $tncn <= 52000000) {
        $c = 4750000+($tncn-32000000)*0.25;
      }else{
        $c = 0;
      }
    }

    if ($tncn > 52000000 && $tncn <= 80000000) {
      $d = 9750000+($tncn-52000000)*0.30;
    }else{
      if ($tncn > 80000000) {
        $d = 18150000+($tncn-80000000)*0.35;
      }else{
        $d = 0;
      }
    }

    $total = $a+$b+$c+$d;

    return $total;
  }


}

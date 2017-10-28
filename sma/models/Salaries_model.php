<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Salaries_model extends CI_Model
{

  public function __construct()
  {
      parent::__construct();
  }

  public function save($data, $month, $year){
    foreach ($data as $keyCompanyId => $val) {
      if ($val) {
        if ($this->checkExist($keyCompanyId, $month, $year)) {
          $this->update($val, $keyCompanyId, $month, $year);
        }else{
          $val['company_id'] = $keyCompanyId;
          $val['month'] = $month;
          $val['year'] = $year;

          $this->insert($val);
        }
      }
    }
    return true; // test fail not yet

  }

  public function insert($data){
    if ($this->db->insert('salaries',$data)) {
      return true;
    }
    return false;
  }

  public function update($data, $company_id, $month, $year){
    if ($this->db->update('salaries',$data, array('company_id' => $company_id, 'month' => $month, 'year' => $year))) {
      return true;
    }
    return false;
  }

  public function checkExist($company_id, $month, $year){
    $q = $this->db->get_where('salaries', array('company_id' => $company_id, 'month' => $month, 'year' => $year), 1);
    if ($q->num_rows() > 0) {
        return true;
    }
    return false;
  }

  public function getAllSalaries($year, $month){
    $this->db->select('company_id, other_costs, diligence, attractive, set_eat, money_eat_overtime, advance_payment, family_allowances');

    $q = $this->db->get_where('salaries', array('month' => $month, 'year' => $year));
    if ($q->num_rows() > 0) {
        foreach (($q->result()) as $row) {
            $data[] = $row;
        }
        return $data;
    }
    return FALSE;
  }
}

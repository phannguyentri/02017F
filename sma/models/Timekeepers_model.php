<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Timekeepers_model extends CI_Model
{

  public function __construct()
  {
      parent::__construct();
  }

  public function getCompanyByNameAndDepartmentId($name, $department_id){
    $q = $this->db->get_where('companies', array('name' => $name, 'department_id' => $department_id), 1);
    if ($q->num_rows() > 0) {
        return $q->row();
    }
    return FALSE;
  }
}

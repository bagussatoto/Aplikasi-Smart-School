<?php
defined('BASEPATH') OR exit('No direct script access allowed');
// Enable remote image/CSS loading before loading dompdf config
if (!defined('DOMPDF_ENABLE_REMOTE')) {
    define('DOMPDF_ENABLE_REMOTE', TRUE);
}
require_once APPPATH . 'third_party/dompdf/dompdf_config.inc.php';

class Pdfgenerator {
    public function generate($html, $filename='', $paper = '', $orientation = '', $stream=TRUE)
    {
        $dompdf = new DOMPDF();
        $dompdf->load_html($html);
        if (!empty($paper)) {
            $dompdf->set_paper($paper, !empty($orientation) ? $orientation : 'portrait');
        }
        $dompdf->render();
        if ($stream) {
            $dompdf->stream($filename.".pdf", array("Attachment" => 0));
        } else {
            return $dompdf->output();
        }
    }
}
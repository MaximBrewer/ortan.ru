<?php
class ControllerToolCleaner extends Controller
{
	public function index()
	{
		// $this->load->model('tool/files');


		// $rows = $this->model_tool_files->getImportProductImages();
		// foreach ($rows as $row) {
		// 	mkdir(dirname(DIR_LOGS . 'images/' . $row['image']), 0777, true);
		// 	file_put_contents(DIR_LOGS . 'images/' . $row['image'], ``);
		// }
		// $rows = $this->model_tool_files->getImportProductImagesImages();
		// foreach ($rows as $row) {
		// 	mkdir(dirname(DIR_LOGS . 'images/' . $row['image']), 0777, true);
		// 	file_put_contents(DIR_LOGS . 'images/' . $row['image'], ``);
		// }

		$cnt = 0;
		foreach (glob(DIR_IMAGE . "catalog/tovary2/**/*") as $filename) {
			echo "$filename размер " . filesize($filename) . "<br/>";
			echo str_replace(DIR_IMAGE, DIR_LOGS, $filename) . "<br/>";
			echo is_file(str_replace(DIR_IMAGE, DIR_LOGS, $filename)) . "<br/>";
			if(!is_file(str_replace(DIR_IMAGE, DIR_LOGS, $filename))) unlink($filename);
			// if (++$cnt > 100) break;
		}
	}
}

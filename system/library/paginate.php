<?php
class Paginate
{
	public $total = 0;
	public $page = 1;
	public $limit = 20;
	public $num_links = 8;
	public $url = '';
	public $text_first = '|&lt;';
	public $text_last = '&gt;|';
	public $text_next = '&gt;';
	public $text_prev = '&lt;';

	public function render()
	{
		$total = $this->total;

		if ($this->page < 1) {
			$page = 1;
		} else {
			$page = $this->page;
		}

		if (!(int)$this->limit) {
			$limit = 10;
		} else {
			$limit = $this->limit;
		}

		$num_links = $this->num_links;
		$num_pages = ceil($total / $limit);

		$this->url = str_replace('%7Bpage%7D', '{page}', $this->url);

		$output = '<div class="goodsin__pagination">';

		if ($page > 1) {
			$output .= '<a href="' . str_replace(array('&amp;page={page}', '?page={page}', '&page={page}'), '', $this->url) . '"><svg class="goodsin__arrow goodsin__arrow_prev" width="22" height="11" viewBox="0 0 22 11" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0.252064 6.2802C0.252322 6.28045 0.252537 6.28076 0.252839 6.28101L4.74324 10.7498C5.07964 11.0845 5.62376 11.0833 5.95861 10.7468C6.29342 10.4104 6.29214 9.86632 5.95573 9.53151L2.94087 6.53126L21.1406 6.53126C21.6153 6.53126 22 6.14652 22 5.67189C22 5.19726 21.6153 4.81252 21.1406 4.81252L2.94092 4.81252L5.95569 1.81227C6.29209 1.47746 6.29338 0.933351 5.95857 0.59695C5.62372 0.260462 5.07956 0.259303 4.7432 0.594028L0.252795 5.06277C0.252537 5.06302 0.252322 5.06332 0.25202 5.06358C-0.0845523 5.39951 -0.0834785 5.94538 0.252064 6.2802Z"fill="#323031" /></svg></a>';
		}

		$output .= '<ul class="goodsin__pages">';
		if ($num_pages > 1) {
			if ($num_pages <= $num_links) {
				$start = 1;
				$end = $num_pages;
			} else {
				$start = $page - floor($num_links / 2);
				$end = $page + floor($num_links / 2);

				if ($start < 1) {
					$end += abs($start) + 1;
					$start = 1;
				}

				if ($end > $num_pages) {
					$start -= ($end - $num_pages);
					$end = $num_pages;
				}
			}

			for ($i = (int)$start; $i <= $end; $i++) {
				if ($page == $i) {
					$output .= '<li class="goodsin__page active"><span>' . $i . '</span></li>';
				} else {
					if ($i === 1) {
						$output .= '<li class="goodsin__page"><a href="' . str_replace(array('&amp;page={page}', '?page={page}', '&page={page}'), '', $this->url) . '">' . $i . '</a></li>';
					} else {
						$output .= '<li class="goodsin__page"><a href="' . str_replace('{page}', $i, $this->url) . '">' . $i . '</a></li>';
					}
				}
			}
		}
		$output .= '</ul>';

		if ($page < $num_pages) {
			$output .= '<a href="' . str_replace('{page}', $page + 1, $this->url) . '"><svg class="goodsin__arrow goodsin__arrow_next" width="22" height="11" viewBox="0 0 22 11" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M21.7479 4.7198C21.7477 4.71954 21.7475 4.71924 21.7472 4.71899L17.2568 0.250247C16.9204 -0.0845221 16.3762 -0.0832763 16.0414 0.253168C15.7066 0.58957 15.7079 1.13368 16.0443 1.46849L19.0591 4.46874L0.859375 4.46874C0.384742 4.46874 0 4.85348 0 5.32811C0 5.80274 0.384742 6.18748 0.859375 6.18748L19.0591 6.18748L16.0443 9.18772C15.7079 9.52254 15.7066 10.0666 16.0414 10.403C16.3763 10.7395 16.9204 10.7407 17.2568 10.406L21.7472 5.93723C21.7475 5.93697 21.7477 5.93667 21.748 5.93642C22.0846 5.60049 22.0835 5.05461 21.7479 4.7198Z" fill="#323031" /></svg></a>';
		}

		$output .= '</div>';

		if ($num_pages > 1) {
			return $output;
		} else {
			return '';
		}
	}
}

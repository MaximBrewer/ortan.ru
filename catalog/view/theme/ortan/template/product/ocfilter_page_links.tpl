<!DOCTYPE html>
<html dir="ltr" lang="ru">
<head>
	<meta charset="UTF-8" />
	<meta name="robots" content="noindex" />
	<title>OCFilter links</title>
</head>
<body>
	<div id="content">
	    <?php foreach ($links as $link) { ?>
			<?php echo $link['i']?>. <?php echo $link['url']?><br />
		<?php } ?>
	</div>
</body>
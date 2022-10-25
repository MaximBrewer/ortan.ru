<?php if(!empty($categories)) { ?>
<div class="catalog__filter filter subcategory-links" style="margin-bottom:30px">
    <p class="filter__heading">ПОДКАТЕГОРИИ: </p>
    <div class="size__form">
    <?php foreach ($categories as $category) { ?>
    <a href="<?php echo $category['href']; ?>" class="size__checkName" style="text-decoration:none;">
    	<img src="<?php echo $category['thumb']; ?>" alt="<?php echo htmlspecialchars($category['name']); ?>" width="40" height="40" />
    	<span>
    	<?php echo $category['name']; ?>
    	</span>	
    	</a>
    <?php } ?>
</div>
</div>

<?php } ?>
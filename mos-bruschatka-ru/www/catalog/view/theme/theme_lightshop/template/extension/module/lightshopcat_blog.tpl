<?php if (!empty($blogcategories)) { ?>
	<div class="blog-widget card">
		<h3 class="blog-widget__title"><?php echo $heading_title; ?></h3>
		<div class="blog-widget__list">								
			<ul class="list-unstyled">
			<?php foreach ($blogcategories as $category) { ?>
				<li class="blog-widget__list-item text-uppercase text-sm text--bold text--color-4 <?php echo ($category['href'] === "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]") ? 'is-current' : ''; ?>">
					<a href = "<?php echo $category['href']; ?>" class="blog-widget__link"><?php echo $category['name']; ?></a>
					<span class="count" ><?php echo $category['count']; ?></span>
				</li>
			<?php } ?>	
			</ul>
		</div>
	</div>
<?php } ?>